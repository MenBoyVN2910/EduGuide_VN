# Dự án FastAPI - Triển khai

## Tóm Tắt Sơ Bộ

Nội Dung file này là hướng dẫn triển khai dự án lên một máy chủ từ xa bằng Docker Compose. Nếu chỉ muốn chạy local thì không cần đọc file này.

==========================================================================================================
Bạn có thể triển khai dự án lên một máy chủ từ xa bằng Docker Compose.

Dự án này yêu cầu bạn phải có một proxy Traefik để xử lý kết nối với thế giới bên ngoài và các chứng chỉ HTTPS.

Bạn có thể sử dụng các hệ thống CI/CD (tích hợp liên tục và triển khai liên tục) để triển khai tự động; hiện đã có sẵn các cấu hình để thực hiện điều này với GitHub Actions.

Tuy nhiên, trước tiên bạn cần phải cấu hình một số thiết lập. 🤓

## Chuẩn bị

- Chuẩn bị sẵn một máy chủ từ xa.
- Cấu hình các bản ghi DNS của tên miền để trỏ đến địa chỉ IP của máy chủ vừa tạo.
- Cấu hình một tên miền con dạng wildcard cho tên miền của bạn, để có thể sử dụng nhiều tên miền con cho các dịch vụ khác nhau, ví dụ: `*.fastapi-project.example.com`. Điều này sẽ hữu ích để truy cập các thành phần khác nhau, như `dashboard.fastapi-project.example.com`, `api.fastapi-project.example.com`, `traefik.fastapi-project.example.com`, `adminer.fastapi-project.example.com`, v.v. Và cũng cho `staging`, như `dashboard.staging.fastapi-project.example.com`, `adminer.staging.fastapi-project.example.com`, v.v.
- Cài đặt và cấu hình [Docker](https://docs.docker.com/engine/install/) trên máy chủ từ xa (Docker Engine, không phải Docker Desktop).

## Traefik công khai

Chúng ta cần một proxy Traefik để xử lý các kết nối đến và chứng chỉ HTTPS.

Bạn chỉ cần thực hiện các bước tiếp theo này một lần.

### Traefik Docker Compose

- Tạo một thư mục từ xa để lưu trữ tệp Docker Compose của Traefik:

```bash
mkdir -p /root/code/traefik-public/
```

Sao chép tệp Traefik Docker Compose lên máy chủ của bạn. Bạn có thể thực hiện điều này bằng cách chạy lệnh `rsync` trong terminal cục bộ:

```bash
rsync -a compose.traefik.yml root@your-server.example.com:/root/code/traefik-public/
```

### Mạng công cộng Traefik

Traefik này sẽ yêu cầu một "mạng công cộng" Docker có tên `traefik-public` để giao tiếp với các stack của bạn.

Như vậy, sẽ có một proxy Traefik công cộng duy nhất xử lý việc giao tiếp (HTTP và HTTPS) với thế giới bên ngoài, và phía sau đó, bạn có thể có một hoặc nhiều stack với các tên miền khác nhau, ngay cả khi chúng nằm trên cùng một máy chủ duy nhất.

Để tạo mạng công cộng Docker có tên `traefik-public`, hãy chạy lệnh sau trên máy chủ từ xa của bạn:

```bash
docker network create traefik-public
```

### Biến môi trường Traefik

Tệp Docker Compose của Traefik yêu cầu một số biến môi trường phải được thiết lập trong terminal trước khi khởi động. Bạn có thể thực hiện điều này bằng cách chạy các lệnh sau trên máy chủ từ xa.

- Tạo tên người dùng cho HTTP Basic Auth, ví dụ:

```bash
export USERNAME=admin
```

- Tạo biến môi trường chứa mật khẩu cho HTTP Basic Auth, ví dụ:

```bash
export PASSWORD=changethis
```

- Sử dụng openssl để tạo phiên bản "đã băm" của mật khẩu cho HTTP Basic Auth và lưu nó vào biến môi trường:

```bash
export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)
```

Để xác minh rằng mật khẩu đã băm là chính xác, bạn có thể in nó ra:

```bash
echo $HASHED_PASSWORD
```

- Tạo biến môi trường với tên miền của máy chủ, ví dụ:

```bash
export DOMAIN=fastapi-project.example.com
```

- Tạo biến môi trường với địa chỉ email cho Let's Encrypt, ví dụ:

```bash
export EMAIL=admin@example.com
```

**Lưu ý**: bạn cần thiết lập một địa chỉ email khác, địa chỉ email `@example.com` sẽ không hoạt động.

### Khởi động Traefik Docker Compose

Chuyển đến thư mục nơi bạn đã sao chép tệp Traefik Docker Compose trên máy chủ từ xa:

```bash
cd /root/code/traefik-public/
```

Bây giờ, với các biến môi trường đã được thiết lập và tệp `compose.traefik.yml` đã sẵn sàng, bạn có thể khởi động Traefik Docker Compose bằng cách chạy lệnh sau:

```bash
docker compose -f compose.traefik.yml up -d
```

## Triển khai dự án FastAPI

Bây giờ khi đã có Traefik, bạn có thể triển khai dự án FastAPI của mình bằng Docker Compose.

**Lưu ý**: Bạn có thể muốn chuyển sang phần về Triển khai liên tục với GitHub Actions.

## Sao chép mã

```bash
rsync -av --filter=":- .gitignore" ./ root@your-server.example.com:/root/code/app/
```

Lưu ý: `--filter=":- .gitignore"` yêu cầu `rsync` sử dụng các quy tắc giống như git, bỏ qua các tệp bị git bỏ qua, chẳng hạn như môi trường ảo Python.

## Biến môi trường

Bạn cần thiết lập một số biến môi trường trước tiên.

### Tạo khóa bí mật

Một số biến môi trường trong tệp `.env` có giá trị mặc định là `changethis`.

Bạn phải thay đổi chúng bằng một khóa bí mật. Để tạo khóa bí mật, bạn có thể chạy lệnh sau:

```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

Sao chép nội dung và sử dụng nó làm mật khẩu / khóa bí mật. Sau đó chạy lại lệnh này để tạo một khóa bảo mật khác.

### Biến môi trường bắt buộc

Đặt biến `ENVIRONMENT`, mặc định là `local` (cho môi trường phát triển), nhưng khi triển khai lên máy chủ, bạn nên đặt thành `staging` hoặc `production`:

```bash
export ENVIRONMENT=production
```

Đặt biến `DOMAIN`, mặc định là `localhost` (cho môi trường phát triển), nhưng khi triển khai, bạn nên sử dụng tên miền của riêng mình, ví dụ:

```bash
export DOMAIN=fastapi-project.example.com
```

Đặt `POSTGRES_PASSWORD` thành một giá trị khác với `changethis`:

```bash
export POSTGRES_PASSWORD="changethis"
```

Đặt `SECRET_KEY`, được sử dụng để ký token:

```bash
export SECRET_KEY="changethis"
```

Lưu ý: bạn có thể sử dụng lệnh Python ở trên để tạo khóa bí mật an toàn.

Đặt `FIRST_SUPER_USER_PASSWORD` thành một giá trị khác với `changethis`:

```bash
export FIRST_SUPERUSER_PASSWORD="changethis"
```

Đặt `BACKEND_CORS_ORIGINS` để bao gồm tên miền của bạn:

```bash
export BACKEND_CORS_ORIGINS="https://dashboard.${DOMAIN?Biến chưa được đặt},https://api.${DOMAIN?Biến chưa được đặt}"
```

Bạn có thể thiết lập một số biến môi trường khác:

- `PROJECT_NAME`: Tên dự án, được sử dụng trong API cho tài liệu và email.
- `STACK_NAME`: Tên của stack được sử dụng cho nhãn Docker Compose và tên dự án, tên này nên khác nhau cho `staging`, `production`, v.v. Bạn có thể sử dụng cùng một tên miền nhưng thay thế các dấu chấm bằng dấu gạch ngang, ví dụ: `fastapi-project-example-com` và `staging-fastapi-project-example-com`.
- `BACKEND_CORS_ORIGINS`: Danh sách các nguồn gốc CORS được phép, được phân tách bằng dấu phẩy.
- `FIRST_SUPERUSER`: Địa chỉ email của người dùng siêu quyền đầu tiên, người dùng này sẽ là người có thể tạo người dùng mới.
- `SMTP_HOST`: Tên máy chủ SMTP để gửi email, thông tin này sẽ được cung cấp bởi nhà cung cấp dịch vụ email của bạn (ví dụ: Mailgun, Sparkpost, Sendgrid, v.v.).
- `SMTP_USER`: Tên người dùng trên máy chủ SMTP để gửi email.
- `SMTP_PASSWORD`: Mật khẩu máy chủ SMTP để gửi email.
- `EMAILS_FROM_EMAIL`: Tài khoản email dùng để gửi email.
- `POSTGRES_SERVER`: Tên máy chủ của máy chủ PostgreSQL. Bạn có thể giữ nguyên giá trị mặc định là `db`, được cung cấp bởi chính Docker Compose. Thông thường, bạn không cần thay đổi thông số này trừ khi sử dụng nhà cung cấp bên thứ ba.
- `POSTGRES_PORT`: Cổng của máy chủ PostgreSQL. Bạn có thể giữ nguyên giá trị mặc định. Thông thường, bạn không cần thay đổi thông số này trừ khi sử dụng nhà cung cấp bên thứ ba.
- `POSTGRES_USER`: Tên người dùng Postgres, bạn có thể giữ nguyên giá trị mặc định.
- `POSTGRES_DB`: Tên cơ sở dữ liệu được sử dụng cho ứng dụng này. Bạn có thể giữ nguyên giá trị mặc định là `app`.
- `SENTRY_DSN`: DSN cho Sentry, nếu bạn đang sử dụng nó.

## Biến môi trường GitHub Actions

Có một số biến môi trường chỉ được sử dụng bởi GitHub Actions mà bạn có thể cấu hình:

- `LATEST_CHANGES`: Được sử dụng bởi hành động GitHub [latest-changes](https://github.com/tiangolo/latest-changes) để tự động thêm ghi chú phát hành dựa trên các PR đã được hợp nhất. Đây là mã truy cập cá nhân, hãy đọc tài liệu để biết chi tiết.
- `SMOKESHOW_AUTH_KEY`: Được sử dụng để xử lý và công bố độ bao phủ mã nguồn bằng [Smokeshow](https://github.com/samuelcolvin/smokeshow), hãy làm theo hướng dẫn của họ để tạo khóa Smokeshow (miễn phí).

### Triển khai với Docker Compose

Sau khi đã thiết lập các biến môi trường, bạn có thể triển khai bằng Docker Compose:

```bash
cd /root/code/app/
docker compose -f compose.yml build
docker compose -f compose.yml up -d
```

Đối với môi trường sản xuất, bạn không muốn sử dụng các tùy chỉnh trong `compose.override.yml`, đó là lý do chúng tôi chỉ định rõ `compose.yml` là tệp cần sử dụng.

## Triển khai liên tục (CD)

Bạn có thể sử dụng GitHub Actions để triển khai dự án của mình tự động. 😎

Bạn có thể có nhiều môi trường triển khai.

Hiện đã có hai môi trường được cấu hình sẵn, `staging` và `production`. 🚀

### Cài đặt GitHub Actions Runner

- Trên máy chủ từ xa của bạn, tạo một người dùng cho GitHub Actions:

```bash
sudo adduser github
```

- Cấp quyền Docker cho người dùng `github`:

```bash
sudo usermod -aG docker github
```

- Tạm thời chuyển sang người dùng `github`:

```bash
sudo su - github
```

- Truy cập vào thư mục chính của người dùng `github`:

```bash
cd
```

- [Cài đặt máy chạy tự lưu trữ GitHub Action theo hướng dẫn chính thức](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners#adding-a-self-hosted-runner-to-a-repository).

- Khi được hỏi về nhãn, hãy thêm một nhãn cho môi trường, ví dụ: `production`. Bạn cũng có thể thêm nhãn sau

- Khi được hỏi về nhãn, hãy thêm một nhãn cho môi trường, ví dụ: `production`. Bạn cũng có thể thêm nhãn sau này.

Sau khi cài đặt, hướng dẫn sẽ yêu cầu bạn chạy một lệnh để khởi động trình chạy. Tuy nhiên, trình chạy sẽ dừng lại ngay khi bạn kết thúc quá trình đó hoặc nếu kết nối cục bộ với máy chủ của bạn bị mất.

Để đảm bảo nó chạy khi khởi động và tiếp tục chạy, bạn có thể cài đặt nó dưới dạng dịch vụ. Để làm điều đó, hãy thoát khỏi người dùng `github` và quay lại người dùng `root`:

```bash
exit
```

Sau khi thực hiện, bạn sẽ quay lại người dùng trước đó. Và bạn sẽ ở trong thư mục trước đó, thuộc về người dùng đó.

Trước khi có thể truy cập thư mục người dùng `github`, bạn cần chuyển sang người dùng `root` (có thể bạn đã ở chế độ này):

```bash
sudo su
```

- Với tư cách người dùng `root`, hãy chuyển đến thư mục `actions-runner` bên trong thư mục home của người dùng `github`:

```bash
cd /home/github/actions-runner
```

- Cài đặt trình chạy tự lưu trữ dưới dạng dịch vụ với người dùng `github`:

```bash
./svc.sh install github
```

- Khởi động dịch vụ:

```bash
./svc.sh start
```

- Kiểm tra trạng thái của dịch vụ:

```bash
./svc.sh status
```

Bạn có thể đọc thêm về điều này trong hướng dẫn chính thức: [Cấu hình ứng dụng máy chạy tự lưu trữ dưới dạng dịch vụ](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/configuring-the-self-hosted-runner-application-as-a-service).

### Đặt các thông tin bí mật

Trên kho lưu trữ của bạn, hãy cấu hình các thông tin bí mật cho các biến môi trường cần thiết, giống như những biến đã mô tả ở trên, bao gồm `SECRET_KEY`, v.v. Hãy làm theo [hướng dẫn chính thức của GitHub về cách thiết lập thông tin bí mật cho kho lưu trữ](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-a-repository).

Các quy trình làm việc hiện tại của GitHub Actions yêu cầu các thông tin bí mật sau:

- `DOMAIN_PRODUCTION`
- `DOMAIN_STAGING`
- `STACK_NAME_PRODUCTION`
- `STACK_NAME_STAGING`
- `EMAILS_FROM_EMAIL`
- `FIRST_SUPERUSER`
- `FIRST_SUPERUSER_PASSWORD`
- `POSTGRES_PASSWORD`
- `SECRET_KEY`
- `LATEST_CHANGES`
- `SMOKESHOW_AUTH_KEY`

## Quy trình triển khai GitHub Actions

Có các quy trình GitHub Actions trong thư mục `.github/workflows` đã được cấu hình sẵn để triển khai lên các môi trường (các máy chạy GitHub Actions có nhãn):

- `staging`: sau khi đẩy (hoặc hợp nhất) lên nhánh `master`.
- `production`: sau khi phát hành bản cập nhật.

Nếu bạn cần thêm các môi trường khác, bạn có thể sử dụng các quy trình này làm điểm khởi đầu.

## URL

Thay thế `fastapi-project.example.com` bằng tên miền của bạn.

### Bảng điều khiển Traefik chính

Giao diện người dùng Traefik: `https://traefik.fastapi-project.example.com`

### Sản xuất

Frontend: `https://dashboard.fastapi-project.example.com`

Tài liệu API backend: `https://api.fastapi-project.example.com/docs`

URL cơ sở API backend: `https://api.fastapi-project.example.com`

Adminer: `https://adminer.fastapi-project.example.com`

### Môi trường staging

Frontend: `https://dashboard.staging.fastapi-project.example.com`

Tài liệu API phía máy chủ: `https://api.staging.fastapi-project.example.com/docs`

URL cơ sở API phía máy chủ: `https://api.staging.fastapi-project.example.com`

Adminer: `https://adminer.staging.fastapi-project.example.com`
