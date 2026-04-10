# 🏗️ Thiết Kế Schema — Chatbot Đọc Dữ Liệu Như Thế Nào?

## 1. Chatbot đọc Neo4j bằng cách nào?

Khi người dùng hỏi một câu hỏi, hệ thống hoạt động theo 3 bước:

```
Người dùng hỏi          Backend truy vấn Neo4j         AI Gemini trả lời
─────────────────►  ──────────────────────────►  ──────────────────────►
"Môn CTDL cần         Lấy tất cả Course +            Dựa vào ngữ cảnh
 học gì trước?"       prerequisites từ Graph          để trả lời chính xác
```

### Đoạn code backend quan trọng (`chat_agent.py`):

```python
# Backend chạy câu lệnh Cypher này để lấy dữ liệu từ Neo4j
query_cypher = """
MATCH (c:Course)
OPTIONAL MATCH (p:Course)-[:PREREQUISITE_FOR]->(c)
RETURN c.id AS id, c.name AS name, c.credits AS credits,
       collect(p.name) AS prerequisites
"""
```

### Giải thích từng dòng:

| Dòng Cypher                                          | Ý nghĩa                                    |
| ---------------------------------------------------- | ------------------------------------------ |
| `MATCH (c:Course)`                                   | Tìm tất cả Node có label `Course`          |
| `OPTIONAL MATCH (p:Course)-[:PREREQUISITE_FOR]->(c)` | Tìm các môn `p` là tiên quyết của `c`      |
| `RETURN c.id, c.name, c.credits`                     | Trả về mã, tên, số tín chỉ                 |
| `collect(p.name) AS prerequisites`                   | Gom tên các môn tiên quyết thành danh sách |

---

## 2. Schema bắt buộc — Chatbot cần những gì?

Dựa vào đoạn code trên, dữ liệu trong Neo4j **PHẢI** tuân theo schema sau:

### Node `Course` — Bắt buộc 3 property:

```
(:Course {
    id: 'CMP164',           ← Mã học phần (PHẢI có, dùng làm identifier)
    name: 'Kỹ thuật lập trình',  ← Tên học phần (PHẢI có, AI đọc tên này)
    credits: 3              ← Số tín chỉ (PHẢI có, AI trả lời câu hỏi TC)
})
```

> ⚠️ **QUAN TRỌNG:** Property phải là `id`, KHÔNG phải `code`. Backend đọc `c.id`.

### Relationship `PREREQUISITE_FOR` — Chiều đi rất quan trọng:

```
(Môn tiên quyết)-[:PREREQUISITE_FOR]->(Môn cần học sau)

Ví dụ:
(CMP1074: Cơ sở lập trình)-[:PREREQUISITE_FOR]->(CMP164: Kỹ thuật lập trình)

Nghĩa là: "Cơ sở lập trình là tiên quyết cho Kỹ thuật lập trình"
          → Muốn học Kỹ thuật LT, phải học CS lập trình trước
```

---

## 3. Schema mở rộng — Tăng độ phong phú

Ngoài schema bắt buộc, ta thêm property và relationship phụ để AI hiểu tốt hơn:

### Property phụ cho Course:

```
(:Course {
    id: 'CMP164',
    name: 'Kỹ thuật lập trình',
    credits: 3,
    category: 'Kiến thức chuyên nghiệp bắt buộc',  ← Nhóm kiến thức
    type: 'LT'                                       ← LT/TH (Lý thuyết/Thực hành)
})
```

### Node `Major` — Thông tin ngành:

```
(:Major {
    id: '7480201',
    name: 'Công nghệ thông tin',
    university: 'HUTECH',
    total_credits: 150
})
```

### Relationship phụ:

```
(Course)-[:BELONGS_TO]->(Major)          ← Môn thuộc ngành nào
(Course)-[:COREQUISITE_WITH]->(Course)   ← Môn song hành (học cùng lúc)
```

---

## 4. Sơ đồ tổng quan Schema

```
                    ┌──────────────────────────┐
                    │         :Major            │
                    │   id: '7480201'           │
                    │   name: 'CNTT'            │
                    │   university: 'HUTECH'    │
                    │   total_credits: 150      │
                    └──────────┬───────────────┘
                               │
                          BELONGS_TO
                               │
         ┌─────────────────────┼──────────────────────┐
         │                     │                      │
   ┌─────▼──────┐       ┌─────▼──────┐        ┌─────▼──────┐
   │  :Course   │       │  :Course   │        │  :Course   │
   │ id: CMP1074│──────▶│ id: CMP164 │───────▶│ id: COS120 │
   │ CSLT       │PREREQ │ KTLT       │PREREQ  │ CTDL&GT    │
   │ 3 TC       │ _FOR  │ 3 TC       │ _FOR   │ 3 TC       │
   └────────────┘       └─────┬──────┘        └────────────┘
                              │
                        COREQUISITE
                           _WITH
                              │
                        ┌─────▼──────┐
                        │  :Course   │
                        │ id: CMP365 │
                        │ TH KTLT    │
                        │ 1 TC       │
                        └────────────┘
```

---

## 5. Quy tắc vàng khi thêm dữ liệu

1. **Mỗi môn = 1 Node** với label `:Course` và PHẢI có `id`, `name`, `credits`
2. **Mối quan hệ tiên quyết:** Dùng `PREREQUISITE_FOR`, chiều từ môn trước → môn sau
3. **Mối quan hệ song hành:** Dùng `COREQUISITE_WITH`
4. **Dùng MERGE, không dùng CREATE** — MERGE tránh tạo trùng lặp
5. **Property `id` phải unique** — Mỗi môn có mã riêng biệt

> 📖 Đọc tiếp file `03-Viet-Cypher-Query.md` để học cách viết lệnh Cypher.
