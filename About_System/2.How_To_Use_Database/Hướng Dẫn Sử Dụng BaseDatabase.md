# Hướng Dẫn Sử Dụng Base Database (PostgreSQL)

EduGuide sử dụng **PostgreSQL** làm cơ sở dữ liệu quan hệ (Relational Database) để lưu trữ các thông tin quan trọng về hệ thống, người dùng và dữ liệu ứng dụng.

---

## 1. Tổng quan
Trong khi Neo4j quản lý "tri thức" (sơ đồ môn học), PostgreSQL quản lý "con người" và "trạng thái":
- **Người dùng:** Thông tin tài khoản, mật khẩu, quyền hạn.
- **Ghi chú (Items/Notes):** Các ghi chú mà người dùng tạo ra trong quá trình sử dụng.
- **Cấu trúc:** Được quản lý bởi thư viện **SQLModel** (Python) và **Alembic** (Migration).

---

## 2. Công cụ quản trị: Adminer
Hệ thống đã tích hợp sẵn giao diện web **Adminer** để bạn thao tác trực quan.

- **Địa chỉ truy cập:** [http://localhost:8080](http://localhost:8080)
- **Thông tin đăng nhập (Lấy từ file `.env`):**
    - **System:** `PostgreSQL`
    - **Server:** `db` (Bắt buộc điền là `db` do kết nối nội bộ Docker)
    - **Username:** `postgres` (Mặc định hoặc xem `POSTGRES_USER` trong `.env`)
    - **Password:** `changethis` (Mặc định hoặc xem `POSTGRES_PASSWORD` trong `.env`)
    - **Database:** `app` (Mặc định hoặc xem `POSTGRES_DB` trong `.env`)

---

## 3. Các bảng dữ liệu chính (Tables)

### 👤 Bảng `user`
Lưu trữ toàn bộ tài khoản người dùng.
- `id`: Định danh duy nhất (UUID).
- `email`: Địa chỉ email đăng nhập.
- `full_name`: Tên đầy đủ.
- `hashed_password`: Mật khẩu đã được băm (Bcrypt/Argon2). Tuyệt đối không lưu mật khẩu thô.
- `is_active`: Trạng thái tài khoản.
- `is_superuser`: Quyền quản trị tối cao (Admin).

### 📝 Bảng `item`
Lưu trữ các ghi chú/dữ liệu nhỏ của người dùng.
- `title`: Tiêu đề ghi chú.
- `description`: Nội dung chi tiết.
- `owner_id`: Khóa ngoại liên kết tới bảng `user`.

---

## 4. Các thao tác thường gặp

### Kiểm tra người dùng
Bạn có thể vào bảng `user` để xem ai đang là Admin hoặc đổi tên hiển thị của người dùng mà không cần code.

### Xử lý lỗi Login
Nếu người dùng quên mật khẩu, hãy dùng tính năng **Password Recovery** trên web (đã được cấu hình gửi mật khẩu mới qua Email). Tránh sửa trực tiếp `hashed_password` trong Adminer vì bạn sẽ không có chuỗi băm đúng.

---

## 5. Lưu ý quan trọng (Quy tắc vận hành)

1. **Volume Data**: Dữ liệu Postgres được lưu tại volume `app-db-data`. Bạn có thể tắt Docker (`down`) thoải mái mà không sợ mất dữ liệu.
2. **Migrations**: Nếu bạn thay đổi code Model trong Python, bạn phải chạy Alembic migration để cập nhật cấu trúc database.
3. **Sao lưu**: Trước khi thực hiện các lệnh `UPDATE` hoặc `DELETE` lớn trong Adminer, hãy đảm bảo bạn đã hiểu rõ câu lệnh để tránh mất dữ liệu quan trọng.

---

_Tài liệu được biên soạn để hỗ trợ đội ngũ phát triển và vận hành EduGuide VN._

cre:MenBoyBMN
