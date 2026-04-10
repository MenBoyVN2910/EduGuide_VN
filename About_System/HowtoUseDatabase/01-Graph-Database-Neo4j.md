# 🧠 Graph Database là gì? Tại sao dùng Neo4j?

## 1. Graph Database (Cơ sở dữ liệu đồ thị) là gì?

Graph Database là loại cơ sở dữ liệu lưu trữ dữ liệu dưới dạng **Node (nút)** và **Relationship (mối quan hệ)**, thay vì dạng bảng như SQL truyền thống.

### So sánh với SQL truyền thống:

```
SQL (Bảng):                          Graph (Đồ thị):
┌──────┬────────────────┐            
│ ID   │ Tên môn        │             (CMP1074)──PREREQUISITE_FOR──▶(CMP164)
├──────┼────────────────┤                 │
│ CMP1074│ Cơ sở lập trình│            "Cơ sở lập trình"        "Kỹ thuật lập trình"
│ CMP164 │ Kỹ thuật LT    │
└──────┴────────────────┘
+ Bảng phụ prerequisites...
```

**Ưu điểm của Graph:**
- Mối quan hệ giữa các môn học được lưu **trực tiếp** (không cần JOIN)
- Truy vấn "Muốn học môn X thì cần học những môn gì trước?" rất nhanh
- AI dễ hiểu cấu trúc hơn khi xử lý ngữ cảnh

---

## 2. Neo4j là gì?

**Neo4j** là hệ quản trị Graph Database phổ biến nhất thế giới. Nó dùng ngôn ngữ truy vấn riêng gọi là **Cypher**.

### Các khái niệm cốt lõi:

| Khái niệm | Ý nghĩa | Ví dụ |
|---|---|---|
| **Node** | Một thực thể (đối tượng) | Một môn học, một ngành |
| **Label** | Nhãn phân loại cho Node | `:Course`, `:Major` |
| **Property** | Thuộc tính của Node | `name: 'Cơ sở lập trình'` |
| **Relationship** | Mối quan hệ giữa 2 Node | `PREREQUISITE_FOR` |

### Ví dụ trực quan:

```
                    ┌─────────────────────────┐
                    │      Major              │
                    │  id: '7480201'          │
                    │  name: 'CNTT'           │
                    │  total_credits: 150     │
                    └────────────┬────────────┘
                                │
                         BELONGS_TO
                                │
          ┌─────────────────────┼─────────────────────┐
          │                     │                     │
    ┌─────▼─────┐        ┌─────▼─────┐        ┌─────▼─────┐
    │  Course   │        │  Course   │        │  Course   │
    │ CMP1074   │───────▶│  CMP164   │───────▶│  COS120   │
    │ CS lập    │ PREREQ │ Kỹ thuật  │ PREREQ │ CTDL &    │
    │ trình     │  _FOR  │ lập trình │  _FOR  │ giải thuật│
    │ 3 TC      │        │ 3 TC      │        │ 3 TC      │
    └───────────┘        └───────────┘        └───────────┘
```

---

## 3. Tại sao EduGuide VN dùng Neo4j?

Chương trình đào tạo CNTT Hutech có:
- **100+ môn học** với các mối quan hệ phức tạp
- Nhiều **môn tiên quyết** (phải học trước)
- Nhiều **môn song hành** (phải học cùng lúc)
- Phân chia thành **nhiều nhóm kiến thức**

Graph Database giúp AI chatbot:
1. **Hiểu cấu trúc lộ trình học** — Truy vấn chuỗi môn tiên quyết dễ dàng
2. **Trả lời chính xác** — Dữ liệu có cấu trúc, AI không cần đoán
3. **Linh hoạt mở rộng** — Thêm ngành mới chỉ cần thêm Node và Relationship

---

## 4. Neo4j Browser là gì?

Neo4j Browser là giao diện web để:
- Xem đồ thị trực quan
- Chạy các lệnh Cypher
- Kiểm tra và quản lý dữ liệu

**Truy cập:** http://localhost:7474

> 📖 Đọc tiếp file `02-Thiet-Ke-Schema.md` để hiểu cách thiết kế cấu trúc dữ liệu.
