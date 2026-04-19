// ╔══════════════════════════════════════════════════════════════╗
// ║ Gồm Các Câu Hỏi Hệ Thống Có Thể Sử Lý ║
// ╚══════════════════════════════════════════════════════════════╝

1.Điều kiện tiên quyết của môn Lập trình web là gì...?
2.Cho mình hỏi lộ trình học kỳ 1 của ngành IT?
3.Ngành Công nghệ thông tin học bao nhiêu năm, tổng cộng bao nhiêu tín chỉ?

Dựa trên các chức năng (Intent) mà chúng ta đã cấu hình trong intent_classifier.py và cấu trúc dữ liệu lưu trong Graph Neo4j, hệ thống của bạn có thể xử lý rất tốt các nhóm câu hỏi sau.

Bạn có thể copy trực tiếp các câu này vào giao diện http://localhost:5173/ hoặc Terminal để test nhé:

🎓 1. Nhóm Tra cứu Lộ trình & Thông tin Ngành (Static Context)
Hệ thống sẽ lấy thông tin tổng quan của ngành CNTT HUTECH (150 tín chỉ) và gợi ý 8 học kỳ.

"Ngành Công nghệ thông tin học bao nhiêu năm, tổng cộng bao nhiêu tín chỉ?"
"Có những chuyên ngành tự chọn nào trong ngành IT?"
"Học kỳ 3 thì sinh viên IT thường phải học những môn gì?"
"Tư vấn cho mình lộ trình học tập của năm nhất nhé."
🔗 2. Nhóm Truy xuất Môn Tiên Quyết / Song Hành (Graph Neo4j)
Hệ thống chuyển đổi câu hỏi thành truy vấn Cypher và đi dọc theo các mũi tên [PREREQUISITE] trong đồ thị mạng lưới để tìm môn học gốc.

"Để học môn Đồ án chuyên ngành CNTT thì cần phải học qua môn tiên quyết nào?"
"Môn Cấu trúc dữ liệu và giải thuật có môn học trước không?"
"Mình chưa học Lập trình hướng đối tượng thì có đăng ký được Lập trình web không?"
"Học máy (Machine Learning) yêu cầu điều kiện tiên quyết là gì vậy?"
📚 3. Nhóm Truy vấn Thông tin Môn học Cụ thể (Graph Neo4j)
Truy xuất trực tiếp các Node Course trong sơ đồ đồ thị tri thức.

"Môn Điện toán đám mây là mấy tín chỉ?"
"Mã môn của môn Toán rời rạc là gì thế?"
"Môn Cơ sở lập trình có thực hành không, tổng cộng bao nhiêu tín chỉ?"
"Mình tính đăng ký An toàn hệ thống mạng máy tính và đám mây, môn này thuộc nhóm chuyên ngành nào?"
💡 Mẹo khi test: Thay vì hỏi những câu cụt lủn (ví dụ chỉ gõ "lập trình"), bạn nên dùng nguyên câu tự nhiên rõ ràng (ví dụ: "cho hỏi môn lập trình mạng có môn tiên quyết không"). Khi đó, Bộ phân loại ý định (Intent Classifier) sẽ tự động nhận diện từ khóa và Gemini sẽ bóc tách thực thể cực kì chính xác để query xuống Neo4j.

Bạn hãy thử copy 1 câu ở phần 2 hoặc 3 ném vào trang thử nghiệm xem tốc độ và chất lượng phản hồi ra sao nhé!
