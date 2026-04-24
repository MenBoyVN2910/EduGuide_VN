# 📘 HƯỚNG DẪN VẬN HÀNH HỆ THỐNG EDUGUIDE VN

> **Hệ thống Trợ lý Ảo Giáo dục hỗ trợ Tư vấn Tuyển sinh & Chương trình Đào tạo**

Chào mừng bạn đến với **EduGuide VN**. Tài liệu này được thiết kế để giúp bất kỳ ai — từ người dùng cuối đến lập trình viên — có thể tự cài đặt, cấu hình và sử dụng hệ thống một cách trơn tru nhất.

---

## 📑 Mục lục

1. [Yêu cầu hệ thống](#-yêu-cầu-hệ-thống)
2. [Cài đặt & Khởi chạy (2 Phương thức)](#-cài-đặt--khởi-chạy)
   - [Cách 1: Docker (Nhanh & Ổn định)](#-cách-1-triển-khai-nhanh-với-docker)
   - [Cách 2: Local Dev (Cho Lập trình viên)](#-cách-2-chạy-thủ-công-cho-lập-trình-viên)
3. [Khởi tạo Dữ liệu Tri thức (Neo4j)](#-khởi-tạo-dữ-liệu-tri-thức)
4. [Hướng dẫn Sử dụng Tính năng](#-hướng-dẫn-sử-dụng-tính-năng)
5. [Xử lý lỗi thường gặp](#-xử-lý-lỗi-thường-gặp)
6. [Thông tin Kỹ thuật & Cấu trúc](#-thông-tin-kỹ-thuật)
7. [Cấu hình Typography (Giao diện văn bản)](#-cấu-hình-typography-giao-diện-văn-bản)

---

## 💻 Yêu cầu hệ thống

| Thành phần         | Yêu cầu tối thiểu              | Ghi chú                          |
| :----------------- | :----------------------------- | :------------------------------- |
| **Hệ điều hành**   | Windows 10/11, macOS, Linux    | Ưu tiên 64-bit                   |
| **Docker Desktop** | Phiên bản mới nhất             | Cần thiết cho Cách 1             |
| **Python**         | ≥ 3.10                         | Cần thiết cho Cách 2             |
| **Node.js/Bun**    | Bun (khuyên dùng) hoặc Node.js | Chạy giao diện người dùng        |
| **RAM**            | Tối thiểu 8GB                  | Khuyên dùng 16GB để chạy mượt mà |

---

## 🚀 Cài đặt & Khởi chạy

### 🔑 Thông tin mặc định

Sau khi khởi chạy thành công, các địa chỉ truy cập sẽ là:

- **🌐 Giao diện Web:** `http://localhost:5173`
- **🚀 Backend API:** `http://localhost:8000`
- **🗄️ Quản trị Neo4j:** `http://localhost:7474` (User: `neo4j` / Pass: `QAZplm6002`)
- **👤 Tài khoản Admin:** `admin@example.com` / `admin123`

---

### 📦 Cách 1: Triển khai nhanh với Docker (Khuyên dùng)

_Phù hợp cho mục đích Demo, kiểm thử hoặc cài đặt trên máy khách hàng._

1. **Cài đặt công cụ:**
   - Tải và cài [Docker Desktop](https://www.docker.com/products/docker-desktop/).
   - Mở Docker Desktop và chờ icon ở taskbar hiện màu xanh (**Running**).
2. **Khởi tạo Network (Chỉ làm 1 lần duy nhất):**
   Mở Terminal (PowerShell hoặc CMD) và chạy:
   ```bash
   docker network create traefik-public
   ```
3. **Bật hệ thống:**
   Di chuyển vào thư mục gốc của dự án (`ChatBoxAI_Educational`) và chạy:
   ```bash
   docker compose up -d --build
   ```
   > ⏳ **Lưu ý:** Lần đầu tiên sẽ mất khoảng 5-10 phút để tải các gói cần thiết. Các lần sau chỉ mất vài giây.
4. **Kiểm tra:**
   Gõ `docker compose ps` để đảm bảo các service (`db`, `neo4j`, `backend`) đều ở trạng thái `Running` hoặc `Healthy`.
5. **Dừng hệ thống (Khi không sử dụng):**
   Mở Terminal tại thư mục gốc và chạy:
   ```bash
   docker compose down
   ```
6. **Khởi động lại (Các lần tiếp theo):**
   Bạn không cần phải build lại từ đầu. Chỉ cần mở Docker Desktop và chạy lệnh sau tại thư mục gốc:
   ```bash
   docker compose up -d
   ```
   > 💡 **Mẹo:** Lệnh này sẽ bật lại hệ thống cực nhanh (chỉ mất vài giây) vì mọi thứ đã được cài đặt sẵn.
7. **Cập nhật hệ thống (Khi có thay đổi mã nguồn hoặc .env):**
   Nếu bạn thay đổi code ở Backend hoặc cập nhật các thông số trong file `.env`, hãy chạy lệnh sau để Docker cập nhật lại:
   ```bash
   docker compose up -d --build
   ```

---

### 🛠️ Cách 2: Chạy thủ công (Cho Lập trình viên)

_Phù hợp khi bạn cần can thiệp vào mã nguồn và chỉnh sửa tính năng._

1. **Cài đặt môi trường:**
   - **Python:** Cài bản 3.10+ và tích chọn "Add Python to PATH".
   - **UV (Quản lý Python):** `powershell -c "irm https://astral.sh/uv/install.ps1 | iex"`
   - **Bun (Frontend):** `powershell -c "irm bun.sh/install.ps1 | iex"`
   - **Neo4j Desktop:** Cài đặt và tạo Database với mật khẩu `QAZplm6002`.
2. **Cấu hình biến môi trường:**
   Mở file `.env` ở thư mục gốc, đảm bảo dòng sau không bị comment:
   ```env
   NEO4J_URI=bolt://localhost:7687
   ```
3. **Chạy Backend:**
   Mở Terminal tại thư mục `backend/`:
   ```bash
   uv run fastapi dev app/main.py
   ```
4. **Chạy Frontend:**
   Mở Terminal mới tại thư mục `frontend/`:
   ```bash
   bun install
   bun run dev
   ```
   🌐 Giao diện Web:\*\* `http://localhost:5173`

---

## 🧠 Khởi tạo Dữ liệu Tri thức

**Đây là bước cực kỳ quan trọng để Chatbot có thể hiểu về chương trình đào tạo.**

1. Truy cập vào **Neo4j Browser**: [http://localhost:7474](http://localhost:7474).
2. Đăng nhập với mật khẩu: `QAZplm6002`.
3. Tìm đến thư mục `CypherQuery/` trong dự án, mở file `CNTT.txt`.
4. **Copy toàn bộ nội dung** trong file đó và dán vào ô nhập liệu của Neo4j.
5. Nhấn nút **Play (Run)** hoặc `Ctrl + Enter`.
6. Hệ thống sẽ tạo ra các nút (Nodes) và liên kết (Relationships) đại diện cho các môn học.

---

## 📖 Hướng dẫn Sử dụng Tính năng

### 1. Hệ thống Chatbot thông minh

- **Hỏi về môn học:** "Môn Cấu trúc dữ liệu có bao nhiêu tín chỉ?"
- **Hỏi về điều kiện học:** "Muốn học Đồ án ngành thì cần học xong môn nào?"
- **Hỏi về lộ trình:** "Kỳ 1 năm nhất học những gì?"
- **Điều khiển giọng nói:** Nhấn biểu tượng 🎤 để nói thay vì gõ.

### 2. Quản lý Ghi chú (Notes)

- Giúp sinh viên lưu lại các lưu ý quan trọng về môn học hoặc lịch trình.
- Truy cập mục **"Ghi chú"** ở thanh điều hướng bên trái.

### 3. Cài đặt Cá nhân & Bảo mật

- Thay đổi thông tin cá nhân, đổi mật khẩu hoặc chuyển đổi giao diện **Sáng/Tối (Light/Dark Mode)** để bảo vệ mắt.

### 4. Bảng điều khiển Admin (Dành cho Quản trị viên)

- Quản lý danh sách người dùng, cấp quyền hoặc khóa các tài khoản vi phạm.

---

## 🩺 Xử lý lỗi thường gặp

| Hiện tượng                           | Nguyên nhân                       | Giải pháp                                                                   |
| :----------------------------------- | :-------------------------------- | :-------------------------------------------------------------------------- |
| **Bot báo "Không tìm thấy dữ liệu"** | Chưa nạp file Cypher vào Neo4j    | Thực hiện lại bước [Khởi tạo Dữ liệu Tri thức](#-khởi-tạo-dữ-liệu-tri-thức) |
| **Trang web không tải được dữ liệu** | Backend chưa khởi chạy thành công | Kiểm tra Terminal Backend hoặc log Docker                                   |
| **Lỗi kết nối Cơ sở dữ liệu**        | Sai mật khẩu hoặc Port bị chiếm   | Kiểm tra file `.env` và đảm bảo không có app nào khác dùng port 5432/7687   |
| **Docker Build lỗi Network**         | Thiếu network `traefik-public`    | Chạy lệnh `docker network create traefik-public`                            |

---

## 📂 Thông tin Kỹ thuật (Cho Dev)

Dưới đây là sơ đồ cấu trúc giúp bạn nhanh chóng định vị mã nguồn:

```text
ChatBoxAI_Educational/
├── 📁 backend/             # FastAPI Server, Logic AI & Kết nối DB
│   └── 📁 app/services/    # "Trái tim" AI (Xử lý truy vấn GraphRAG)
├── 📁 frontend/            # React + Vite + Tailwind (Giao diện người dùng)
├── 📁 CypherQuery/         # Chứa kịch bản nạp dữ liệu cho Neo4j
├── 📁 Training_Program/    # Tài liệu gốc về chương trình đào tạo
└── 📄 compose.yml          # Cấu hình "đóng gói" toàn bộ hệ thống
```

> [!TIP]
> Để hệ thống hoạt động chính xác nhất, hãy đảm bảo bạn đã cung cấp API Key của Google Gemini trong file `.env`.

---

## 🎨 Cấu hình Typography (Giao diện văn bản)

Phần này hướng dẫn cách thiết lập plugin `@tailwindcss/typography` để nội dung từ Chatbot (Markdown) được hiển thị đẹp mắt và chuyên nghiệp.

### 1. Cài đặt Package
Nếu bạn đang chạy dự án ở chế độ phát triển (Local Dev), hãy mở terminal tại thư mục `frontend` và cài đặt thư viện:
```bash
# Di chuyển vào thư mục frontend nếu chưa ở đó
cd frontend

# Cài đặt plugin typography bằng Bun
bun add @tailwindcss/typography
```
*Chú thích: Lệnh này sẽ thêm plugin vào file `package.json` của bạn để các thành viên khác có thể sử dụng.*

### 2. Khai báo Plugin trong CSS
Trong Tailwind CSS v4, chúng ta khai báo plugin trực tiếp trong file CSS chính.
Mở file `frontend/src/index.css` và kiểm tra xem đã có 2 dòng này chưa:
```css
@import "tailwindcss";
@plugin "@tailwindcss/typography";
```
*Lưu ý: Hệ thống hiện tại đã cấu hình sẵn dòng này, bạn thường chỉ cần thực hiện Bước 1 nếu thư viện chưa được cài đặt.*

### 3. Cách sử dụng trong code
Để nội dung Markdown tự động có định dạng (tiêu đề, danh sách, in đậm...), bạn chỉ cần sử dụng class `prose`:
- **Light Mode**: Sử dụng class `prose`.
- **Dark Mode**: Sử dụng thêm `dark:prose-invert` để chữ tự động chuyển sang màu sáng trên nền tối.

Ví dụ minh họa:
```html
<div class="prose dark:prose-invert max-w-none">
  <!-- Toàn bộ nội dung trả về từ AI sẽ được tự động làm đẹp tại đây -->
  {aiResponseContent}
</div>
```

---


_Tài liệu được cập nhật lần cuối vào tháng 04/2026 bởi Đội ngũ Phát triển EduGuide VN._
