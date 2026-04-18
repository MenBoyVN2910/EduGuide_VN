import os
import re
import logging
import google.generativeai as genai
from app.core.neo4j_db import neo4j_db

# ─── Logging ────────────────────────────────────────────────────────
logger = logging.getLogger("chat_agent")
logging.basicConfig(level=logging.INFO)

# ─── Configure Gemini ───────────────────────────────────────────────
api_key = os.getenv("GEMINI_API_KEY")
if api_key:
    genai.configure(api_key=api_key)

# Model dùng cho sinh Cypher (cần chính xác tuyệt đối)
cypher_model = genai.GenerativeModel(
    model_name="gemini-2.5-flash",
    generation_config={
        "temperature": 0.0,
        "top_p": 0.95,
        "top_k": 40,
        "max_output_tokens": 512,
    },
)

# Model dùng cho sinh câu trả lời (tự nhiên hơn một chút)
answer_model = genai.GenerativeModel(
    model_name="gemini-2.5-flash",
    generation_config={
        "temperature": 0.3,
        "top_p": 0.95,
        "top_k": 40,
        "max_output_tokens": 1024,
    },
)

# ─── Schema & Few-shot Examples ─────────────────────────────────────
CYPHER_SYSTEM_PROMPT = """You are an expert Neo4j Cypher query generator for a Vietnamese university training program database.

## Database Schema

Node labels and properties:
- (:Major {id, name, university, total_credits, non_accum_credits})
- (:Course {id, name, credits, category})

Relationships:
- (:Course)-[:BELONGS_TO]->(:Major)          — Môn thuộc ngành
- (:Course)-[:PREREQUISITE_FOR]->(:Course)   — Môn tiên quyết (phải học trước)
- (:Course)-[:COREQUISITE_WITH]->(:Course)   — Môn song hành (học cùng lúc, thường là thực hành đi với lý thuyết)

Category values include: 'Đại cương', 'Chuyên nghiệp bắt buộc', 'Tự chọn - Công nghệ phần mềm', 'Tự chọn - Hệ thống thông tin ứng dụng', 'Tự chọn - Mạng máy tính', 'Tự chọn - Máy học và ứng dụng', 'Tự chọn - An ninh mạng', 'Tự chọn - Đồ án tốt nghiệp', 'Thể chất - Bóng chuyền', 'Thể chất - Bóng rổ', 'Thể chất - Thể hình Thẩm mỹ', 'Thể chất - Vovinam', 'Thể chất - Bóng đá', 'Quốc phòng An ninh'.

## Rules
1. Return ONLY the raw Cypher query. No markdown, no explanation, no code fences.
2. Use toLower() for name matching: `toLower(c.name) CONTAINS toLower('keyword')`
3. Always RETURN enough properties for a meaningful answer (name, credits, category, id).
4. Add LIMIT 25 when listing multiple results.
5. If the question is completely unrelated to courses / majors / university, return exactly: UNRELATED

## Examples

Question: Ngành Công nghệ thông tin có bao nhiêu tín chỉ?
Cypher: MATCH (m:Major) WHERE toLower(m.name) CONTAINS toLower('công nghệ thông tin') RETURN m.name AS name, m.total_credits AS total_credits, m.non_accum_credits AS non_accum_credits

Question: Điều kiện tiên quyết của môn Lập trình web là gì?
Cypher: MATCH (pre:Course)-[:PREREQUISITE_FOR]->(c:Course) WHERE toLower(c.name) CONTAINS toLower('lập trình web') RETURN pre.id AS pre_id, pre.name AS pre_name, pre.credits AS pre_credits, c.name AS course_name

Question: Môn Lập trình hướng đối tượng là tiên quyết cho những môn nào?
Cypher: MATCH (c:Course)-[:PREREQUISITE_FOR]->(next:Course) WHERE toLower(c.name) CONTAINS toLower('lập trình hướng đối tượng') RETURN next.id AS id, next.name AS name, next.credits AS credits LIMIT 25

Question: Liệt kê các môn thuộc nhóm tự chọn Công nghệ phần mềm
Cypher: MATCH (c:Course) WHERE c.category = 'Tự chọn - Công nghệ phần mềm' RETURN c.id AS id, c.name AS name, c.credits AS credits LIMIT 25

Question: Môn Cơ sở lập trình có môn thực hành đi kèm không?
Cypher: MATCH (lab:Course)-[:COREQUISITE_WITH]->(c:Course) WHERE toLower(c.name) CONTAINS toLower('cơ sở lập trình') RETURN lab.id AS lab_id, lab.name AS lab_name, lab.credits AS lab_credits, c.name AS course_name

Question: Liệt kê tất cả các môn đại cương
Cypher: MATCH (c:Course) WHERE c.category = 'Đại cương' RETURN c.id AS id, c.name AS name, c.credits AS credits LIMIT 25

Question: Mã môn học của Toán rời rạc là gì?
Cypher: MATCH (c:Course) WHERE toLower(c.name) CONTAINS toLower('toán rời rạc') RETURN c.id AS id, c.name AS name, c.credits AS credits, c.category AS category

Question: Đồ án tốt nghiệp có bao nhiêu tín chỉ?
Cypher: MATCH (c:Course) WHERE toLower(c.name) CONTAINS toLower('đồ án tốt nghiệp') RETURN c.id AS id, c.name AS name, c.credits AS credits, c.category AS category
"""

# Query fallback rộng: lấy dữ liệu liên quan dựa trên keyword
FALLBACK_QUERY_TEMPLATE = """
MATCH (c:Course)
WHERE toLower(c.name) CONTAINS toLower($keyword)
OPTIONAL MATCH (pre:Course)-[:PREREQUISITE_FOR]->(c)
OPTIONAL MATCH (lab:Course)-[:COREQUISITE_WITH]->(c)
RETURN c.id AS id, c.name AS name, c.credits AS credits, c.category AS category,
       collect(DISTINCT pre.name) AS prerequisites,
       collect(DISTINCT lab.name) AS corequisites
LIMIT 10
"""


def _clean_cypher(text: str) -> str:
    """Remove markdown fences and whitespace from model output."""
    text = text.strip()
    # Remove ```cypher ... ``` or ``` ... ```
    text = re.sub(r'^```(?:cypher)?\s*', '', text)
    text = re.sub(r'\s*```$', '', text)
    # Remove leading/trailing quotes if the model wraps it
    text = text.strip().strip('"').strip("'")
    return text.strip()


def _extract_keyword(user_message: str) -> str:
    """Extract a simple keyword from the user message for fallback search."""
    # Remove common Vietnamese question words to isolate the topic
    stopwords = [
        "là gì", "là bao nhiêu", "bao nhiêu", "có bao nhiêu",
        "điều kiện", "tiên quyết", "song hành", "thực hành",
        "cho tôi biết", "liệt kê", "danh sách", "tất cả",
        "thuộc", "nhóm", "của", "tôi", "muốn", "học", "môn",
        "để", "cần", "phải", "trước", "sau", "gì", "nào",
        "có", "không", "thì", "và", "với", "trong", "những",
        "các", "đăng ký", "đăng kí", "mã", "tên",
    ]
    cleaned = user_message.lower()
    for sw in stopwords:
        cleaned = cleaned.replace(sw, " ")
    # Take the longest remaining phrase
    parts = [p.strip() for p in cleaned.split() if len(p.strip()) > 1]
    if parts:
        return " ".join(parts[:3])  # Take up to 3 words
    return user_message[:20]


def generate_cypher(user_question: str) -> str:
    """Step 1: Translate user question (Vietnamese) into a Cypher query."""
    prompt = f"""{CYPHER_SYSTEM_PROMPT}

Question: {user_question}
Cypher:"""

    try:
        response = cypher_model.generate_content(prompt)
        raw = response.text
        logger.info(f"[CYPHER-RAW] {raw}")
        return _clean_cypher(raw)
    except Exception as e:
        logger.error(f"[CYPHER-GEN-ERROR] {e}")
        return "ERROR"


def _execute_cypher_safe(query: str, parameters: dict = None) -> list | None:
    """Execute a Cypher query, return list of dicts or None on failure."""
    try:
        return neo4j_db.execute_query(query, parameters)
    except Exception as e:
        logger.error(f"[NEO4J-EXEC-ERROR] {e}\n  Query: {query}")
        return None


def _fallback_search(user_message: str) -> str:
    """Fallback: extract keyword and run a broad search."""
    keyword = _extract_keyword(user_message)
    logger.info(f"[FALLBACK] keyword='{keyword}'")
    records = _execute_cypher_safe(FALLBACK_QUERY_TEMPLATE, {"keyword": keyword})
    if records:
        return "\n".join(str(r) for r in records)

    # Ultimate fallback: dump a summary of all courses
    logger.info("[FALLBACK] keyword search empty, loading full course summary")
    summary_query = """
    MATCH (c:Course)
    OPTIONAL MATCH (pre:Course)-[:PREREQUISITE_FOR]->(c)
    OPTIONAL MATCH (lab:Course)-[:COREQUISITE_WITH]->(c)
    RETURN c.id AS id, c.name AS name, c.credits AS credits,
           c.category AS category,
           collect(DISTINCT pre.name) AS prerequisites,
           collect(DISTINCT lab.name) AS corequisites
    ORDER BY c.category, c.name
    """
    all_records = _execute_cypher_safe(summary_query)
    if all_records:
        # Build a compact text context
        lines = []
        for r in all_records:
            prereqs = [p for p in r.get("prerequisites", []) if p]
            coreqs = [c for c in r.get("corequisites", []) if c]
            pre_str = f" | Tiên quyết: {', '.join(prereqs)}" if prereqs else ""
            co_str = f" | Song hành: {', '.join(coreqs)}" if coreqs else ""
            lines.append(
                f"- {r.get('id','')}: {r.get('name','')} ({r.get('credits','')} TC)"
                f" [{r.get('category','')}]{pre_str}{co_str}"
            )
        return "\n".join(lines)
    return ""


def process_chat_message(user_message: str) -> str:
    """Main entry: Text-to-Cypher GraphRAG with retry & fallback."""

    # ── 0. Connect Neo4j ─────────────────────────────────────────
    try:
        neo4j_db.connect()
    except Exception as e:
        logger.error(f"[NEO4J-CONNECT] {e}")
        return "Hệ thống đang gặp sự cố kết nối cơ sở dữ liệu. Vui lòng thử lại sau."

    # ── 1. Generate Cypher ───────────────────────────────────────
    cypher_query = generate_cypher(user_message)
    logger.info(f"[STEP-1] Cypher => {cypher_query}")

    if cypher_query == "UNRELATED":
        return "Xin lỗi, tôi chỉ hỗ trợ các câu hỏi liên quan đến chương trình đào tạo, môn học, tín chỉ và lộ trình học tập. Bạn hãy thử hỏi về một môn học cụ thể nhé!"

    # ── 2. Execute Cypher ────────────────────────────────────────
    db_results_text = ""

    if cypher_query != "ERROR":
        records = _execute_cypher_safe(cypher_query)
        if records:
            db_results_text = "\n".join(str(r) for r in records)
            logger.info(f"[STEP-2] Got {len(records)} records from generated Cypher")

    # ── 3. Fallback nếu Cypher sinh lỗi hoặc không có kết quả ──
    if not db_results_text:
        logger.info("[STEP-3] Primary Cypher returned no data → running fallback")
        db_results_text = _fallback_search(user_message)

    if not db_results_text:
        db_results_text = "Không tìm thấy dữ liệu nào phù hợp trong cơ sở dữ liệu."

    # ── 4. Generate answer ───────────────────────────────────────
    answer_prompt = f"""Bạn là ChatBoxAI - trợ lý tư vấn học tập của Đại học HUTECH, ngành Công nghệ thông tin.

Hãy trả lời câu hỏi của sinh viên bằng tiếng Việt, dựa **CHỈ** vào dữ liệu bên dưới được truy xuất từ cơ sở dữ liệu đồ thị Neo4j.
- Trả lời ngắn gọn, lịch sự, dễ hiểu.
- Nếu dữ liệu cho thấy "Không tìm thấy", hãy nói rõ rằng bạn không tìm thấy thông tin trong hệ thống và gợi ý sinh viên hỏi lại với từ khóa khác.
- KHÔNG được bịa ra môn học, mã môn, hoặc số tín chỉ nào không có trong dữ liệu.
- Định dạng câu trả lời bằng Markdown.

## Dữ liệu từ Neo4j:
{db_results_text}

## Câu hỏi của sinh viên:
{user_message}

## Trả lời:"""

    try:
        response = answer_model.generate_content(answer_prompt)
        logger.info("[STEP-4] Answer generated successfully")
        return response.text
    except Exception as e:
        logger.error(f"[ANSWER-GEN-ERROR] {e}")
        return "Xin lỗi, hệ thống đang tạm thời quá tải. Vui lòng thử lại sau ít phút nhé!"
