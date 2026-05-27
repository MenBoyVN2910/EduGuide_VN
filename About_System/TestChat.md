# 🧪 KỊCH BẢN KIỂM THỬ CHATBOX AI (TEST SCENARIOS)

Tài liệu này cung cấp các bộ câu hỏi mẫu để kiểm tra độ chính xác và khả năng phản hồi của hệ thống EduGuide VN. Các câu hỏi được sắp xếp theo mức độ phức tạp tăng dần.

---

## 🟢 CẤP ĐỘ 1: THÔNG TIN TỔNG QUAN (CƠ BẢN)
*Mục tiêu: Kiểm tra khả năng truy xuất dữ liệu tĩnh và thông tin chung về ngành học.*

| STT | Câu hỏi kiểm thử | Kết quả mong đợi |
| :-- | :--- | :--- |
| 1 | "Ngành CNTT học bao nhiêu năm và có bao nhiêu tín chỉ?" | Trả lời: 3.5 - 4 năm, tổng ~150 tín chỉ. |
| 2 | "Ngành IT có những chuyên ngành hẹp nào?" | Liệt kê các chuyên ngành: Kỹ thuật phần mềm, Hệ thống thông tin, An toàn thông tin... |
| 3 | "Học kỳ 1 năm nhất gồm những môn gì?" | Liệt kê danh sách môn học đại cương của kỳ 1. |
| 4 | "Tổng số tín chỉ cần tích lũy để tốt nghiệp là bao nhiêu?" | Xác nhận con số 150 tín chỉ. |

---

## 🟡 CẤP ĐỘ 2: TRA CỨU CHI TIẾT MÔN HỌC (TRUNG BÌNH)
*Mục tiêu: Kiểm tra khả năng truy vấn trực tiếp vào Database đồ thị (Neo4j) để lấy thông số môn học.*

| STT | Câu hỏi kiểm thử | Kết quả mong đợi |
| :-- | :--- | :--- |
| 5 | "Môn Lập trình hướng đối tượng có bao nhiêu tín chỉ?" | Trả lời chính xác số tín chỉ (ví dụ: 3 tín chỉ). |
| 6 | "Mã môn học của môn Cơ sở dữ liệu là gì?" | Trả lời đúng mã số môn học trong hệ thống. |
| 7 | "Môn Toán rời rạc có phần thực hành không?" | Trả lời Có/Không dựa trên cấu trúc môn học. |
| 8 | "Môn Đồ án chuyên ngành thuộc nhóm kiến thức nào?" | Trả lời: Kiến thức chuyên ngành/Cơ sở ngành. |

---

## 🟠 CẤP ĐỘ 3: ĐIỀU KIỆN TIÊN QUYẾT & LỘ TRÌNH (PHỨC TẠP)
*Mục tiêu: Kiểm tra khả năng duyệt đồ thị (Graph Traversal) để tìm mối quan hệ giữa các môn học.*

| STT | Câu hỏi kiểm thử | Kết quả mong đợi |
| :-- | :--- | :--- |
| 9 | "Để học môn Lập trình Web thì cần hoàn thành môn nào trước?" | Trả lời môn tiên quyết (ví dụ: Cấu trúc dữ liệu hoặc Cơ sở dữ liệu). |
| 10 | "Mình chưa học Kỹ thuật lập trình thì có được học Cấu trúc dữ liệu không?" | Phân tích điều kiện tiên quyết và đưa ra lời khuyên. |
| 11 | "Cho mình biết lộ trình các môn cần học để có thể làm về Trí tuệ nhân tạo?" | Đưa ra chuỗi môn học: Toán rời rạc -> Xác suất -> Học máy... |
| 12 | "Môn Đồ án tốt nghiệp yêu cầu những điều kiện gì?" | Liệt kê các môn tiên quyết và số tín chỉ tích lũy tối thiểu. |

---

## 🔴 CẤP ĐỘ 4: TƯ VẤN & XỬ LÝ TÌNH HUỐNG (NÂNG CAO)
*Mục tiêu: Kiểm tra khả năng suy luận của AI và xử lý các câu hỏi ngoài phạm vi.*

| STT | Câu hỏi kiểm thử | Kết quả mong đợi |
| :-- | :--- | :--- |
| 13 | "Học kỳ này mình muốn học nhẹ, hãy gợi ý cho mình 3 môn ít tín chỉ nhất." | So sánh số tín chỉ và gợi ý môn phù hợp. |
| 14 | "Mình thích lập trình Game, mình nên tập trung vào những môn nào trong chương trình?" | Gợi ý các môn liên quan: Đồ họa máy tính, OOP, Cấu trúc dữ liệu... |
| 15 | "Làm sao để nấu món phở bò ngon?" | Hệ thống từ chối lịch sự (do ngoài phạm vi giáo dục). |
| 16 | "Môn học abcxyz có bao nhiêu tín chỉ?" | Hệ thống báo không tìm thấy môn học này trong dữ liệu. |

---

## 💡 MẸO ĐỂ CÓ KẾT QUẢ TEST TỐT NHẤT
1. **Sử dụng câu đầy đủ:** Thay vì chỉ gõ "tín chỉ", hãy hỏi "Môn X có bao nhiêu tín chỉ?".
2. **Kiểm tra Voice-to-Text:** Nhấn icon 🎤 và nói thử các câu hỏi ở Cấp độ 1 để test độ nhạy của microphone.
3. **Xóa lịch sử chat:** Khi chuyển sang một chủ đề test hoàn toàn mới, hãy nhấn **"+ Cuộc trò chuyện mới"** để AI không bị nhầm lẫn bởi ngữ cảnh cũ.

---
> [!IMPORTANT]
> Nếu Chatbot trả lời sai về điều kiện tiên quyết, hãy kiểm tra lại file `CypherQuery/CNTT.txt` xem các mối quan hệ `[:PREREQUISITE]` đã được nạp đúng vào Neo4j chưa.
