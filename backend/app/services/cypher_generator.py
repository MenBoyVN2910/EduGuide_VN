"""
Bộ sinh truy vấn Cypher đa chiến lược (Multi-strategy Cypher generator).
1. Dựa trên mẫu (Template): Truy vấn nhanh, xác định cho các ý định đã biết.
2. Dựa trên LLM: Sử dụng Gemini để sinh Cypher linh hoạt cho các câu hỏi phức tạp.
3. Fallback: Tìm kiếm rộng dựa trên từ khóa khi các phương án trên thất bại.
"""

import re
import logging
import google.generativeai as genai
from app.core.config import settings
from app.services.intent_classifier import Intent

logger = logging.getLogger("cypher_generator")

# ── Thiết lập Gemini (Lazy loading) ──────────────────────────────────
_cypher_model = None


def _get_cypher_model():
    """Khởi tạo và trả về instance của model Gemini để sinh Cypher."""
    global _cypher_model
    if _cypher_model is None:
        genai.configure(api_key=settings.GEMINI_API_KEY)
        _cypher_model = genai.GenerativeModel(
            model_name=settings.GEMINI_CYPHER_MODEL,
            generation_config={
                "temperature": 0.0, # Độ sáng tạo bằng 0 để đảm bảo tính chính xác của cú pháp Cypher
                "top_p": 0.95,
                "top_k": 40,
                "max_output_tokens": 512,
            },
        )
    return _cypher_model


# ── Trình trích xuất từ khóa (Keyword extractor) ──────────────────────
# Danh sách các từ dừng (stop words) tiếng Việt cần loại bỏ khi tìm kiếm
_STOP_WORDS = {
    "là", "gì", "bao", "nhiêu", "có", "không", "tôi", "mình", "muốn",
    "cần", "phải", "của", "cho", "biết", "về", "hỏi", "xin", "vui",
    "lòng", "bạn", "được", "thì", "và", "với", "trong", "những", "các",
    "nào", "đăng", "ký", "tên", "mã", "để", "học", "trước", "sau",
    "điều", "kiện", "tiên", "quyết", "song", "hành", "thực", "liệt",
    "kê", "danh", "sách", "tất", "cả", "thuộc", "nhóm", "đi", "kèm",
    "môn", "hãy", "giúp", "lộ", "trình", "ơn", "chào", "ạ", "nhé",
    "nha", "vậy", "rồi", "đó", "này", "kia", "lại", "ra", "lên",
    "xuống", "vào", "nên", "sẽ", "đã", "đang", "sao", "thế",
}


def extract_keywords(message: str) -> str:
    """Trích xuất các từ khóa có nghĩa từ câu hỏi tiếng Việt."""
    words = re.findall(r"[a-zA-ZàáạảãăắặẳẵâấậẩẫèéẹẻẽêếệểễìíịỉĩòóọỏõôốộổỗơớợởỡùúụủũưứựửữỳýỵỷỹđĐ]+", message.lower())
    keywords = [w for w in words if w not in _STOP_WORDS and len(w) > 1]
    return " ".join(keywords[:5]) if keywords else message[:30]


def _extract_course_name(message: str) -> str:
    """Cố gắng trích xuất tên môn học cụ thể từ tin nhắn người dùng bằng Regex phức tạp."""
    text = message.strip()

    # 1. Thử khớp trực tiếp mã môn học (ví dụ: CMP175, COS120)
    id_match = re.search(r'\b([A-Z]{2,4}\d{3,5})\b', text, re.IGNORECASE)
    if id_match:
        return id_match.group(1).upper()

    # 2. Trích xuất tên môn học dựa trên các dấu hiệu ngôn ngữ (markers)
    name_patterns = [
        # "môn Lập trình web là gì" → "Lập trình web"
        r'(?:môn\s+)([A-ZÀ-Ỹa-zà-ỹ][a-zà-ỹ]*(?:\s+[a-zà-ỹA-ZÀ-Ỹ][a-zà-ỹ]*)*?)(?:\s+(?:là|có|cần|bao|không|thì|nào|được|để|mấy|bao nhiêu)\b|\s*[\?\.!]|$)',
        # "tiên quyết của Lập trình web" → "Lập trình web"
        r'(?:tiên\s*quyết|song\s*hành|thực\s*hành|tín\s*chỉ).*?(?:của|cho|môn)\s+([A-ZÀ-Ỹa-zà-ỹ][a-zà-ỹ]*(?:\s+[a-zà-ỹA-ZÀ-Ỹ][a-zà-ỹ]*)*?)(?:\s*[\?\.!]|$)',
        # "Lập trình web có ..." hoặc "Lập trình web là ..."
        r'^([A-ZÀ-Ỹ][a-zà-ỹ]*(?:\s+[a-zà-ỹA-ZÀ-Ỹ][a-zà-ỹ]*)*?)\s+(?:có|là|cần|thuộc|bao|mấy)',
        # "về Cấu trúc dữ liệu" hoặc "của Cấu trúc dữ liệu"
        r'(?:về|của|cho)\s+([A-ZÀ-Ỹa-zà-ỹ][a-zà-ỹ]*(?:\s+[a-zà-ỹA-ZÀ-Ỹ][a-zà-ỹ]*)*?)(?:\s+(?:là|có|cần|không|thì)\b|\s*[\?\.!]|$)',
        # "học Lập trình web trước" hoặc "học Lập trình web"
        r'(?:học|đăng\s*ký)\s+([A-ZÀ-Ỹa-zà-ỹ][a-zà-ỹ]*(?:\s+[a-zà-ỹA-ZÀ-Ỹ][a-zà-ỹ]*)*?)(?:\s+(?:trước|sau|thì|là|không)\b|\s*[\?\.!]|$)',
    ]

    for p in name_patterns:
        m = re.search(p, text, re.IGNORECASE)
        if m:
            name = m.group(1).strip().rstrip("?.,! ")
            if len(name) > 3:
                return name

    # 3. Fallback: sử dụng trích xuất từ khóa đơn giản
    return extract_keywords(message)


# ── Danh sách các mẫu Template Cypher ─────────────────────────────────
CYPHER_TEMPLATES = {
    # Truy vấn thông tin cơ bản của môn học
    Intent.COURSE_INFO: """
        MATCH (c:Course)
        WHERE toLower(c.name) CONTAINS toLower($keyword)
           OR toLower(c.id) = toLower($keyword)
        OPTIONAL MATCH (pre:Course)-[:PREREQUISITE_FOR]->(c)
        OPTIONAL MATCH (lab:Course)-[:COREQUISITE_WITH]->(c)
        RETURN c.id AS id, c.name AS name, c.credits AS credits,
               c.category AS category,
               collect(DISTINCT pre.name) AS prerequisites,
               collect(DISTINCT lab.name) AS corequisites
        LIMIT 10
    """,

    # Truy vấn số tín chỉ
    Intent.CREDIT_INFO: """
        MATCH (c:Course)
        WHERE toLower(c.name) CONTAINS toLower($keyword)
           OR toLower(c.id) = toLower($keyword)
        RETURN c.id AS id, c.name AS name, c.credits AS credits, c.category AS category
        LIMIT 10
    """,

    # Truy vấn môn tiên quyết
    Intent.PREREQUISITE: """
        MATCH (pre:Course)-[:PREREQUISITE_FOR]->(c:Course)
        WHERE toLower(c.name) CONTAINS toLower($keyword)
           OR toLower(c.id) = toLower($keyword)
        RETURN c.id AS course_id, c.name AS course_name,
               pre.id AS pre_id, pre.name AS pre_name, pre.credits AS pre_credits
    """,

    # Truy vấn môn thực hành song hành
    Intent.COREQUISITE: """
        MATCH (lab:Course)-[:COREQUISITE_WITH]->(c:Course)
        WHERE toLower(c.name) CONTAINS toLower($keyword)
           OR toLower(c.id) = toLower($keyword)
        RETURN c.id AS course_id, c.name AS course_name,
               lab.id AS lab_id, lab.name AS lab_name, lab.credits AS lab_credits
    """,

    # Liệt kê các môn theo nhóm (Đại cương, CNBB, ...)
    Intent.CATEGORY_LIST: """
        MATCH (c:Course)
        WHERE toLower(c.category) CONTAINS toLower($keyword)
        RETURN c.id AS id, c.name AS name, c.credits AS credits, c.category AS category
        ORDER BY c.name
        LIMIT 30
    """,

    # Liệt kê toàn bộ môn học
    Intent.COURSE_LIST_ALL: """
        MATCH (c:Course)
        RETURN c.id AS id, c.name AS name, c.credits AS credits, c.category AS category
        ORDER BY c.category, c.name
        LIMIT 50
    """,

    # So sánh các môn học
    Intent.COMPARISON: """
        MATCH (c:Course)
        WHERE toLower(c.name) CONTAINS toLower($keyword)
        OPTIONAL MATCH (pre:Course)-[:PREREQUISITE_FOR]->(c)
        OPTIONAL MATCH (lab:Course)-[:COREQUISITE_WITH]->(c)
        RETURN c.id AS id, c.name AS name, c.credits AS credits,
               c.category AS category,
               collect(DISTINCT pre.name) AS prerequisites,
               collect(DISTINCT lab.name) AS corequisites
        LIMIT 10
    """,
}

# Ánh xạ từ khóa tiếng Việt sang giá trị Category chính xác trong DB
CATEGORY_KEYWORDS = {
    "đại cương": "Đại cương",
    "bắt buộc": "Chuyên nghiệp bắt buộc",
    "phần mềm": "Tự chọn - Công nghệ phần mềm",
    "hệ thống thông tin": "Tự chọn - Hệ thống thông tin ứng dụng",
    "mạng": "Tự chọn - Mạng máy tính",
    "máy học": "Tự chọn - Máy học và ứng dụng",
    "an ninh": "Tự chọn - An ninh mạng",
    "tốt nghiệp": "Tự chọn - Đồ án tốt nghiệp",
    "thể chất": "Thể chất",
    "quốc phòng": "Quốc phòng An ninh",
    "bóng chuyền": "Thể chất - Bóng chuyền",
    "bóng rổ": "Thể chất - Bóng rổ",
    "vovinam": "Thể chất - Vovinam",
    "bóng đá": "Thể chất - Bóng đá",
    "thể hình": "Thể chất - Thể hình Thẩm mỹ",
}


def _resolve_category_keyword(message: str) -> str:
    """Chuyển đổi ngôn ngữ tự nhiên sang tên Category chuẩn xác trong DB."""
    lower = message.lower()
    for kw, category in CATEGORY_KEYWORDS.items():
        if kw in lower:
            return category
    return extract_keywords(message)


def generate_template_cypher(intent: Intent, message: str) -> tuple[str, dict] | None:
    """
    Sinh câu lệnh Cypher từ mẫu có sẵn nếu ý định được hỗ trợ.
    Trả về: (câu_truy vấn, tham_số) hoặc None.
    """
    template = CYPHER_TEMPLATES.get(intent)
    if not template:
        return None

    if intent == Intent.CATEGORY_LIST:
        keyword = _resolve_category_keyword(message)
    elif intent == Intent.COURSE_LIST_ALL:
        return template, {}
    else:
        keyword = _extract_course_name(message)

    return template, {"keyword": keyword}


# ── Sinh Cypher bằng LLM ──────────────────────────────────────────────
# System prompt chi tiết giúp AI hiểu schema và các quy tắc sinh Cypher
CYPHER_SYSTEM_PROMPT = """You are an expert Neo4j Cypher query generator for a Vietnamese university (HUTECH) training program database.

## Database Schema

Node labels and properties:
- (:Major {id, name, university, total_credits, non_accum_credits})
- (:Course {id, name, credits, category})

Relationships:
- (:Course)-[:BELONGS_TO]->(:Major)          — Môn thuộc ngành
- (:Course)-[:PREREQUISITE_FOR]->(:Course)   — Môn tiên quyết (phải học trước)
- (:Course)-[:COREQUISITE_WITH]->(:Course)   — Môn song hành (TH đi với LT)

Category values: 'Đại cương', 'Chuyên nghiệp bắt buộc', 'Tự chọn - Công nghệ phần mềm', 'Tự chọn - Hệ thống thông tin ứng dụng', 'Tự chọn - Mạng máy tính', 'Tự chọn - Máy học và ứng dụng', 'Tự chọn - An ninh mạng', 'Tự chọn - Đồ án tốt nghiệp', 'Thể chất - Bóng chuyền', 'Thể chất - Bóng rổ', 'Thể chất - Thể hình Thẩm mỹ', 'Thể chất - Vovinam', 'Thể chất - Bóng đá', 'Quốc phòng An ninh'.

## Rules
1. Return ONLY the raw Cypher query. No markdown, no explanation, no code fences.
2. Use toLower() for name matching: `toLower(c.name) CONTAINS toLower('keyword')`
3. Also support matching by ID: `toLower(c.id) = toLower('keyword')`
4. Always RETURN enough properties for a meaningful answer (name, credits, category, id).
5. Add LIMIT 25 when listing multiple results.
6. If the question is completely unrelated to courses / majors / university, return exactly: UNRELATED

## Examples
(Các ví dụ minh họa cách chuyển câu hỏi sang Cypher chính xác...)
"""


def _clean_cypher(text: str) -> str:
    """Làm sạch kết quả đầu ra của AI (xóa các ký tự markdown, khoảng trắng thừa)."""
    text = text.strip()
    text = re.sub(r"^```(?:cypher)?\s*", "", text)
    text = re.sub(r"\s*```$", "", text)
    text = text.strip().strip('"').strip("'")
    return text.strip()


def generate_llm_cypher(user_question: str) -> str:
    """Sử dụng Gemini LLM để dịch câu hỏi tiếng Việt sang câu lệnh Cypher."""
    prompt = f"""{CYPHER_SYSTEM_PROMPT}

Question: {user_question}
Cypher:"""

    try:
        model = _get_cypher_model()
        response = model.generate_content(prompt)
        raw = response.text
        logger.info("[CYPHER-LLM-RAW] %s", raw[:200])
        return _clean_cypher(raw)
    except Exception as e:
        logger.error("[CYPHER-LLM-ERROR] %s", e)
        return "ERROR"


# ── Tìm kiếm rộng dự phòng (Fallback broad search) ───────────────────
FALLBACK_QUERY = """
    MATCH (c:Course)
    WHERE toLower(c.name) CONTAINS toLower($keyword)
       OR toLower(c.id) = toLower($keyword)
    OPTIONAL MATCH (pre:Course)-[:PREREQUISITE_FOR]->(c)
    OPTIONAL MATCH (lab:Course)-[:COREQUISITE_WITH]->(c)
    RETURN c.id AS id, c.name AS name, c.credits AS credits,
           c.category AS category,
           collect(DISTINCT pre.name) AS prerequisites,
           collect(DISTINCT lab.name) AS corequisites
    LIMIT 10
"""


def generate_fallback_cypher(message: str) -> tuple[str, dict]:
    """Sinh một câu truy vấn rộng bằng cách trích xuất từ khóa đơn giản."""
    keyword = extract_keywords(message)
    return FALLBACK_QUERY, {"keyword": keyword}
