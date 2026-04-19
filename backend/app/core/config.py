import secrets
import warnings
from typing import Annotated, Any, Literal

from pydantic import (
    AnyUrl,
    BeforeValidator,
    EmailStr,
    HttpUrl,
    PostgresDsn,
    computed_field,
    model_validator,
)
from pydantic_settings import BaseSettings, SettingsConfigDict
from typing_extensions import Self


def parse_cors(v: Any) -> list[str] | str:
    """
    Phân tích chuỗi CORS từ biến môi trường.
    Hỗ trợ cả định dạng danh sách [a, b] hoặc chuỗi phân cách bằng dấu phẩy.
    """
    if isinstance(v, str) and not v.startswith("["):
        return [i.strip() for i in v.split(",") if i.strip()]
    elif isinstance(v, list | str):
        return v
    raise ValueError(v)


class Settings(BaseSettings):
    """
    Lớp quản lý tất cả các cấu hình (Settings) của ứng dụng.
    Sử dụng pydantic-settings để tự động đọc biến môi trường từ file .env.
    """
    model_config = SettingsConfigDict(
        # Đọc file .env ở thư mục gốc (cao hơn thư mục ./backend/ một cấp)
        env_file="../.env",
        env_ignore_empty=True,
        extra="ignore",
    )
    
    # ── Thông tin API cơ bản ──────────────────────────────────────
    API_V1_STR: str = "/api/v1"
    SECRET_KEY: str = secrets.token_urlsafe(32) # Khóa bí mật cho JWT
    # Thời hạn token: 60 phút * 24 giờ * 8 ngày = 8 ngày
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 8
    FRONTEND_HOST: str = "http://localhost:5173"
    ENVIRONMENT: Literal["local", "staging", "production"] = "local"

    # Cấu hình CORS
    BACKEND_CORS_ORIGINS: Annotated[
        list[AnyUrl] | str, BeforeValidator(parse_cors)
    ] = []

    @computed_field  # type: ignore[prop-decorator]
    @property
    def all_cors_origins(self) -> list[str]:
        """Tổng hợp danh sách các domain được phép truy cập API."""
        return [str(origin).rstrip("/") for origin in self.BACKEND_CORS_ORIGINS] + [
            self.FRONTEND_HOST
        ]

    PROJECT_NAME: str
    SENTRY_DSN: HttpUrl | None = None
    
    # ── Cấu hình Postgres Database ─────────────────────────────────
    POSTGRES_SERVER: str
    POSTGRES_PORT: int = 5432
    POSTGRES_USER: str
    POSTGRES_PASSWORD: str = ""
    POSTGRES_DB: str = ""

    @computed_field  # type: ignore[prop-decorator]
    @property
    def SQLALCHEMY_DATABASE_URI(self) -> PostgresDsn:
        """Tự động xây dựng chuỗi kết nối SQLAlchemy từ các tham số Postgres."""
        return PostgresDsn.build(
            scheme="postgresql+psycopg",
            username=self.POSTGRES_USER,
            password=self.POSTGRES_PASSWORD,
            host=self.POSTGRES_SERVER,
            port=self.POSTGRES_PORT,
            path=self.POSTGRES_DB,
        )

    # ── Cấu hình Email (SMTP) ──────────────────────────────────────
    SMTP_TLS: bool = True
    SMTP_SSL: bool = False
    SMTP_PORT: int = 587
    SMTP_HOST: str | None = None
    SMTP_USER: str | None = None
    SMTP_PASSWORD: str | None = None
    EMAILS_FROM_EMAIL: EmailStr | None = None
    EMAILS_FROM_NAME: str | None = None

    @model_validator(mode="after")
    def _set_default_emails_from(self) -> Self:
        """Nếu thiếu tên người gửi mail, mặc định lấy tên Project."""
        if not self.EMAILS_FROM_NAME:
            self.EMAILS_FROM_NAME = self.PROJECT_NAME
        return self

    EMAIL_RESET_TOKEN_EXPIRE_HOURS: int = 48

    @computed_field  # type: ignore[prop-decorator]
    @property
    def emails_enabled(self) -> bool:
        """Kiểm tra xem tính năng gửi email có được kích hoạt không."""
        return bool(self.SMTP_HOST and self.EMAILS_FROM_EMAIL)

    # ── Cấu hình Neo4j Graph Database ─────────────────────────────
    NEO4J_URI: str = "bolt://localhost:7687"
    NEO4J_USER: str = "neo4j"
    NEO4J_PASSWORD: str = ""
    NEO4J_MAX_POOL_SIZE: int = 50
    NEO4J_CONNECTION_TIMEOUT: int = 30

    # ── Cấu hình Gemini AI (Mô hình ngôn ngữ lớn) ─────────────────
    GEMINI_API_KEY: str = ""
    GEMINI_CYPHER_MODEL: str = "gemini-2.5-flash"
    GEMINI_ANSWER_MODEL: str = "gemini-2.5-flash"

    # ── Cấu hình Cache cho Agent ──────────────────────────────────
    CACHE_TTL_SECONDS: int = 600  # Thời gian sống của cache (10 phút)
    CACHE_MAX_SIZE: int = 256     # Số lượng bản ghi tối đa trong cache

    EMAIL_TEST_USER: EmailStr = "test@example.com"
    FIRST_SUPERUSER: EmailStr
    FIRST_SUPERUSER_PASSWORD: str

    def _check_default_secret(self, var_name: str, value: str | None) -> None:
        """Cảnh báo nếu vẫn sử dụng mật khẩu mặc định 'changethis'."""
        if value == "changethis":
            message = (
                f'Giá trị của {var_name} đang là "changethis", '
                "vì lý do bảo mật, vui lòng đổi nó khi triển khai thực tế."
            )
            if self.ENVIRONMENT == "local":
                warnings.warn(message, stacklevel=1)
            else:
                raise ValueError(message)

    @model_validator(mode="after")
    def _enforce_non_default_secrets(self) -> Self:
        """Đảm bảo các khóa bảo mật quan trọng đã được thay đổi."""
        self._check_default_secret("SECRET_KEY", self.SECRET_KEY)
        self._check_default_secret("POSTGRES_PASSWORD", self.POSTGRES_PASSWORD)
        self._check_default_secret(
            "FIRST_SUPERUSER_PASSWORD", self.FIRST_SUPERUSER_PASSWORD
        )

        return self


settings = Settings()  # type: ignore
