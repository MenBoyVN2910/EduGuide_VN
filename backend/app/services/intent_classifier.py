"""
Bộ phân loại ý định (Intent Classifier) cho Chatbot giáo dục.
Sử dụng khớp từ khóa (keyword) và biểu thức chính quy (regex) trước; 
chỉ sử dụng LLM khi không thể xác định chắc chắn.
"""

import re
import logging
from enum import Enum

logger = logging.getLogger("intent_classifier")


class Intent(Enum):
    """
    Danh sách các ý định mà hệ thống hỗ trợ nhận diện.
    """
    GREETING = "greeting"           # Chào hỏi
    FAREWELL = "farewell"           # Chào tạm biệt
    THANKS = "thanks"               # Cảm ơn
    COURSE_INFO = "course_info"     # Thông tin môn học cụ thể
    PREREQUISITE = "prerequisite"   # Học phần tiên quyết
    COREQUISITE = "corequisite"     # Học phần song hành
    STUDY_PATH = "study_path"       # Lộ trình học tập / Học kỳ
    CATEGORY_LIST = "category_list" # Danh sách môn theo nhóm (đại cương, chuyên ngành...)
    MAJOR_INFO = "major_info"       # Thông tin về ngành học (CNTT)
    CREDIT_INFO = "credit_info"     # Thông tin về tín chỉ
    COMPARISON = "comparison"       # So sánh giữa các môn học
    COURSE_LIST_ALL = "course_list_all" # Danh sách toàn bộ các môn học
    ELECTIVE_INFO = "elective_info" # Thông tin về các nhóm tự chọn/chuyên ngành hẹp
    GENERAL_ADVICE = "general_advice" # Tư vấn chung/Hỏi đáp tổng quát
    UNRELATED = "unrelated"         # Các chủ đề không liên quan (ngoài giáo dục)


# ── Định nghĩa các mẫu Regex (Patterns) ──────────────────────────────────
# Mỗi phần tử: (Regex đã compile, Intent tương ứng, Độ ưu tiên — số thấp hơn = ưu tiên cao hơn)
_PATTERNS: list[tuple[re.Pattern, Intent, int]] = []


def _p(pattern: str, intent: Intent, priority: int = 50) -> None:
    _PATTERNS.append((re.compile(pattern, re.IGNORECASE), intent, priority))


# Chào hỏi / Tạm biệt / Cám ơn (Độ ưu tiên thấp 90 — để các câu hỏi chuyên môn thắng thế nếu có cả hai)
_p(r"\b(xin\s*chào|chào\s*bạn|chào\s*bot|hello|hi|hey|hê\s*lô|ê\s*ê)\b", Intent.GREETING, 90)
_p(r"\b(tạm\s*biệt|bye|bai|good\s*bye|hẹn\s*gặp)\b", Intent.FAREWELL, 90)
_p(r"\b(cảm\s*ơn|cám\s*ơn|thank|tks|cảm\s*ơn\s*bạn)\b", Intent.THANKS, 90)

# Môn tiên quyết (Ưu tiên cao 20)
_p(
    r"(tiên\s*quyết|điều\s*kiện\s*(tiên|trước)|học\s*trước|prerequisite|"
    r"cần\s*học\s*gì\s*trước|môn\s*gì\s*trước|trước\s*khi\s*học)",
    Intent.PREREQUISITE, 20,
)

# Môn song hành (Ưu tiên cao 20)
_p(
    r"(song\s*hành|đi\s*kèm|thực\s*hành.*đi\s*(với|kèm|cùng)|corequisite|"
    r"môn\s*thực\s*hành|học\s*cùng\s*lúc)",
    Intent.COREQUISITE, 20,
)

# Lộ trình học tập (Ưu tiên 25)
_p(
    r"(lộ\s*trình|học\s*kỳ|semester|roadmap|thứ\s*tự\s*học|nên\s*học\s*gì|"
    r"học\s*theo\s*thứ\s*tự|kế\s*hoạch\s*học|đăng\s*ký\s*gì|lịch\s*trình|"
    r"năm\s*(nhất|hai|ba|tư)|học\s*kỳ\s*\d)",
    Intent.STUDY_PATH, 25,
)

# Nhóm môn học (Ưu tiên 30)
_p(
    r"(nhóm\s*tự\s*chọn|tự\s*chọn|chuyên\s*ngành|đại\s*cương|thể\s*chất|"
    r"quốc\s*phòng|danh\s*sách\s*môn|liệt\s*kê.*môn|môn\s*nào\s*thuộc|"
    r"thuộc\s*nhóm|bắt\s*buộc)",
    Intent.CATEGORY_LIST, 30,
)

# Chuyên ngành hẹp / Tự chọn sâu (Ưu tiên 30)
_p(
    r"(chọn\s*chuyên\s*ngành|nhóm\s*chuyên\s*ngành|phần\s*mềm|hệ\s*thống\s*thông\s*tin|"
    r"mạng\s*máy\s*tính|máy\s*học|an\s*ninh\s*mạng|đồ\s*án\s*tốt\s*nghiệp\s*chọn)",
    Intent.ELECTIVE_INFO, 30,
)

# Thông tin ngành học (Ưu tiên 35)
_p(
    r"(ngành\s*công\s*nghệ\s*thông\s*tin|ngành\s*cntt|tổng\s*(tín\s*chỉ|tc)|"
    r"chương\s*trình\s*đào\s*tạo|thông\s*tin\s*ngành|mã\s*ngành|bao\s*nhiêu\s*tín\s*chỉ\s*tốt\s*nghiệp)",
    Intent.MAJOR_INFO, 35,
)

# Thông tin tín chỉ (Ưu tiên 35)
_p(
    r"(bao\s*nhiêu\s*tín\s*chỉ|số\s*tín\s*chỉ|tín\s*chỉ\s*của|credits?)",
    Intent.CREDIT_INFO, 35,
)

# So sánh môn học (Ưu tiên 40)
_p(
    r"(so\s*sánh|khác\s*nhau|giống\s*nhau|khác\s*gì|khác\s*biệt|hay\s*hơn|nên\s*chọn\s*gì)",
    Intent.COMPARISON, 40,
)

# Danh sách toàn bộ môn (Ưu tiên 40)
_p(
    r"(tất\s*cả\s*(các\s*)?môn|toàn\s*bộ\s*môn|all\s*courses|bao\s*nhiêu\s*môn|"
    r"có\s*những\s*môn\s*gì|có\s*bao\s*nhiêu\s*môn)",
    Intent.COURSE_LIST_ALL, 40,
)

# Thông tin môn học chung (Phạm vi rộng, ưu tiên thấp 60)
_p(
    r"(môn\s*học|mã\s*môn|tên\s*môn|thông\s*tin\s*môn|course|"
    r"cho\s*tôi\s*biết\s*về|giới\s*thiệu\s*về|gì\s*vậy|là\s*gì)",
    Intent.COURSE_INFO, 60,
)

# Tư vấn chung (Ưu tiên 70)
_p(
    r"(tư\s*vấn|giúp\s*tôi|hướng\s*dẫn|khuyên|nên\s*làm\s*gì|gợi\s*ý|"
    r"bạn\s*(có\s*thể|giúp)|cho\s*hỏi|hỏi\s*một\s*chút)",
    Intent.GENERAL_ADVICE, 70,
)


# ── Nhận diện các chủ đề không liên quan ──────────────────────────────
_UNRELATED_PATTERNS = re.compile(
    r"(thời\s*tiết|bóng\s*đá\s*(ngoại\s*hạng|vô\s*địch)|nấu\s*ăn|phim|game|"
    r"bitcoin|crypto|chứng\s*khoán|cá\s*cược|giá\s*vàng|tử\s*vi|"
    r"yêu\s*đương|hẹn\s*hò|bói\s*toán|chính\s*trị\s*thế\s*giới)",
    re.IGNORECASE,
)


def classify_intent(message: str) -> tuple[Intent, float]:
    """
    Phân loại tin nhắn của người dùng vào một Ý định (Intent).
    Trả về: (Intent, điểm_tin_cậy). Điểm ∈ [0, 1].
    """
    text = message.strip()
    if not text:
        return Intent.GREETING, 0.9

    # 1. Kiểm tra xem có phải nội dung không liên quan không
    if _UNRELATED_PATTERNS.search(text):
        return Intent.UNRELATED, 0.85

    # 2. Chạy qua tất cả các mẫu; trả về kết quả khớp có ưu tiên cao nhất (số thấp nhất)
    matches: list[tuple[Intent, int]] = []
    for pattern, intent, priority in _PATTERNS:
        if pattern.search(text):
            matches.append((intent, priority))

    if matches:
        # Sắp xếp theo độ ưu tiên (tăng dần) → kết quả tốt nhất lên đầu
        matches.sort(key=lambda x: x[1])
        best_intent, best_priority = matches[0]
        # Độ ưu tiên cao (số thấp) → điểm tin cậy cao
        confidence = max(0.5, 1.0 - best_priority / 100)
        logger.info(
            "[Ý ĐỊNH] '%s' → %s (confidence=%.2f, ứng viên=%d)",
            text[:60], best_intent.value, confidence, len(matches),
        )
        return best_intent, confidence

    # 3. Không khớp mẫu nào — mặc định là tư vấn chung với độ tin cậy thấp
    logger.info("[Ý ĐỊNH] '%s' → general_advice (không khớp mẫu nào)", text[:60])
    return Intent.GENERAL_ADVICE, 0.3


def is_education_related(message: str) -> bool:
    """Kiểm tra nhanh xem tin nhắn có liên quan đến giáo dục không."""
    edu_keywords = re.compile(
        r"(môn|học|tín\s*chỉ|tiên\s*quyết|song\s*hành|đại\s*cương|chuyên\s*ngành|"
        r"ngành|lớp|kỳ|đăng\s*ký|lập\s*trình|toán|anh\s*ngữ|thực\s*hành|"
        r"đồ\s*án|tốt\s*nghiệp|giảng\s*viên|hutech|cntt|course|credit|semester)",
        re.IGNORECASE,
    )
    return bool(edu_keywords.search(message))
