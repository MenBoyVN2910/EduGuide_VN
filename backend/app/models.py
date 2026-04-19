import uuid
from datetime import datetime, timezone

from pydantic import EmailStr
from sqlalchemy import DateTime
from sqlmodel import Field, Relationship, SQLModel


def get_datetime_utc() -> datetime:
    """Lấy thời gian hiện tại theo chuẩn UTC."""
    return datetime.now(timezone.utc)


# ── Thuộc tính dùng chung cho User ────────────────────────────────────
class UserBase(SQLModel):
    email: EmailStr = Field(unique=True, index=True, max_length=255)
    is_active: bool = True
    is_superuser: bool = False
    full_name: str | None = Field(default=None, max_length=255)


# ── Dữ liệu nhận từ API khi tạo người dùng ──────────────────────────
class UserCreate(UserBase):
    password: str = Field(min_length=8, max_length=128)


# ── Dữ liệu nhận từ API khi đăng ký tài khoản mới ──────────────────
class UserRegister(SQLModel):
    email: EmailStr = Field(max_length=255)
    password: str = Field(min_length=8, max_length=128)
    full_name: str | None = Field(default=None, max_length=255)


# ── Dữ liệu nhận từ API khi cập nhật thông tin ─────────────────────
class UserUpdate(UserBase):
    email: EmailStr | None = Field(default=None, max_length=255)  # type: ignore
    password: str | None = Field(default=None, min_length=8, max_length=128)


class UserUpdateMe(SQLModel):
    full_name: str | None = Field(default=None, max_length=255)
    email: EmailStr | None = Field(default=None, max_length=255)


class UpdatePassword(SQLModel):
    current_password: str = Field(min_length=8, max_length=128)
    new_password: str = Field(min_length=8, max_length=128)


# ── Mô hình Cơ sở dữ liệu (Database Model) ──────────────────────────
class User(UserBase, table=True):
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    hashed_password: str
    created_at: datetime | None = Field(
        default_factory=get_datetime_utc,
        sa_type=DateTime(timezone=True),  # type: ignore
    )
    # Mối quan hệ: Một người dùng có nhiều Items
    items: list["Item"] = Relationship(back_populates="owner", cascade_delete=True)


# ── Dữ liệu trả về qua API (Công khai) ──────────────────────────────
class UserPublic(UserBase):
    id: uuid.UUID
    created_at: datetime | None = None


class UsersPublic(SQLModel):
    data: list[UserPublic]
    count: int


# ── Thuộc tính dùng chung cho Item ────────────────────────────────────
class ItemBase(SQLModel):
    title: str = Field(min_length=1, max_length=255)
    description: str | None = Field(default=None, max_length=255)


# ── Dữ liệu nhận khi tạo Item mới ────────────────────────────────────
class ItemCreate(ItemBase):
    pass


# ── Dữ liệu nhận khi cập nhật Item ───────────────────────────────────
class ItemUpdate(ItemBase):
    title: str | None = Field(default=None, min_length=1, max_length=255)  # type: ignore


# ── Mô hình Cơ sở dữ liệu Item ───────────────────────────────────────
class Item(ItemBase, table=True):
    id: uuid.UUID = Field(default_factory=uuid.uuid4, primary_key=True)
    created_at: datetime | None = Field(
        default_factory=get_datetime_utc,
        sa_type=DateTime(timezone=True),  # type: ignore
    )
    # Khóa ngoại liên kết với bảng User
    owner_id: uuid.UUID = Field(
        foreign_key="user.id", nullable=False, ondelete="CASCADE"
    )
    owner: User | None = Relationship(back_populates="items")


# ── Dữ liệu Item trả về qua API ──────────────────────────────
class ItemPublic(ItemBase):
    id: uuid.UUID
    owner_id: uuid.UUID
    created_at: datetime | None = None


class ItemsPublic(SQLModel):
    data: list[ItemPublic]
    count: int


# ── Thông báo chung ───────────────────────────────────────────────
class Message(SQLModel):
    message: str


# ── Thông tin Token (Dùng cho JWT) ──────────────────────────────────
class Token(SQLModel):
    access_token: str
    token_type: str = "bearer"


# ── Dữ liệu giải mã từ JWT token ───────────────────────────────────
class TokenPayload(SQLModel):
    sub: str | None = None


# ── Mô hình cho việc đặt lại mật khẩu ────────────────────────────────
class NewPassword(SQLModel):
    token: str
    new_password: str = Field(min_length=8, max_length=128)
