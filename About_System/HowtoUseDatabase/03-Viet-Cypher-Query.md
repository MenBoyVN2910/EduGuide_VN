# ✍️ Hướng Dẫn Viết Cypher Query Cho EduGuide

## 1. Cú pháp Cypher cơ bản

### Tạo Node (MERGE):

```cypher
// Tạo 1 môn học (MERGE = tạo nếu chưa có, không tạo trùng)
MERGE (c:Course {id: 'CMP164', name: 'Kỹ thuật lập trình', credits: 3})
```

Giải thích:
- `MERGE` — Tạo nếu chưa tồn tại (an toàn hơn `CREATE`)
- `(c:Course {...})` — Tạo Node có label `Course`, gán biến `c`
- `{id: ..., name: ..., credits: ...}` — 3 property bắt buộc

### Tạo Relationship (Mối quan hệ):

```cypher
// Tìm 2 môn rồi nối chúng
MATCH (pre:Course {id: 'CMP1074'}), (c:Course {id: 'CMP164'})
MERGE (pre)-[:PREREQUISITE_FOR]->(c)
```

Giải thích:
- `MATCH` — Tìm Node đã tồn tại trong database
- `(pre)-[:PREREQUISITE_FOR]->(c)` — Tạo mũi tên từ `pre` đến `c`
- Nghĩa: CMP1074 (Cơ sở lập trình) là tiên quyết cho CMP164 (Kỹ thuật lập trình)

---

## 2. Cách viết file `CNTT.txt` cho hệ thống

File `CypherQuery/CNTT.txt` chứa toàn bộ lệnh Cypher để tạo dữ liệu. Quy tắc:

### Cấu trúc file:

```
Phần 1: Xóa dữ liệu cũ (clean slate)
Phần 2: Tạo Node ngành (Major)
Phần 3: Tạo tất cả Node môn học (Course)
Phần 4: Tạo mối quan hệ tiên quyết (PREREQUISITE_FOR)
Phần 5: Tạo mối quan hệ song hành (COREQUISITE_WITH)
```

### Ví dụ mẫu hoàn chỉnh:

```cypher
// === PHẦN 1: XÓA DỮ LIỆU CŨ ===
MATCH (n) DETACH DELETE n;

// === PHẦN 2: TẠO NGÀNH ===
MERGE (:Major {id: '7480201', name: 'Công nghệ thông tin', university: 'HUTECH', total_credits: 150});

// === PHẦN 3: TẠO MÔN HỌC ===
MERGE (:Course {id: 'CMP1074', name: 'Cơ sở lập trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP164', name: 'Kỹ thuật lập trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// === PHẦN 4: TIÊN QUYẾT ===
MATCH (pre:Course {id: 'CMP1074'}), (c:Course {id: 'CMP164'})
MERGE (pre)-[:PREREQUISITE_FOR]->(c);

// === PHẦN 5: SONG HÀNH ===
MATCH (a:Course {id: 'CMP365'}), (b:Course {id: 'CMP164'})
MERGE (a)-[:COREQUISITE_WITH]->(b);
```

---

## 3. Cách import vào Neo4j Browser

1. Mở **http://localhost:7474**
2. Đăng nhập: `neo4j` / `QAZplm6002`
3. **Bật Multi-statement mode**: Nhấn ⚙️ Settings → Bật "Enable multi statement query editor"
4. Copy toàn bộ nội dung file `CypherQuery/CNTT.txt`
5. Dán vào ô lệnh → Nhấn **▶ Run** hoặc `Ctrl+Enter`

---

## 4. Câu lệnh Cypher hữu ích

### Kiểm tra dữ liệu đã import:

```cypher
// Đếm số môn học
MATCH (c:Course) RETURN count(c)

// Xem tất cả môn và tiên quyết
MATCH (c:Course)
OPTIONAL MATCH (p:Course)-[:PREREQUISITE_FOR]->(c)
RETURN c.id, c.name, c.credits, collect(p.name) AS prerequisites

// Xem đồ thị trực quan
MATCH (n) RETURN n LIMIT 50

// Tìm lộ trình từ 1 môn cụ thể
MATCH path = (start:Course)-[:PREREQUISITE_FOR*]->(end:Course {id: 'COS120'})
RETURN path
```

### Thêm 1 môn mới:

```cypher
MERGE (:Course {id: 'ABC123', name: 'Tên môn mới', credits: 3, category: 'Tự chọn'})
```

### Thêm tiên quyết cho môn:

```cypher
MATCH (pre:Course {id: 'ABC123'}), (c:Course {id: 'XYZ456'})
MERGE (pre)-[:PREREQUISITE_FOR]->(c)
```

### Xóa 1 môn:

```cypher
MATCH (c:Course {id: 'ABC123'}) DETACH DELETE c
```

---

## 5. Lưu ý quan trọng

1. **Luôn dùng MERGE thay CREATE** — Tránh tạo Node trùng lặp
2. **Kiểm tra chiều mũi tên** — `(tiên quyết)-[:PREREQUISITE_FOR]->(môn cần)` 
3. **Mỗi lệnh kết thúc bằng `;`** — Bắt buộc khi chạy nhiều lệnh cùng lúc
4. **Property `id` phải khớp mã HP** — Chính xác như trong sơ đồ đào tạo
5. **Sau khi thay đổi dữ liệu, KHÔNG cần restart backend** — Backend đọc Neo4j realtime
