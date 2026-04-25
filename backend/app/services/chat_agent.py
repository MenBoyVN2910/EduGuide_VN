"""
Bộ điều phối Chat (Chat Agent Orchestrator) — Điểm vào chính cho việc xử lý tin nhắn chat.
Điều hướng tin nhắn qua luồng: Intent (Ý định) → Strategy (Chiến lược) → Neo4j → Answer (Câu trả lời).
Bao gồm bộ nhớ đệm LRU và hỗ trợ hội thoại nhiều lượt.
"""

import logging
import hashlib
import time
from collections import OrderedDict

from app.core.neo4j_db import neo4j_db
from app.services.intent_classifier import Intent, classify_intent
from app.services.cypher_generator import (
    generate_template_cypher,
    generate_llm_cypher,
    generate_fallback_cypher,
    extract_keywords,
)
from app.services.answer_generator import generate_answer
from app.services.schema_metadata import (
    GREETING_RESPONSES,
    FAREWELL_RESPONSES,
    THANKS_RESPONSES,
    UNRELATED_RESPONSE,
    NO_DATA_RESPONSE,
    get_university_overview,
    get_major_overview,
    get_study_path_text,
    get_elective_groups_text,
)
from app.core.config import settings

logger = logging.getLogger("chat_agent")
logging.basicConfig(level=logging.INFO)


# ═══════════════════════════════════════════════════════════════════════
#  LRU Cache cho kết quả truy vấn Cypher
# ═══════════════════════════════════════════════════════════════════════
class QueryCache:
    """Bộ nhớ đệm LRU đơn giản với TTL (thời gian sống) cho kết quả Neo4j."""

    def __init__(self, max_size: int = 256, ttl: int = 600):
        self._cache: OrderedDict[str, tuple[float, list]] = OrderedDict()
        self._max_size = max_size
        self._ttl = ttl
        self._hits = 0
        self._misses = 0

    def _make_key(self, query: str, params: dict | None) -> str:
        """Tạo khóa hash duy nhất cho mỗi câu truy vấn và tham số."""
        raw = f"{query}|{sorted((params or {}).items())}"
        return hashlib.md5(raw.encode()).hexdigest()

    def get(self, query: str, params: dict | None = None) -> list | None:
        """Lấy dữ liệu từ cache nếu chưa hết hạn."""
        key = self._make_key(query, params)
        if key in self._cache:
            ts, data = self._cache[key]
            if time.time() - ts < self._ttl:
                self._cache.move_to_end(key)
                self._hits += 1
                return data
            else:
                del self._cache[key]
        self._misses += 1
        return None

    def put(self, query: str, params: dict | None, data: list) -> None:
        """Lưu dữ liệu vào cache, tự động xóa bản ghi cũ nhất nếu vượt quá giới hạn."""
        key = self._make_key(query, params)
        self._cache[key] = (time.time(), data)
        self._cache.move_to_end(key)
        if len(self._cache) > self._max_size:
            self._cache.popitem(last=False)

    @property
    def stats(self) -> dict:
        """Trả về thống kê hiệu quả của bộ nhớ đệm."""
        return {
            "size": len(self._cache),
            "hits": self._hits,
            "misses": self._misses,
            "hit_rate": (
                f"{self._hits / (self._hits + self._misses) * 100:.1f}%"
                if (self._hits + self._misses) > 0
                else "N/A"
            ),
        }


# Khởi tạo cache toàn cục dựa trên cấu hình settings
_cache = QueryCache(
    max_size=settings.CACHE_MAX_SIZE,
    ttl=settings.CACHE_TTL_SECONDS,
)


# ═══════════════════════════════════════════════════════════════════════
#  Thực thi truy vấn Neo4j (kèm Cache)
# ═══════════════════════════════════════════════════════════════════════
def _execute_cypher(query: str, params: dict | None = None) -> list[dict] | None:
    """Thực thi Cypher với cơ chế cache. Trả về danh sách dict hoặc None nếu lỗi."""
    # Kiểm tra cache trước
    cached = _cache.get(query, params)
    if cached is not None:
        logger.info("[CACHE-HIT] Trả về kết quả từ cache (%d bản ghi)", len(cached))
        return cached

    try:
        # Gọi xuống lớp core để truy vấn thực tế
        records = neo4j_db.execute_query(query, params)
        if records:
            _cache.put(query, params, records)
        return records
    except Exception as e:
        logger.error("[NEO4J-EXEC] Lỗi thực thi: %s\n  Câu lệnh: %s", e, query[:200])
        return None


def _format_records(records: list[dict]) -> str:
    """Chuyển đổi kết quả từ Neo4j thành văn bản dễ đọc để đưa vào LLM."""
    if not records:
        return ""
    lines = []
    for r in records:
        parts = []
        for k, v in r.items():
            if isinstance(v, list):
                v = [x for x in v if x]  # Lọc bỏ giá trị rỗng
                if v:
                    parts.append(f"{k}: {', '.join(str(x) for x in v)}")
            elif v is not None:
                parts.append(f"{k}: {v}")
        lines.append(" | ".join(parts))
    return "\n".join(lines)


# ═══════════════════════════════════════════════════════════════════════
#  Quy trình xử lý chính (Main Process Pipeline)
# ═══════════════════════════════════════════════════════════════════════
def process_chat_message(messages: list[dict]) -> str:
    """
    Điểm vào chính — Xử lý một đoạn hội thoại và trả về câu trả lời.

    Args:
        messages: Danh sách các tin nhắn {"role": "user"|"assistant", "content": "..."}.
                  Tin nhắn CUỐI CÙNG của user là câu hỏi hiện tại.

    Returns:
        Một chuỗi phản hồi định dạng Markdown.
    """
    # ── 0. Lấy câu hỏi hiện tại ──────────────────────────────────
    user_message = ""
    for msg in reversed(messages):
        if msg.get("role") == "user":
            user_message = msg.get("content", "").strip()
            break

    if not user_message:
        return GREETING_RESPONSES[0]

    logger.info("=" * 60)
    logger.info("[CHAT] Đang xử lý: '%s'", user_message[:100])

    # ── 1. Phân loại ý định (Intent Classification) ──────────────
    intent, confidence = classify_intent(user_message)
    logger.info("[BƯỚC-1] Ý định: %s (độ tin cậy=%.2f)", intent.value, confidence)

    # ── 2. Phản hồi trực tiếp (không cần DB/LLM) ──────────────────
    if intent == Intent.GREETING:
        return GREETING_RESPONSES[0]

    if intent == Intent.FAREWELL:
        return FAREWELL_RESPONSES[0]

    if intent == Intent.THANKS:
        return THANKS_RESPONSES[0]

    if intent == Intent.UNRELATED:
        return UNRELATED_RESPONSE

    # ── 3. Phản hồi dựa trên kiến thức tĩnh (Static Data) ────────
    static_context = ""

    if intent == Intent.UNIVERSITY_INFO:
        static_context = get_university_overview()
        # Truy vấn DB để lấy danh sách ngành từ graph
        db_data = _try_db_query(intent, user_message)
        return generate_answer(user_message, db_data, static_context, messages)

    if intent == Intent.MAJOR_INFO:
        static_context = get_major_overview()
        # Thử lấy thêm dữ liệu từ DB để bổ sung thông tin
        db_data = _try_db_query(intent, user_message)
        return generate_answer(user_message, db_data, static_context, messages)

    if intent == Intent.STUDY_PATH:
        static_context = get_study_path_text()
        return generate_answer(user_message, "", static_context, messages)

    if intent == Intent.ELECTIVE_INFO:
        static_context = get_elective_groups_text()
        db_data = _try_db_query(intent, user_message)
        return generate_answer(user_message, db_data, static_context, messages)

    # ── 4. Kết nối Neo4j ──────────────────────────────────────────
    try:
        neo4j_db.connect()
    except Exception as e:
        logger.error("[NEO4J-CONNECT] %s", e)
        return "Hệ thống đang gặp sự cố kết nối cơ sở dữ liệu. Vui lòng thử lại sau. 😅"

    # ── 5. Truy xuất dữ liệu từ Database ──────────────────────────
    db_data = _try_db_query(intent, user_message)

    if not db_data:
        # Nếu không tìm thấy trong DB và intent không rõ ràng, thử nhờ LLM suy luận
        if confidence < 0.5:
            return generate_answer(
                user_message, "",
                "Không tìm thấy thông tin cụ thể trong database.",
                messages,
            )
        return NO_DATA_RESPONSE

    # ── 6. Tổng hợp câu trả lời cuối cùng ──────────────────────────
    return generate_answer(user_message, db_data, static_context, messages)


def _try_db_query(intent: Intent, user_message: str) -> str:
    """
    Thử nhiều chiến lược để lấy dữ liệu từ Neo4j:
    1. Template Cypher (Nhanh, chính xác 100% nếu khớp mẫu)
    2. LLM Cypher (Linh hoạt cho câu hỏi tự nhiên)
    3. Fallback (Tìm kiếm rộng dựa trên từ khóa)
    """
    # ── Chiến lược 1: Theo mẫu Template ───────────────────────────
    template_result = generate_template_cypher(intent, user_message)
    if template_result:
        query, params = template_result
        logger.info("[CHIẾN-LƯỢC-1] Sử dụng Template Cypher cho intent=%s", intent.value)
        records = _execute_cypher(query, params)
        if records:
            logger.info("[CHIẾN-LƯỢC-1] Tìm thấy %d bản ghi", len(records))
            return _format_records(records)
        logger.info("[CHIẾN-LƯỢC-1] Không có kết quả từ template")

    # ── Chiến lược 2: Sử dụng LLM để sinh Cypher ──────────────────
    logger.info("[CHIẾN-LƯỢC-2] Đang dùng LLM để sinh câu lệnh Cypher...")
    cypher = generate_llm_cypher(user_message)

    if cypher and cypher not in ("ERROR", "UNRELATED"):
        records = _execute_cypher(cypher)
        if records:
            logger.info("[CHIẾN-LƯỢC-2] Tìm thấy %d bản ghi từ LLM Cypher", len(records))
            return _format_records(records)
        logger.info("[CHIẾN-LƯỢC-2] LLM Cypher không trả về kết quả")

    # ── Chiến lược 3: Tìm kiếm mở rộng (Fallback) ──────────────────
    logger.info("[CHIẾN-LƯỢC-3] Đang thử tìm kiếm rộng theo từ khóa...")
    query, params = generate_fallback_cypher(user_message)
    records = _execute_cypher(query, params)
    if records:
        logger.info("[CHIẾN-LƯỢC-3] Tìm thấy %d bản ghi từ Fallback", len(records))
        return _format_records(records)

    logger.info("[ALL STRATEGIES] Không tìm thấy dữ liệu nào cho: '%s'", user_message[:80])
    return ""


def get_cache_stats() -> dict:
    """Trả về thống kê cache để phục vụ giám sát (monitoring)."""
    return _cache.stats
