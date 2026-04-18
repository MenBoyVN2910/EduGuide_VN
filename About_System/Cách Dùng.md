# 📚 HƯỚNG DẪN CÀI ĐẶT, KHỞI CHẠY VÀ SỬ DỤNG HỆ THỐNG EDUGUIDE VN

> Tài liệu này bao gồm đầy đủ:
>
> - **Phần 1** — Cài đặt & Khởi chạy hệ thống (2 phương thức)
> - **Phần 2** — Hướng dẫn sử dụng từng tính năng

---

## ⚙️ YÊU CẦU HỆ THỐNG CHUNG

| Phần mềm           | Phiên bản | Mục đích                                  |
| ------------------ | --------- | ----------------------------------------- |
| **Docker Desktop** | Mới nhất  | Chạy toàn bộ hệ thống (Phương thức A)     |
| **Python**         | ≥ 3.10    | Chạy backend (Phương thức B)              |
| **uv**             | Mới nhất  | Quản lý môi trường Python (Phương thức B) |
| **Bun**            | Mới nhất  | Chạy frontend (cả 2 phương thức)          |
| **Neo4j Desktop**  | Mới nhất  | Cơ sở dữ liệu đồ thị (Phương thức B)      |

---

## 🔑 THÔNG TIN CẤU HÌNH MẶC ĐỊNH

```
📧 Tài khoản Admin:    admin@example.com
🔑 Mật khẩu Admin:    changethis
🌐 Giao diện Web:      http://localhost:5173
🚀 Backend API:        http://localhost:8000
📖 API Docs:           http://localhost:8000/docs
🗄️  Neo4j Browser:     http://localhost:7474
🔐 Neo4j Password:     QAZplm6002
```

> ⚠️ **Bảo mật:** Trước khi giao cho khách hàng, hãy đổi `FIRST_SUPERUSER_PASSWORD` và `SECRET_KEY` trong file `.env`.

---

# PHẦN 1 — CÀI ĐẶT & KHỞI CHẠY HỆ THỐNG

## 🔄 CHỌN PHƯƠNG THỨC PHÙ HỢP

```
Máy khách / Demo / Triển khai  ──►  Phương thức A (Docker)
Lập trình viên / Phát triển    ──►  Phương thức B (Local Dev)
```

---

## 📦 PHƯƠNG THỨC A — DOCKER (KHUYÊN DÙNG CHO MÁY KHÁCH)

Đây là cách đơn giản và ổn định nhất — chỉ cần 2 phần mềm, không cần cài Python hay Neo4j riêng.

### Bước 1: Cài Docker Desktop

- Tải tại: <https://www.docker.com/products/docker-desktop/>
- Sau khi cài, **mở Docker Desktop lên** và chờ icon ở taskbar chuyển **xanh lá (Running)**.

### Bước 2: Cài Bun

Mở **PowerShell với quyền Administrator**, chạy:

```powershell
powershell -c "irm bun.sh/install.ps1 | iex"
```

### Bước 3: Copy dự án sang máy

Copy toàn bộ thư mục `ChatBoxAI_Educational` vào máy. Đảm bảo file `.env` đã có trong thư mục gốc.

### Bước 4: Tạo Docker Network (Chỉ cần 1 lần)

```powershell
docker network create traefik-public
```

### Bước 5: Khởi động hệ thống

Mở Terminal **tại thư mục gốc** dự án (nơi có file `compose.yml`):

```powershell
docker compose up -d --build db neo4j backend  ####
```

docker compose restart backend

> ⏳ Lần đầu ở máy mới có thể mất **5–15 phút** để Docker tải image. Lần sau chỉ ~30 giây.

Kiểm tra trạng thái:

```powershell
docker compose ps
```

Khi tất cả status là `healthy` hoặc `running` là thành công.

### Bước 6: Nạp dữ liệu vào Neo4j _(Chỉ làm 1 lần)_

1. Mở trình duyệt → **<http://localhost:7474>**
2. Đăng nhập: Username `neo4j` / Password `QAZplm6002`
3. Mở file `CypherQuery/CNTT.txt` trong thư mục dự án
4. **Copy toàn bộ nội dung** → Dán vào ô lệnh trên Neo4j Browser
5. Nhấn **▶ Run** (hoặc `Ctrl+Enter`)
6. Thành công khi thấy thông báo xanh lá

### Bước 7: Chạy giao diện Web (Frontend)

Mở một tab Terminal mới:

```powershell
cd frontend
bun install
bun run dev  ####
```

Truy cập web tại: **<http://localhost:5173>**

---

## 🛠️ PHƯƠNG THỨC B — LOCAL DEVELOPMENT (DÀNH CHO LẬP TRÌNH VIÊN)

### Cài đặt công cụ

1. **Python ≥ 3.10**: <https://www.python.org/downloads/> (✅ chọn _"Add Python to PATH"_)

2. **uv** (quản lý môi trường Python):

   ```powershell
   powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
   ```

3. **Bun**:

   ```powershell
   powershell -c "irm bun.sh/install.ps1 | iex"
   ```

4. **Neo4j Desktop**: <https://neo4j.com/download/>

### Bước 1: Cấu hình Neo4j Desktop

1. Mở Neo4j Desktop → Tạo database mới
2. Đặt mật khẩu: `QAZplm6002`
3. Nhấn **Start** để khởi động
4. Database chạy tại: `bolt://localhost:7687`

### Bước 2: Kiểm tra file `.env`

Mở file `.env` ở thư mục gốc, đảm bảo `NEO4J_URI` trỏ về localhost:

```env
# Đúng cho local dev:
NEO4J_URI=bolt://localhost:7687

# (Chỉ dùng khi chạy Docker — không dùng cho local):
# NEO4J_URI=bolt://neo4j:7687
```

### Bước 3: Nạp dữ liệu vào Neo4j _(Chỉ làm 1 lần)_

1. Mở **Neo4j Browser**: <http://localhost:7474>
2. Đăng nhập: `neo4j` / `QAZplm6002`
3. Copy nội dung file `CypherQuery/CNTT.txt` → Dán và nhấn Run

### Bước 4: Chạy Backend

Mở **Terminal 1** — tại thư mục `backend`:

```powershell
cd backend
uv run fastapi dev app/main.py
```

> Backend chạy tại <http://localhost:8000> (tự động reload khi sửa code)

### Bước 5: Chạy Frontend

Mở **Terminal 2** — tại thư mục gốc dự án:

```powershell
bun run dev
```

> Frontend chạy tại <http://localhost:5173>

---

## 🛑 CÁCH TẮT HỆ THỐNG

### Tắt Phương thức A (Docker):

```powershell
# Tắt tạm (không mất dữ liệu):
docker compose down

# Lần sau bật lại (không cần build lại):
docker compose up -d
```

### Tắt Phương thức B (Local Dev):

Nhấn **`Ctrl + C`** ở từng terminal đang chạy Backend và Frontend.

---

## 🩺 XỬ LÝ SỰ CỐ THƯỜNG GẶP

| Lỗi                              | Nguyên nhân                     | Cách khắc phục                                   |
| -------------------------------- | ------------------------------- | ------------------------------------------------ |
| Chatbox không trả lời            | Backend chưa chạy               | Kiểm tra terminal Backend, đảm bảo đang chạy     |
| "Cannot connect to Neo4j"        | Neo4j chưa mở hoặc sai URI      | Kiểm tra Neo4j đang chạy và `.env` đúng URI      |
| Trang web trắng / lỗi API        | Frontend không gọi được Backend | Đảm bảo Backend đang chạy ở port 8000            |
| Docker build thất bại            | Thiếu network `traefik-public`  | Chạy: `docker network create traefik-public`     |
| Không đăng nhập được             | Database chưa khởi tạo          | Chạy lại: `docker compose up -d --build backend` |
| Chatbox báo "không đủ thông tin" | Neo4j chưa có dữ liệu           | Thực hiện lại Bước nạp dữ liệu Neo4j             |

---

# PHẦN 2 — HƯỚNG DẪN SỬ DỤNG HỆ THỐNG

Sau khi hệ thống đã chạy, truy cập: **<http://localhost:5173>**

---

## 👤 ĐĂNG KÝ VÀ ĐĂNG NHẬP

### Đăng nhập với tài khoản có sẵn

1. Truy cập **<http://localhost:5173/login>**
2. Nhập Email và Mật khẩu
3. Nhấn **Đăng nhập**

### Đăng ký tài khoản mới

1. Tại trang đăng nhập, nhấn **"Chưa có tài khoản? Đăng ký"**
2. Điền đầy đủ: Họ tên, Email, Mật khẩu
3. Nhấn **Đăng ký** để tạo tài khoản
4. Đăng nhập lại bằng tài khoản vừa tạo

### Quên mật khẩu

1. Nhấn **"Quên mật khẩu?"** ở trang đăng nhập
2. Nhập email → Nhấn **Gửi**
3. Kiểm tra email và làm theo hướng dẫn

---

## 💬 SỬ DỤNG CHATBOX AI

Chatbox là tính năng chính — cho phép hỏi đáp về chương trình đào tạo ngành CNTT Hutech.

### Cách bắt đầu cuộc trò chuyện

1. Đăng nhập vào hệ thống
2. Nhấn **"+ Cuộc trò chuyện mới"** ở thanh sidebar bên trái
3. Gõ câu hỏi vào ô chat phía dưới trang
4. Nhấn **Enter** hoặc nhấn biểu tượng **Gửi** ▶

### Chatbox có thể trả lời gì?

Hệ thống AI được thiết kế trả lời các câu hỏi về **chương trình đào tạo ngành CNTT Hutech**:

| Loại câu hỏi         | Ví dụ                                                           |
| -------------------- | --------------------------------------------------------------- |
| **Tín chỉ môn học**  | _"Môn Lập trình cơ bản có bao nhiêu tín chỉ?"_                  |
| **Môn tiên quyết**   | _"Để học Cơ sở dữ liệu cần học môn gì trước?"_                  |
| **Lộ trình học**     | _"Học kỳ 1 năm nhất gồm những môn gì?"_                         |
| **Thông tin khoa**   | _"Ngành CNTT có bao nhiêu tín chỉ tổng cộng?"_                  |
| **Kế hoạch học tập** | _"Tôi muốn học Trí tuệ nhân tạo thì cần học các môn gì trước?"_ |

> ⚠️ **Lưu ý:** Chatbox chỉ trả lời trong phạm vi chương trình đào tạo. Câu hỏi ngoài phạm vi sẽ được từ chối với thông báo _"Câu hỏi của bạn không đúng môn học"_.

### Sử dụng giọng nói (Voice Input)

1. Nhấn biểu tượng **Microphone 🎤** trong ô nhập liệu
2. Nói câu hỏi của bạn
3. Văn bản được chuyển đổi tự động vào ô → Kiểm tra rồi nhấn **Gửi**

### Xem lại lịch sử trò chuyện

- Tất cả cuộc trò chuyện được lưu ở **thanh sidebar bên trái**
- Nhấn vào bất kỳ cuộc trò chuyện nào để xem lại nội dung

---

## 📝 TÍNH NĂNG GHI CHÚ

Cho phép tạo, chỉnh sửa và quản lý ghi chú cá nhân.

### Truy cập

Nhấn **"Ghi Chú"** ở menu sidebar bên trái.

### Tạo ghi chú mới

1. Nhấn nút **"+ Thêm Ghi Chú"**
2. Nhập tiêu đề và nội dung
3. Nhấn **Lưu**

### Chỉnh sửa ghi chú

1. Nhấn vào ghi chú muốn sửa
2. Chỉnh sửa tiêu đề hoặc nội dung
3. Nhấn **Lưu thay đổi**

### Xóa ghi chú

1. Nhấn biểu tượng **Xóa 🗑️** trên ghi chú
2. Xác nhận xóa trong hộp thoại hiện ra

---

## ⚙️ CÀI ĐẶT TÀI KHOẢN

Nhấn vào **Avatar / tên người dùng** ở góc dưới cùng sidebar → Chọn **Settings**.

### Tab "Hồ sơ của tôi"

- Xem và chỉnh sửa **Họ và tên**, **Địa chỉ Email**
- Nhấn **Chỉnh sửa** → sửa thông tin → nhấn **Lưu thay đổi**

### Tab "Mật khẩu"

- Đổi mật khẩu bằng cách nhập:
  - Mật khẩu hiện tại
  - Mật khẩu mới (ít nhất 8 ký tự)
  - Xác nhận mật khẩu mới
- Nhấn **Cập nhật mật khẩu**

### Tab "Vùng nguy hiểm"

- **Xóa tài khoản vĩnh viễn** — Hành động không thể hoàn tác
- Nhấn **Xác nhận xóa tài khoản** → Xác nhận trong hộp thoại

---

## 🌙 CHẾ ĐỘ SÁNG / TỐI

Nhấn biểu tượng **🌙 / ☀️** ở cuối sidebar để chuyển đổi giữa Dark Mode và Light Mode.

---

## 👑 DÀNH CHO ADMIN (QUẢN TRỊ VIÊN)

Tài khoản Admin (`admin@example.com`) có thêm menu **"Admin"** trong sidebar.

### Quản lý người dùng

1. Vào menu **Admin**
2. Xem danh sách toàn bộ tài khoản
3. Có thể **tạo mới**, **chỉnh sửa**, hoặc **vô hiệu hóa** tài khoản

---

## 📁 CẤU TRÚC DỰ ÁN (DÀNH CHO LẬP TRÌNH VIÊN)

```
ChatBoxAI_Educational/
├── .env                     ← Cấu hình môi trường (API keys, DB passwords...)
├── compose.yml              ← Cấu hình Docker Compose
├── frontend/                ← Giao diện Web (React + Vite + TailwindCSS)
│   └── src/
│       ├── components/      ← Các thành phần UI (Chat, Sidebar, Settings...)
│       └── routes/          ← Các trang (Home, Settings, Admin...)
├── backend/                 ← API Server (FastAPI + Python)
│   └── app/
│       ├── api/routes/      ← Các endpoint API (chatbot, users, login...)
│       ├── services/        ← Logic AI (chat_agent.py — kết nối Gemini + Neo4j)
│       └── core/            ← Kết nối Database (PostgreSQL, Neo4j)
├── CypherQuery/
│   └── CNTT.txt             ← Dữ liệu đồ thị tri thức Hutech (import vào Neo4j)
└── Training_Program/
    └── *.pdf                ← Chương trình đào tạo gốc (tài liệu tham khảo)
```
