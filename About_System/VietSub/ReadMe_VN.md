## Tóm Tắt Sơ Bộ

File README này mô tả tổng quan về một template dự án web full-stack hiện đại, sử dụng FastAPI ở backend và React ở frontend, đã được tích hợp sẵn Docker, CI/CD, bảo mật JWT và nhiều công cụ tiện ích khác — sẵn sàng để clone về và triển khai.

=========================================================================================================

## Cách sử dụng

Bạn có thể **chỉ cần fork hoặc clone** kho lưu trữ này và sử dụng ngay.

✨ Nó hoạt động ngay lập tức. ✨

### Cách sử dụng kho lưu trữ riêng tư

Nếu bạn muốn có một kho lưu trữ riêng tư, GitHub sẽ không cho phép bạn chỉ cần fork nó vì nền tảng này không cho phép thay đổi quyền truy cập của các bản fork.

Nhưng bạn có thể làm như sau:

- Tạo một kho lưu trữ GitHub mới, ví dụ `my-full-stack`.
- Clone kho lưu trữ này thủ công, đặt tên theo tên dự án bạn muốn sử dụng, ví dụ `my-full-stack`:

```bash
git clone git@github.com:fastapi/full-stack-fastapi-template.git my-full-stack
```

- Chuyển vào thư mục mới:

```bash
cd my-full-stack
```

- Đặt origin mới là kho lưu trữ mới của bạn, sao chép từ giao diện GitHub, ví dụ:

```bash
git remote set-url origin git@github.com:octocat/my-full-stack.git
```

- Thêm kho lưu trữ này làm "remote" khác để có thể nhận cập nhật sau này:

```bash
git remote add upstream git@github.com:fastapi/full-stack-fastapi-template.git
```

- Đẩy mã nguồn lên kho lưu trữ mới của bạn:

```bash
git push -u origin master
```

### Cập nhật từ mẫu gốc (Dùng Để cập nhật các thay đổi mới nhất từ mẫu gốc này)

Sau khi sao chép kho lưu trữ và thực hiện các thay đổi, bạn có thể muốn lấy các thay đổi mới nhất từ mẫu gốc này.

- Đảm bảo bạn đã thêm kho lưu trữ gốc làm remote, bạn có thể kiểm tra bằng lệnh:

```bash
git remote -v

origin    git@github.com:octocat/my-full-stack.git (fetch)
origin    git@github.com:octocat/my-full-stack.git (push)
upstream    git@github.com:fastapi/full-stack-fastapi-template.git (fetch)
upstream    git@github.com:fastapi/full-stack-fastapi-template.git (push)
```

- Kéo các thay đổi mới nhất mà không hợp nhất:

```bash
git pull --no-commit upstream master
```

Thao tác này sẽ tải xuống các thay đổi mới nhất từ mẫu này mà không cam kết chúng, nhờ đó bạn có thể kiểm tra xem mọi thứ đã đúng chưa trước khi cam kết.

- Nếu có xung đột, hãy giải quyết chúng trong trình soạn thảo của bạn.

- Khi hoàn tất, hãy cam kết các thay đổi:

```bash
git merge --continue
```

=========================================================================================================

### Cấu hình (Đây là bước quan trọng để bảo mật dự án)

Sau đó, bạn có thể cập nhật các cấu hình trong các tệp `.env` để tùy chỉnh cấu hình của mình.

Trước khi triển khai, hãy đảm bảo bạn đã thay đổi ít nhất các giá trị sau:

- `SECRET_KEY`
- `FIRST_SUPERUSER_PASSWORD`
- `POSTGRES_PASSWORD`

Bạn có thể (và nên) truyền các giá trị này dưới dạng biến môi trường từ kho lưu trữ bí mật.

Đọc tài liệu [deployment.md](./deployment.md) để biết thêm chi tiết.

### Tạo khóa bí mật

Một số biến môi trường trong tệp `.env` có giá trị mặc định là `changethis`.

Bạn phải thay đổi chúng bằng một khóa bí mật. Để tạo khóa bí mật, bạn có thể chạy lệnh sau:

```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

Sao chép nội dung và sử dụng nó làm mật khẩu / khóa bí mật. Chạy lại lệnh này để tạo một khóa bảo mật khác.

=========================================================================================================

## Cách sử dụng - Phương án thay thế với Copier (Đây là phương án thay thế cho việc fork hoặc clone)

Kho lưu trữ này cũng hỗ trợ tạo dự án mới bằng [Copier](https://copier.readthedocs.io).

Nó sẽ sao chép tất cả các tệp, hỏi bạn các câu hỏi cấu hình và cập nhật các tệp `.env` dựa trên câu trả lời của bạn.

### Cài đặt Copier

Bạn có thể cài đặt Copier bằng lệnh:

```bash
pip install copier
```

Hoặc tốt hơn, nếu bạn có [`pipx`](https://pipx.pypa.io/), bạn có thể chạy lệnh sau:

```bash
pipx install copier
```

**Lưu ý**: Nếu bạn có `pipx`, việc cài đặt Copier là tùy chọn, bạn có thể chạy nó trực tiếp.

### Tạo dự án với Copier

Chọn tên cho thư mục dự án mới của bạn, bạn sẽ sử dụng tên này ở phần dưới. Ví dụ: `my-awesome-project`.

Chuyển đến thư mục sẽ là thư mục cha của dự án và chạy lệnh với tên dự án của bạn:

```bash
copier copy https://github.com/MenBoyVN2910/ChatBoxAI_Educational.git chatbox_ai_educational_project --trust
```

Nếu bạn có `pipx` và chưa cài đặt `copier`, bạn có thể chạy trực tiếp:

```bash
pipx run copier copy https://github.com/fastapi/full-stack-fastapi-template my-awesome-project --trust
```

**Lưu ý** tùy chọn `--trust` là cần thiết để có thể thực thi [kịch bản sau khi tạo](https://github.com/fastapi/full-stack-fastapi-template/blob/master/.copier/update_dotenv.py) nhằm cập nhật các tệp `.env` của bạn.

### Biến đầu vào

Copier sẽ yêu cầu bạn cung cấp một số dữ liệu, bạn nên chuẩn bị sẵn trước khi tạo dự án.

Nhưng đừng lo, bạn có thể cập nhật bất kỳ thông tin nào trong các tệp `.env` sau đó.

Các biến đầu vào, cùng với giá trị mặc định (một số được tạo tự động) là:

- `project_name`: (mặc định: `"FastAPI Project"`) Tên dự án, hiển thị cho người dùng API (trong .env).
- `stack_name`: (mặc định: `"fastapi-project"`) Tên stack được sử dụng cho nhãn Docker Compose và tên dự án (không có khoảng trắng, không có dấu chấm) (trong .env).
- `secret_key`: (mặc định: `"changethis"`) Khóa bí mật của dự án, dùng cho mục đích bảo mật, được lưu trữ trong .env, bạn có thể tạo khóa này bằng phương pháp ở trên.
- `first_superuser`: (mặc định: `"admin@example.com"`) Địa chỉ email của người dùng siêu cấp đầu tiên (trong tệp .env).
- `first_superuser_password`: (mặc định: `"changethis"`) Mật khẩu của người dùng siêu cấp đầu tiên (trong tệp .env).
- `smtp_host`: (mặc định: "") Máy chủ SMTP để gửi email, bạn có thể thiết lập sau trong tệp .env.
- `smtp_user`: (mặc định: "") Tài khoản người dùng SMTP để gửi email, bạn có thể thiết lập sau trong tệp .env.
- `smtp_password`: (mặc định: "") Mật khẩu máy chủ SMTP để gửi email, bạn có thể thiết lập sau trong tệp .env.
- `emails_from_email`: (mặc định: `"info@example.com"`) Tài khoản email để gửi email, bạn có thể thiết lập sau trong tệp .env.
- `postgres_password`: (mặc định: `"changethis"`) Mật khẩu cho cơ sở dữ liệu PostgreSQL, được lưu trữ trong tệp .env, bạn có thể tạo mật khẩu bằng phương pháp ở trên.
- `sentry_dsn`: (mặc định: "") DSN cho Sentry, nếu bạn đang sử dụng, bạn có thể thiết lập sau trong tệp .env.

## Phát triển Backend

Tài liệu Backend: [backend/README.md](./backend/README.md).

## Phát triển Frontend

Tài liệu Frontend: [frontend/README.md](./frontend/README.md).

## Triển khai

Tài liệu triển khai: [deployment.md](./deployment.md).

## Phát triển

Tài liệu phát triển chung: [development.md](./development.md).

Điều này bao gồm việc sử dụng Docker Compose, tên miền cục bộ tùy chỉnh, cấu hình `.env`, v.v.

## Ghi chú phát hành

Kiểm tra tệp [release-notes.md](./release-notes.md).

## Giấy phép

Mẫu Full Stack FastAPI được cấp phép theo các điều khoản của giấy phép MIT.
