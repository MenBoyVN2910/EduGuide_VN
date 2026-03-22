# HƯỚNG DẪN CÀI ĐẶT VÀ KHỞI CHẠY DỰ ÁN TỪ A-Z (DÀNH CHO MÁY MỚI)

Để mang dự án sang một máy tính khác, chỉ cần cài đặt 3 công cụ gốc và thực hiện lệnh khởi chạy rất đơn giản. Dưới đây là quy trình chi tiết:

---

## PHẦN 1: CÁC ỨNG DỤNG HỖ TRỢ BẮT BUỘC PHẢI CÀI

Cần tải và cài đặt 3 phần mềm sau theo đúng thứ tự:

1. **Docker Desktop** (Bắt buộc)
   - Tải tại: [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)
   - **Tác dụng:** Dùng để chạy ảo hóa Hệ thống Backend (FastAPI), Cơ sở dữ liệu (PostgreSQL) và Hệ tri thức Đồ thị (Neo4j) mà không cần phải cài lẻ tẻ từng hệ quản trị cơ sở dữ liệu rườm rà. Cài xong nhớ mở (Start) phần mềm Docker lên.

2. **Python**
   - Tải tại: [https://www.python.org/downloads/](https://www.python.org/downloads/)
   - **Tác dụng:** Dùng để chạy cái file Script Python (`seed_neo4j.py`) nạp tự động nhanh 1000 môn học vào hệ tri thức Neo4j. Khi cài Python, anh **NHỚ check** vào ô vuông "Add Python to PATH".

3. **Bun** (Node.js runtime thế hệ mới)
   - Tải qua PowerShell (Mở PowerShell với quyền Administrator):
     ```bash
     powershell -c "irm bun.sh/install.ps1 | iex"
     ```
   - **Tác dụng:** Dùng để tải thư viện Front-end cực nhanh và khởi chạy giao diện Web Chatbot (tương tự như `npm` ở Nodejs nhưng tải siêu tốc).

4. **Visual Studio Code (VS Code)**
   - Tải tại: [https://code.visualstudio.com/download](https://code.visualstudio.com/download)
   - **Tác dụng:** Dùng để chỉnh sửa code và chạy các lệnh Terminal.
   - **Cài thêm Extension:**
     - **Docker** (Để chạy lệnh Docker)
     - **Python** (Để chạy lệnh Python)
     - **Bun** (Để chạy lệnh Bun)
     - **Neo4j** (Để chạy lệnh Neo4j)
     - **PostgreSQL** (Để chạy lệnh PostgreSQL)

   - **Biện Pháp Thay Thế VS Code** (Khuyên dùng)- Antigravity (https://antigravity.com/) -Có tích hợp sẵn AI(gemini,claude,gpt,...) và các công cụ hỗ trợ lập trình.

---

## PHẦN 2: CÁCH KHỞI ĐỘNG HỆ THỐNG VÀ NẠP DỮ LIỆU

Copy toàn bộ thư mục dự án `ChatBoxAI_Educational` sang máy khác. Mở VS Code (hoặc Terminal) lên:

**Bước 1: Bật Backend, Database và Neo4j**

- Mở Terminal **tại thư mục gốc của dự án** (chỗ chứa file `compose.yml`).
- Chạy lệnh sau để tải, build và chạy toàn bộ ruột của hệ thống:

```bash
  docker compose up -d --build backend db neo4j proxy
```

- Đợi đến khi máy báo chữ `Started` màu xanh là xong (Lần đầu ở máy mới có thể tốn 5-10 phút để Docker tải Ubuntu và các thư viện cần thiết).

**Bước 2: Nạp dữ liệu vào Hệ Tri thức Neo4j**

- Do máy khác, Neo4j chưa có Data. Khởi tạo nó bằng Script code sẵn:
- Chuyển Terminal vào `backend`:

```bash
  cd backend
```

- Cài 2 cấu hình nhẹ cho Python rồi chạy Script nạp dữ liệu:

```bash
  pip install neo4j python-dotenv
  python scripts/seed_neo4j.py
```

_(Nó sẽ báo "Successfully seeded Neo4j databases... " là OKE)._

**Bước 3: Bật giao diện Web (Frontend)**

- Mở một tab Terminal mới, truy cập vào thư mục `frontend`:

```bash
  cd frontend
```

- Bắt đầu cài thư viện Frontend (lần đầu tiên máy mới) và bật Server:

```bash
  bun install
  bun run dev
```

- Bấm vào link **`http://localhost:5175/`** ở Terminal để vào chat với AI. Lúc này AI đã gom đủ phép thuật, sẵn sàng phân loại "Không đúng môn học" hoặc trả lời chi tiết về Môn tiên quyết!

---

## PHẦN 3: CÁCH TẮT HỆ THỐNG KHI CODE XONG

Để giải phóng RAM cho máy mượt mà nộp bài, ta tắt gọn gàng bằng 2 đường cơ bản:

1. **Tắt Giao diện Chat:** Mở cái Terminal đang lặp lệnh `bun run dev`, anh bấm phím **`Ctrl + C`**, nhấn `Y` rồi gõ Enter để dừng.

2. **Tắt Hệ thống Backend ngầm:**
   Mở Terminal ở thư mục gốc (chỗ có `compose.yml`), chạy:

```bash
   docker compose down
```

_(Lệnh này dọn sạch container tạm nhưng không làm mất dữ liệu PostgreSQL hay Neo4j, lần sau mở lên gõ `docker compose up -d` lại là chạy vù vù y như cũ)._

---

## PHẦN 4 (NÂNG CAO): CHỈNH SỬA DỮ LIỆU ĐỒ THỊ TRỰC QUAN BẰNG TAY (NEO4J)

Ngoài việc chạy code Python như Bước 2 để nạp Data, ta cũng có thể trực tiếp vẽ đồ thị Neo4j bằng Web của nó luôn:

- **Link truy cập:** 👉 `http://localhost:7474`
- **Tài khoản:** `neo4j`
- **Mật khẩu:** `QAZplm6002` (do ta cài trong `.env`)

Tại đây, gõ vào thanh ngang phía trên cùng các lệnh Create để nắn Node và Edge (VD: Thêm node Môn Học Mới, thêm Mối quan hệ "Bắt buộc học trước"...). Gõ xong Enter chạy là tự nó tự động Lưu trữ vào ổ cứng Server mãi mãi!
