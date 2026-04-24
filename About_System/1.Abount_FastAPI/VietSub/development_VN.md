# Dự án FastAPI - Phát triển

## Tóm Tắt Sơ Bộ

File này hướng dẫn cách chạy và phát triển dự án trên máy local (localhost). Đây là file bạn cần đọc khi muốn code, test, debug hằng ngày.

=========================================================================================================

## Docker Compose

- Khởi động hệ thống cục bộ bằng Docker Compose:

```bash
docker compose watch
```

- Bây giờ bạn có thể mở trình duyệt và truy cập các URL sau:

Giao diện người dùng (Frontend), được xây dựng bằng Docker, với các đường dẫn được xử lý dựa trên đường dẫn: <http://localhost:5173>

Backend, API web dựa trên JSON theo tiêu chuẩn OpenAPI: <http://localhost:8000>

Tài liệu tương tác tự động với Swagger UI (từ backend OpenAPI): <http://localhost:8000/docs>

Adminer, quản trị cơ sở dữ liệu qua web: <http://localhost:8080>

Traefik UI, để xem các đường dẫn được proxy xử lý như thế nào: <http://localhost:8090>

**Lưu ý**: Lần đầu tiên bạn khởi động stack, có thể mất khoảng một phút để nó sẵn sàng. Trong khi backend chờ cơ sở dữ liệu sẵn sàng và cấu hình mọi thứ. Bạn có thể kiểm tra nhật ký để theo dõi quá trình này.

Để kiểm tra nhật ký, hãy chạy (trong một terminal khác):

```bash
docker compose logs
```

Để kiểm tra nhật ký của một dịch vụ cụ thể, thêm tên dịch vụ, ví dụ:

```bash
docker compose logs backend
```

## Mailcatcher

Mailcatcher là một máy chủ SMTP đơn giản giúp thu thập tất cả email được gửi bởi backend trong quá trình phát triển cục bộ. Thay vì gửi email thực tế, chúng sẽ được thu thập và hiển thị trên giao diện web.

Điều này hữu ích cho:

- Kiểm tra chức năng email trong quá trình phát triển
- Xác minh nội dung và định dạng email
- Gỡ lỗi các chức năng liên quan đến email mà không cần gửi email thực tế

Backend được cấu hình tự động để sử dụng Mailcatcher khi chạy với Docker Compose trên máy cục bộ (SMTP trên cổng 1025). Tất cả email được thu thập có thể xem tại <http://localhost:1080>.

## Phát triển cục bộ

Các tệp Docker Compose được cấu hình sao cho mỗi dịch vụ chạy trên một cổng khác nhau trên `localhost`.

Đối với backend và frontend, chúng sử dụng cùng cổng mà máy chủ phát triển cục bộ của chúng sẽ sử dụng, do đó, backend ở `http://localhost:8000` và frontend ở `http://localhost:5173`.

Như vậy, bạn có thể tắt một dịch vụ Docker Compose và khởi động máy chủ phát triển cục bộ của nó, và mọi thứ vẫn hoạt động bình thường, vì tất cả đều sử dụng cùng các cổng.

Ví dụ, bạn có thể dừng dịch vụ `frontend` trong Docker Compose, trong một cửa sổ terminal khác, chạy:

```bash
docker compose stop frontend
```

Sau đó khởi động máy chủ phát triển frontend cục bộ:

```bash
bun run dev
```

Hoặc bạn có thể dừng dịch vụ `backend` trong Docker Compose:

```bash
docker compose stop backend
```

Sau đó, bạn có thể chạy máy chủ phát triển cục bộ cho backend:

```bash
cd backend
fastapi dev app/main.py
```

## Docker Compose trên `localhost.tiangolo.com`

Khi khởi động stack Docker Compose, nó sẽ sử dụng `localhost` theo mặc định, với các cổng khác nhau cho từng dịch vụ (backend, frontend, adminer, v.v.).

Khi triển khai lên môi trường sản xuất (hoặc staging), mỗi dịch vụ sẽ được triển khai trên một subdomain khác nhau, ví dụ: `api.example.com` cho backend và `dashboard.example.com` cho frontend.

Trong hướng dẫn về [triển khai](deployment.md), bạn có thể tìm hiểu về Traefik, proxy đã được cấu hình. Đây là thành phần chịu trách nhiệm chuyển tiếp lưu lượng truy cập đến từng dịch vụ dựa trên tên miền con.

Nếu bạn muốn kiểm tra xem mọi thứ có hoạt động bình thường trên môi trường cục bộ hay không, bạn có thể chỉnh sửa tệp `.env` cục bộ và thay đổi:

```dotenv
DOMAIN=localhost.tiangolo.com
```

Điều này sẽ được các tệp Docker Compose sử dụng để cấu hình tên miền cơ sở cho các dịch vụ.

Traefik sẽ sử dụng thông tin này để chuyển tiếp lưu lượng truy cập tại `api.localhost.tiangolo.com` đến backend, và lưu lượng truy cập tại `dashboard.localhost.tiangolo.com` đến frontend.

Tên miền `localhost.tiangolo.com` là một tên miền đặc biệt được cấu hình (cùng với tất cả các tên miền con của nó) để trỏ đến `127.0.0.1`. Nhờ đó, bạn có thể sử dụng nó cho quá trình phát triển cục bộ.

Sau khi cập nhật, hãy chạy lại lệnh sau:

```bash
docker compose watch
```

Khi triển khai, ví dụ như trong môi trường sản xuất, Traefik chính được cấu hình bên ngoài các tệp Docker Compose. Đối với phát triển cục bộ, có một Traefik được bao gồm trong `compose.override.yml`, chỉ để cho phép bạn kiểm tra xem các tên miền có hoạt động như mong đợi hay không, ví dụ như với `api.localhost.tiangolo.com` và `dashboard.localhost.tiangolo.com`.

## Tệp Docker Compose và biến môi trường

Có một tệp `compose.yml` chính chứa tất cả các cấu hình áp dụng cho toàn bộ stack, tệp này được `docker compose` sử dụng tự động.

Ngoài ra còn có tệp `compose.override.yml` chứa các cấu hình ghi đè dành cho phát triển, ví dụ như để gắn mã nguồn dưới dạng volume. Tệp này được `docker compose` sử dụng tự động để áp dụng các cấu hình ghi đè lên trên tệp `compose.yml`.

Các tệp Docker Compose này sử dụng tệp `.env` chứa các cấu hình để chèn vào dưới dạng biến môi trường trong các container.

Chúng cũng sử dụng một số cấu hình bổ sung lấy từ các biến môi trường được đặt trong các skript trước khi gọi lệnh `docker compose`.

Sau khi thay đổi các biến, hãy đảm bảo khởi động lại stack:

```bash
docker compose watch
```

## Tệp .env

Tệp `.env` là tệp chứa tất cả các cấu hình, khóa và mật khẩu được tạo ra, v.v.

Tùy thuộc vào quy trình làm việc của bạn, bạn có thể muốn loại trừ tệp này khỏi Git, ví dụ như khi dự án của bạn là công khai. Trong trường hợp đó, bạn phải đảm bảo thiết lập cách để các công cụ CI lấy tệp này khi xây dựng hoặc triển khai dự án.

Một cách để thực hiện điều này là thêm từng biến môi trường vào hệ thống CI/CD của bạn, và cập nhật tệp `compose.yml` để đọc biến môi trường cụ thể đó thay vì đọc tệp `.env`.

## Kiểm tra trước khi commit và kiểm tra cú pháp mã

Chúng tôi đang sử dụng một công cụ có tên [prek](https://prek.j178.dev/) (phiên bản hiện đại thay thế cho [Pre-commit](https://pre-commit.com/)) để kiểm tra cú pháp và định dạng mã.

Khi cài đặt, công cụ này sẽ chạy ngay trước khi thực hiện commit trong Git. Điều này đảm bảo mã nguồn nhất quán và được định dạng đúng ngay cả trước khi được commit.

Bạn có thể tìm thấy tệp `.pre-commit-config.yaml` chứa các cấu hình tại thư mục gốc của dự án.

#### Cài đặt prek để chạy tự động

`prek` đã là một phần của các phụ thuộc của dự án.

Sau khi đã cài đặt và có sẵn công cụ `prek`, bạn cần "cài đặt" nó trong kho lưu trữ cục bộ để nó chạy tự động trước mỗi lần commit.

Sử dụng `uv`, bạn có thể thực hiện điều này bằng cách (đảm bảo bạn đang ở trong thư mục `backend`):

```bash
❯ uv run prek install -f
prek đã được cài đặt tại `../.git/hooks/pre-commit`
```

Tham số `-f` buộc quá trình cài đặt, trong trường hợp đã có hook `pre-commit` được cài đặt trước đó.

Bây giờ mỗi khi bạn cố gắng commit, ví dụ với:

```bash
git commit
```

...prek sẽ chạy, kiểm tra và định dạng mã nguồn bạn sắp commit, và sẽ yêu cầu bạn thêm mã đó (stage) lại với git trước khi commit.

Sau đó, bạn có thể `git add` các tệp đã sửa đổi/sửa lỗi lại và giờ có thể commit.

#### Chạy các hook prek thủ công

bạn cũng có thể chạy `prek` thủ công trên tất cả các tệp, bạn có thể thực hiện điều này bằng `uv` với:

```bash
❯ uv run prek run --all-files
kiểm tra các tệp lớn đã thêm.......................................... ....Đã qua
kiểm tra toml...............................................................Đã qua
kiểm tra yaml.................... ...........................................Đã qua
sửa lỗi cuối tệp.................................................. .......Đã qua
cắt khoảng trắng cuối dòng.................................................Đã qua
ruff............................... ......................................Đã qua
ruff-format....................................................... .......Đã qua
kiểm tra biome..............................................................Đã qua
```

## URL

Các URL sản xuất hoặc staging sẽ sử dụng các đường dẫn này, nhưng với tên miền của riêng bạn.

### URL phát triển

URL phát triển, dành cho phát triển cục bộ.

Frontend: <http://localhost:5173>

Backend: <http://localhost:8000>

Tài liệu tương tác tự động (Swagger UI): <http://localhost:8000/docs>

Tài liệu thay thế tự động (ReDoc): <http://localhost:8000/redoc>

Adminer: <http://localhost:8080>

Giao diện người dùng Traefik: <http://localhost:8090>

MailCatcher: <http://localhost:1080>

### URL phát triển với cấu hình `localhost.tiangolo.com`

URL phát triển, dành cho phát triển cục bộ.

Frontend: <http://dashboard.localhost.tiangolo.com>

Backend: <http://api.localhost.tiangolo.com>

Tài liệu tương tác tự động (Swagger UI): <http://api.localhost.tiangolo.com/docs>

Tài liệu thay thế tự động (ReDoc): <http://api.localhost.tiangolo.com/redoc>

Adminer: <http://localhost.tiangolo.com:8080>

Traefik UI: <http://localhost.tiangolo.com:8090>

MailCatcher: <http://localhost.tiangolo.com:1080>
