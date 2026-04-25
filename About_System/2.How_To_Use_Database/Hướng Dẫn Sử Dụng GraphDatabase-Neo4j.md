# 📘 Hướng Dẫn Toàn Tập: Graph Database & Neo4j cho EduGuide VN

> **Tài liệu tổng hợp về cách vận hành, thiết kế và quản trị cơ sở dữ liệu đồ thị trong hệ thống EduGuide.**

Tài liệu này giúp bạn hiểu từ kiến thức cơ bản đến cách viết truy vấn nâng cao để quản lý chương trình đào tạo trên Neo4j.

---

## 📑 Mục lục

1. [Khái niệm Graph Database & Neo4j](#1-khái-niệm-graph-database--neo4j)
2. [Thiết kế Schema (Cấu trúc dữ liệu)](#2-thiết-kế-schema-cấu-trúc-dữ-liệu)
3. [Cách Chatbot đọc dữ liệu](#3-cách-chatbot-đọc-dữ-liệu)
4. [Hướng dẫn viết Cypher Query](#4-hướng-dẫn-viết-cypher-query)
5. [Quy trình nạp dữ liệu (Import)](#5-quy-trình-nạp-dữ-liệu-import)
6. [Các câu lệnh hữu ích & Quy tắc vàng](#6-các-câu-lệnh-hữu-ích--quy-tắc-vàng)

---

## 1. Khái niệm Graph Database & Neo4j

### 🧠 Graph Database là gì?

Thay vì lưu trữ dạng bảng (rows & columns) như SQL, **Graph Database** lưu dữ liệu dưới dạng **Node (Nút)** và **Relationship (Mối quan hệ)**.

- **Node**: Đại diện cho một đối tượng (ví dụ: Môn học, Ngành học).
- **Relationship**: Kết nối các Node (ví dụ: Môn A là tiên quyết của môn B).

### 🚀 Tại sao dùng Neo4j?

Hệ thống EduGuide sử dụng Neo4j vì chương trình đào tạo có mạng lưới môn học phức tạp:

- Truy vấn chuỗi môn tiên quyết cực nhanh (không cần JOIN nhiều bảng).
- AI dễ dàng hiểu được lộ trình học tập để tư vấn chính xác.
- Linh hoạt mở rộng: Thêm ngành mới chỉ cần thêm các Node và nối dây.

---

## 2. Thiết kế Schema (Cấu trúc dữ liệu)

Để Chatbot hoạt động chính xác, dữ liệu cần được thiết kế theo cấu trúc (Schema) chuẩn sau:

### 🅰️ Node `Course` (Môn học) - Bắt buộc

Mỗi môn học phải có label `:Course` và các thuộc tính (Property) sau:

- `id`: Mã học phần (Ví dụ: `CMP164`) - **Dùng để định danh duy nhất.**
- `name`: Tên môn học (Ví dụ: `Kỹ thuật lập trình`) - **AI sẽ đọc tên này.**
- `credits`: Số tín chỉ (Ví dụ: `3`) - **Dùng để tính toán và trả lời.**

### 🅱️ Node `Major` (Ngành học)

- `id`: Mã ngành.
- `name`: Tên ngành (Ví dụ: `Công nghệ thông tin`).
- `total_credits`: Tổng số tín chỉ của toàn ngành.

### 🔗 Mối quan hệ (Relationship)

- `PREREQUISITE_FOR`: Môn tiên quyết (Chiều: `Môn trước` -> `Môn sau`).
- `COREQUISITE_WITH`: Môn song hành (Học cùng lúc).
- `BELONGS_TO`: Môn thuộc về một ngành hoặc nhóm kiến thức nào đó.

---

## 3. Cách Chatbot đọc dữ liệu

Khi bạn hỏi: _"Môn Kỹ thuật lập trình có bao nhiêu tín chỉ?"_, Backend sẽ chạy lệnh Cypher sau để lấy dữ liệu từ Neo4j:

```cypher
MATCH (c:Course {name: 'Kỹ thuật lập trình'})
OPTIONAL MATCH (p:Course)-[:PREREQUISITE_FOR]->(c)
RETURN c.id, c.name, c.credits, collect(p.name) AS prerequisites
```

**Chú thích:**

1. `MATCH`: Tìm môn học có tên tương ứng.
2. `OPTIONAL MATCH`: Tìm thêm các môn tiên quyết (nếu có).
3. `RETURN`: Trả về kết quả cho AI xử lý ngữ cảnh và trả lời người dùng.

---

## 4. Hướng dẫn viết Cypher Query

### Tạo dữ liệu an toàn với `MERGE`

Sử dụng `MERGE` thay vì `CREATE` để tránh tạo trùng lặp dữ liệu nếu chạy lệnh nhiều lần.

```cypher
// 1. Tạo môn học
MERGE (c:Course {id: 'CMP164', name: 'Kỹ thuật lập trình', credits: 3});

// 2. Tạo mối quan hệ tiên quyết
MATCH (pre:Course {id: 'CMP1074'}), (next:Course {id: 'CMP164'})
MERGE (pre)-[:PREREQUISITE_FOR]->(next);
```

### Xóa dữ liệu

```cypher
// Xóa một node cụ thể và các quan hệ của nó
MATCH (c:Course {id: 'OLD123'}) DETACH DELETE c;

// Xóa sạch toàn bộ database (Cẩn thận!)
MATCH (n) DETACH DELETE n;
```

---

## 5. Quy trình nạp dữ liệu (Import)

Dữ liệu chính của hệ thống nằm trong file `CypherQuery/CNTT.txt`. Để nạp dữ liệu mới:

1. **Chuẩn bị file**: Viết các câu lệnh `MERGE` cho toàn bộ môn học và ngành.
2. **Mở Neo4j Browser**: Truy cập [http://localhost:7474](http://localhost:7474).
3. **Đăng nhập**: User `neo4j` / Pass `QAZplm6002`.
4. **Bật Multi-statement**: Vào ⚙️ Settings -> Bật "Enable multi statement query editor".
5. **Chạy lệnh**: Copy nội dung file `.txt`, dán vào ô lệnh và nhấn **Run**.

---

## 6. Các câu lệnh hữu ích & Quy tắc vàng

### Câu lệnh kiểm tra nhanh

- **Xem toàn bộ đồ thị**: `MATCH (n) RETURN n LIMIT 100`
- **Đếm số môn học**: `MATCH (c:Course) RETURN count(c)`
- **Tìm các môn không có tiên quyết**: `MATCH (c:Course) WHERE NOT (:Course)-[:PREREQUISITE_FOR]->(c) RETURN c.name`

### 💡 Quy tắc vàng (Phải nhớ)

1. **Property `id` là duy nhất**: Tuyệt đối không để 2 môn khác nhau trùng `id`.
2. **Đúng nhãn (Label)**: Luôn dùng `:Course` cho môn học và `:Major` cho ngành.
3. **Chiều mũi tên**: Luôn là `(Môn học trước) -[:PREREQUISITE_FOR]-> (Môn học sau)`.
4. **Không cần restart**: Khi bạn thay đổi dữ liệu trong Neo4j, Chatbot sẽ cập nhật thông tin ngay lập tức (Realtime).
5. **Kiểm tra dữ liệu**: Sau khi import, hãy dùng Neo4j Browser để nhìn trực quan xem các mũi tên đã nối đúng chưa.

---

_Tài liệu được biên soạn để hỗ trợ đội ngũ phát triển và vận hành EduGuide VN._

cre:MenBoyBMN
