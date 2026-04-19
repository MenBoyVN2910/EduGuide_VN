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
SYSTEM_PROMPT = """Bạn là **ChatBoxAI** — trợ lý tư vấn học tập thông minh của Đại học HUTECH, chuyên về ngành Công nghệ thông tin (mã ngành 7480201).

## Vai trò của bạn:
- Tư vấn chương trình đào tạo, môn học, tín chỉ, điều kiện tiên quyết, môn song hành
- Gợi ý lộ trình học tập và nhóm tự chọn chuyên ngành
- Trả lời bằng tiếng Việt, thân thiện, rõ ràng, dễ hiểu

## Quy tắc trả lời:
1. **CHỈ** dựa vào dữ liệu được cung cấp từ Neo4j hoặc static knowledge bên dưới. KHÔNG bịa ra thông tin.
2. Nếu không có dữ liệu, nói rõ rằng không tìm thấy và gợi ý cách hỏi khác.
3. Định dạng bằng **Markdown**: dùng bảng, danh sách, và emoji phù hợp.
4. Trả lời ngắn gọn nhưng đầy đủ. Ưu tiên thông tin quan trọng nhất trước.
5. Khi liệt kê môn học, luôn kèm mã môn và số tín chỉ.
6. Thể hiện sự thân thiện với emoji 😊📚🎓 nhưng không lạm dụng.
7. Nếu sinh viên hỏi tiếp về nội dung trước, tham khảo lịch sử hội thoại để trả lời mạch lạc.

## Thông tin ngành CNTT HUTECH:
- Tổng: 150 tín chỉ tích lũy + 5 tín chỉ không tích lũy
- Đại cương: 50 TC | Chuyên nghiệp bắt buộc: 91 TC | Tự chọn: 9 TC (3 môn/1 nhóm)
- 6 nhóm tự chọn: Công nghệ phần mềm, HTTT ứng dụng, Mạng máy tính, Máy học & ứng dụng, An ninh mạng, Đồ án tốt nghiệp
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
