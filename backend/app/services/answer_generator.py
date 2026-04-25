"""
Bộ tạo câu trả lời (Answer Generator) — Tạo phản hồi bằng ngôn ngữ tự nhiên (Tiếng Việt)
Sử dụng Gemini LLM, dựa trên dữ liệu từ Neo4j và lịch sử hội thoại.
"""

import logging
import google.generativeai as genai
from app.core.config import settings

logger = logging.getLogger("answer_generator")

# ── Thiết lập Gemini (Lazy loading) ──────────────────────────────────
_answer_model = None


def _get_answer_model():
    """Khởi tạo và trả về instance của model Gemini để tạo câu trả lời."""
    global _answer_model
    if _answer_model is None:
        genai.configure(api_key=settings.GEMINI_API_KEY)
        _answer_model = genai.GenerativeModel(
            model_name=settings.GEMINI_ANSWER_MODEL,
            generation_config={
                "temperature": 0.3, # Độ sáng tạo vừa phải để câu trả lời tự nhiên nhưng vẫn bám sát dữ liệu
                "top_p": 0.95,
                "top_k": 40,
                "max_output_tokens": 2048,
            },
        )
    return _answer_model


# ── System prompt (Chỉ thị hệ thống) ──────────────────────────────────
SYSTEM_PROMPT = """Bạn là **ChatBoxAI** — trợ lý tư vấn học tập thông minh của Trường Đại học Công nghệ TP.HCM (HUTECH).

## Vai trò của bạn:
- Tư vấn về TẤT CẢ các ngành đào tạo của HUTECH (18 ngành khóa K2025)
- Trả lời thông tin về môn học, tín chỉ, điều kiện tiên quyết, môn song hành
- Gợi ý lộ trình học tập và nhóm tự chọn chuyên ngành
- Trả lời bằng tiếng Việt, thân thiện, rõ ràng, dễ hiểu

## Kiến thức về cấu trúc dữ liệu Graph:
- **University → OFFERS → Major**: Trường đào tạo các ngành
- **Course → BELONGS_TO → Major**: Môn học thuộc ngành
- **Course → PREREQUISITE_FOR → Course**: Môn tiên quyết
- **Course → COREQUISITE_WITH → Course**: Môn song hành (Thực hành đi kèm Lý thuyết)

## Danh sách 18 ngành đào tạo K2025:
1. Công nghệ thông tin (7480201) - 150 TC
2. Trí tuệ nhân tạo (7480107) - 150 TC
3. An toàn thông tin (7480202) - 150 TC
4. Robot và trí tuệ nhân tạo (7510209) - 150 TC
5. Kiến trúc (7580101) - 160 TC
6. Thú y (7640101) - 160 TC
7. Luật (7380101) - 135 TC
8. Quản lý xây dựng (7580302) - 125 TC
9. Quản trị sự kiện (7340412) - 125 TC
10. Thiết kế thời trang (7210404) - 125 TC
11. Marketing (7340115) - 125 TC
12. Thanh nhạc (7210205) - 125 TC
13. Tâm lý học (7310401) - 125 TC
14. Logistics và quản lý chuỗi cung ứng (7510605) - 125 TC
15. Kế toán (7340301) - 125 TC
16. Công nghệ thực phẩm (7540101) - 125 TC
17. Hệ thống thông tin quản lý (7340405) - 125 TC
18. Thương mại điện tử (7340122) - 125 TC

## Quy tắc trả lời:
1. **CHỈ** dựa vào dữ liệu được cung cấp từ Neo4j hoặc static knowledge bên dưới. KHÔNG bịa ra thông tin.
2. Nếu không có dữ liệu, nói rõ rằng không tìm thấy và gợi ý cách hỏi khác.
3. Định dạng bằng **Markdown**: dùng bảng, danh sách, và emoji phù hợp.
4. Trả lời ngắn gọn nhưng đầy đủ. Ưu tiên thông tin quan trọng nhất trước.
5. Khi liệt kê môn học, luôn kèm mã môn và số tín chỉ.
6. Thể hiện sự thân thiện với emoji 😊📚🎓 nhưng không lạm dụng.
7. Nếu sinh viên hỏi tiếp về nội dung trước, tham khảo lịch sử hội thoại để trả lời mạch lạc.
8. Khi liệt kê danh sách ngành, nêu rõ mã ngành và số tín chỉ cho từng ngành.
"""

MAX_HISTORY_TURNS = 6  # Số lượng lượt hội thoại tối đa được đưa vào context (6 cặp hỏi/đáp)


def _build_history_context(messages: list[dict]) -> str:
    """Xây dựng chuỗi ngữ cảnh lịch sử hội thoại từ danh sách tin nhắn."""
    if not messages or len(messages) <= 1:
        return ""

    # Lấy N lượt hội thoại gần nhất (loại bỏ tin nhắn cuối cùng vì đó là câu hỏi hiện tại)
    recent = messages[-(MAX_HISTORY_TURNS * 2 + 1):-1]
    if not recent:
        return ""

    lines = ["## Lịch sử hội thoại gần đây:"]
    for msg in recent:
        role = msg.get("role", "user")
        content = msg.get("content", "")
        # Cắt bớt nếu tin nhắn quá dài
        if len(content) > 300:
            content = content[:300] + "..."
        prefix = "🧑 Sinh viên" if role == "user" else "🤖 ChatBoxAI"
        lines.append(f"**{prefix}:** {content}")
    return "\n".join(lines)


def generate_answer(
    user_question: str,
    db_data: str,
    static_context: str = "",
    messages: list[dict] | None = None,
) -> str:
    """
    Tạo câu trả lời tự nhiên bằng Gemini dựa trên dữ liệu và ngữ cảnh.

    Args:
        user_question: Câu hỏi hiện tại của người dùng.
        db_data: Dữ liệu truy xuất từ Neo4j (dạng text).
        static_context: Ngữ cảnh tĩnh bổ sung (lộ trình học, thông tin ngành...).
        messages: Toàn bộ lịch sử hội thoại để hỗ trợ trả lời đa lượt.
    """
    history_context = _build_history_context(messages or [])

    # Tổng hợp các phần của Prompt
    parts = [SYSTEM_PROMPT]

    if history_context:
        parts.append(history_context)

    if static_context:
        parts.append(f"## Thông tin tham khảo:\n{static_context}")

    if db_data:
        parts.append(f"## Dữ liệu từ Neo4j:\n{db_data}")

    parts.append(f"## Câu hỏi hiện tại của sinh viên:\n{user_question}")
    parts.append("## Trả lời:")

    prompt = "\n\n".join(parts)

    try:
        model = _get_answer_model()
        response = model.generate_content(prompt)
        logger.info("[TRẢ LỜI] Đã tạo câu trả lời thành công (%d ký tự)", len(response.text))
        return response.text
    except Exception as e:
        logger.error("[LỖI-TẠO-CÂU-TRẢ-LỜI] %s", e)
        return (
            "Xin lỗi, hệ thống đang tạm thời quá tải. 😅\n"
            "Vui lòng thử lại sau ít phút nhé!"
        )
