"""
Kiến thức tĩnh và Siêu dữ liệu (Static Knowledge & Metadata) về chương trình đào tạo CNTT HUTECH.
Dữ liệu này KHÔNG cần truy vấn Neo4j — nó được biên soạn trực tiếp từ chương trình khung chính thức.
"""

# ── Thông tin tổng quan về Ngành học ──────────────────────────────────
MAJOR_INFO = {
    "id": "7480201",
    "name": "Công nghệ thông tin",
    "university": "Đại học Công nghệ TP.HCM (HUTECH)",
    "total_credits": 150,
    "non_accum_credits": 5,
    "duration_years": 4,
    "degree": "Cử nhân",
    "structure": {
        "Đại cương": {"credits": 50, "description": "Kiến thức giáo dục đại cương bao gồm lý luận chính trị, ngoại ngữ, toán, kỹ năng mềm, và nhập môn ngành."},
        "Chuyên nghiệp bắt buộc": {"credits": 91, "description": "Kiến thức chuyên nghiệp bắt buộc bao gồm lập trình, cơ sở dữ liệu, mạng, bảo mật, AI, cloud, và các đồ án."},
        "Tự chọn chuyên ngành": {"credits": 9, "description": "Chọn 3 môn (9 tín chỉ) từ 1 trong 6 nhóm chuyên ngành."},
        "Thể chất": {"credits": 5, "description": "Chọn 1 trong 5 nhóm thể chất (không tích lũy)."},
        "Quốc phòng An ninh": {"credits": 0, "description": "4 môn Quốc phòng An ninh (không tích lũy)."},
    },
}

# ── Thông tin các Nhóm tự chọn chuyên ngành ───────────────────────────
ELECTIVE_GROUPS = {
    "Công nghệ phần mềm": {
        "description": "Tập trung vào phát triển và kiểm thử phần mềm chuyên nghiệp.",
        "courses": ["Kiểm thử và đảm bảo chất lượng phần mềm", "Ngôn ngữ phát triển ứng dụng mới", "Phát triển ứng dụng với J2EE"],
    },
    "Hệ thống thông tin ứng dụng": {
        "description": "Tập trung vào phân tích nghiệp vụ, dữ liệu lớn, và khoa học dữ liệu.",
        "courses": ["Phân tích nghiệp vụ", "Khoa học dữ liệu phân tán", "Phân tích dữ liệu lớn"],
    },
    "Mạng máy tính": {
        "description": "Tập trung vào quản trị mạng, hạ tầng cloud, và đánh giá hiệu suất.",
        "courses": ["Quản trị dịch vụ mạng trên điện toán đám mây", "Hệ điều hành Linux", "Phân tích đánh giá hiệu suất mạng"],
    },
    "Máy học và ứng dụng": {
        "description": "Tập trung vào deep learning, computer vision, và AI-IoT.",
        "courses": ["Học sâu", "Thị giác máy tính", "Trí tuệ nhân tạo cho internet vạn vật"],
    },
    "An ninh mạng": {
        "description": "Tập trung vào bảo mật web, mạng, cloud, và đánh giá an toàn.",
        "courses": ["An toàn thông tin cho ứng dụng web", "An toàn hệ thống mạng máy tính và đám mây", "Phân tích và đánh giá an toàn thông tin"],
    },
    "Đồ án tốt nghiệp": {
        "description": "Thực hiện đồ án nghiên cứu/ứng dụng toàn diện (9 tín chỉ).",
        "courses": ["Đồ án tốt nghiệp Công nghệ thông tin"],
    },
}

# ── Lộ trình học tập gợi ý 8 học kỳ ──────────────────────────────────
STUDY_PATH = [
    {
        "semester": 1,
        "title": "Học kỳ 1 — Nền tảng",
        "courses": [
            "Triết học Mác - Lênin",
            "Anh ngữ 1",
            "Đại số tuyến tính",
            "Nhập môn ngành Công nghệ thông tin",
            "Cơ sở lập trình + TH Cơ sở lập trình",
            "Phát triển bền vững",
        ],
        "credits": 19,
    },
    {
        "semester": 2,
        "title": "Học kỳ 2 — Lập trình cơ bản",
        "courses": [
            "Kinh tế chính trị Mác - Lênin",
            "Anh ngữ 2",
            "Giải tích",
            "Kỹ thuật lập trình + TH Kỹ thuật lập trình",
            "Pháp luật đại cương",
            "Tư duy thiết kế dự án",
        ],
        "credits": 19,
    },
    {
        "semester": 3,
        "title": "Học kỳ 3 — Nền tảng chuyên ngành",
        "courses": [
            "Chủ nghĩa xã hội khoa học",
            "Anh ngữ 3",
            "Xác suất thống kê",
            "Lập trình hướng đối tượng + TH",
            "Cấu trúc dữ liệu và giải thuật + TH",
            "Nhập môn cơ sở dữ liệu + TH",
        ],
        "credits": 21,
    },
    {
        "semester": 4,
        "title": "Học kỳ 4 — Chuyên sâu",
        "courses": [
            "Lịch sử Đảng Cộng sản Việt Nam",
            "Tư tưởng Hồ Chí Minh",
            "Anh ngữ 4",
            "Toán rời rạc",
            "Kiến trúc và hệ điều hành máy tính + TH",
            "Mạng máy tính + TH",
            "Công nghệ phần mềm",
        ],
        "credits": 22,
    },
    {
        "semester": 5,
        "title": "Học kỳ 5 — Phát triển ứng dụng",
        "courses": [
            "Lập trình web + TH",
            "Lập trình trên môi trường Windows + TH",
            "Bảo mật thông tin + TH",
            "Các hệ quản trị cơ sở dữ liệu + TH",
            "Đổi mới sáng tạo và tư duy khởi nghiệp",
            "Phân tích thiết kế hệ thống + TH",
        ],
        "credits": 22,
    },
    {
        "semester": 6,
        "title": "Học kỳ 6 — Nâng cao & Thực tập",
        "courses": [
            "Lập trình trên thiết bị di động",
            "Lập trình mạng máy tính + TH",
            "Cơ sở an toàn thông tin và máy chủ + TH",
            "Điện toán đám mây + TT",
            "Cơ sở trí tuệ nhân tạo",
            "Máy học",
            "Thực tập cơ sở ngành CNTT",
        ],
        "credits": 22,
    },
    {
        "semester": 7,
        "title": "Học kỳ 7 — Chuyên ngành & Đồ án",
        "courses": [
            "Quản lý dự án CNTT",
            "Nghệ thuật lập trình với hỗ trợ AI",
            "3 môn tự chọn chuyên ngành (9 TC)",
            "Đồ án chuyên ngành CNTT",
        ],
        "credits": 18,
    },
    {
        "semester": 8,
        "title": "Học kỳ 8 — Tốt nghiệp",
        "courses": [
            "Thực tập tốt nghiệp ngành CNTT",
            "Đồ án tốt nghiệp CNTT (9 TC) hoặc môn thay thế",
        ],
        "credits": 12,
    },
]


# ── Mẫu phản hồi Chào hỏi / Tạm biệt / Cám ơn ─────────────────────────
GREETING_RESPONSES = [
    "Xin chào! 👋 Mình là **ChatBoxAI** — trợ lý tư vấn học tập ngành Công nghệ thông tin tại HUTECH.\n\nBạn có thể hỏi mình về:\n- 📚 Thông tin môn học, tín chỉ, mã môn\n- 🔗 Điều kiện tiên quyết & môn song hành\n- 🗺️ Lộ trình học tập gợi ý 8 học kỳ\n- 📋 Nhóm tự chọn chuyên ngành\n- 💡 Tư vấn đăng ký môn\n\nHãy hỏi mình bất cứ điều gì nhé! 😊",
]

FAREWELL_RESPONSES = [
    "Tạm biệt bạn! 👋 Chúc bạn học tập thật tốt. Nếu cần hỗ trợ, cứ quay lại hỏi mình nhé! 😊",
]

THANKS_RESPONSES = [
    "Không có gì! 😊 Mình rất vui khi giúp được bạn. Nếu có câu hỏi khác, cứ hỏi mình nhé!",
]

UNRELATED_RESPONSE = (
    "Xin lỗi, mình là trợ lý tư vấn **chương trình đào tạo ngành CNTT** tại HUTECH. 🎓\n\n"
    "Mình chỉ có thể hỗ trợ các câu hỏi liên quan đến:\n"
    "- 📚 Môn học, tín chỉ, mã môn\n"
    "- 🔗 Điều kiện tiên quyết & môn song hành\n"
    "- 🗺️ Lộ trình học tập\n"
    "- 📋 Nhóm tự chọn chuyên ngành\n\n"
    "Bạn hãy thử hỏi về một môn học cụ thể nhé! 😊"
)

NO_DATA_RESPONSE = (
    "Mình không tìm thấy thông tin phù hợp trong hệ thống. 😅\n\n"
    "**Gợi ý:**\n"
    "- Thử dùng tên đầy đủ của môn học (ví dụ: \"Lập trình web\" thay vì \"web\")\n"
    "- Hoặc dùng mã môn (ví dụ: \"CMP175\")\n"
    "- Hỏi cụ thể hơn: \"Điều kiện tiên quyết của môn Lập trình web là gì?\""
)


def get_major_overview() -> str:
    """Trả về chuỗi văn bản đã định dạng về tổng quan ngành CNTT."""
    info = MAJOR_INFO
    lines = [
        f"## 🎓 Ngành {info['name']} — {info['university']}",
        f"- **Mã ngành:** {info['id']}",
        f"- **Bậc đào tạo:** {info['degree']}",
        f"- **Thời gian:** {info['duration_years']} năm",
        f"- **Tổng tín chỉ tích lũy:** {info['total_credits']} TC",
        f"- **Tín chỉ không tích lũy:** {info['non_accum_credits']} TC",
        "",
        "### 📊 Cấu trúc chương trình:",
    ]
    for cat, detail in info["structure"].items():
        line = f"- **{cat}:** {detail['credits']} TC — {detail['description']}"
        lines.append(line)
    return "\n".join(lines)


def get_study_path_text() -> str:
    """Trả về chuỗi văn bản đã định dạng về lộ trình học tập gợi ý."""
    lines = ["## 🗺️ Lộ trình học tập gợi ý — 8 học kỳ\n"]
    for sem in STUDY_PATH:
        lines.append(f"### {sem['title']} ({sem['credits']} TC)")
        for course in sem["courses"]:
            lines.append(f"- {course}")
        lines.append("")
    lines.append(
        "> ⚠️ **Lưu ý:** Đây là lộ trình gợi ý. Sinh viên nên tham khảo thêm với "
        "cố vấn học tập để điều chỉnh phù hợp với tiến độ cá nhân."
    )
    return "\n".join(lines)


def get_elective_groups_text() -> str:
    """Trả về chuỗi văn bản đã định dạng về các nhóm môn tự chọn."""
    lines = [
        "## 📋 Các nhóm tự chọn chuyên ngành",
        "*Sinh viên chọn **1 nhóm** và hoàn thành **3 môn (9 TC)** trong nhóm đó.*\n",
    ]
    for i, (name, info) in enumerate(ELECTIVE_GROUPS.items(), 1):
        lines.append(f"### Nhóm {i}: {name}")
        lines.append(f"*{info['description']}*")
        for c in info["courses"]:
            lines.append(f"- {c}")
        lines.append("")
    return "\n".join(lines)
