from datetime import datetime, timedelta, timezone
from typing import Any

import jwt
from pwdlib import PasswordHash
from pwdlib.hashers.argon2 import Argon2Hasher
from pwdlib.hashers.bcrypt import BcryptHasher

from app.core.config import settings

# Khởi tạo trình băm mật khẩu (Password Hashing)
# Hỗ trợ cả Argon2 (mạnh hơn) và Bcrypt (phổ biến)
password_hash = PasswordHash(
    (
        Argon2Hasher(),
        BcryptHasher(),
    )
)

# Thuật toán ký JWT
ALGORITHM = "HS256"


def create_access_token(subject: str | Any, expires_delta: timedelta) -> str:
    """
    Tạo mã xác thực JWT (Access Token).
    - subject: Thông tin định danh người dùng (thường là ID).
    - expires_delta: Thời gian hết hạn của token.
    """
    expire = datetime.now(timezone.utc) + expires_delta
    to_encode = {"exp": expire, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


def verify_password(
    plain_password: str, hashed_password: str
) -> tuple[bool, str | None]:
    """
    Kiểm tra mật khẩu nhập vào có khớp với mật khẩu đã băm trong DB không.
    Trả về: (Kết quả khớp, Mật khẩu băm mới nếu cần nâng cấp thuật toán).
    """
    return password_hash.verify_and_update(plain_password, hashed_password)


def get_password_hash(password: str) -> str:
    """
    Thực hiện băm mật khẩu thô để lưu vào cơ sở dữ liệu.
    """
    return password_hash.hash(password)
