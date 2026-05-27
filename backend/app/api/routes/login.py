from datetime import timedelta
from typing import Annotated, Any

from fastapi import APIRouter, Depends, HTTPException
from fastapi.responses import HTMLResponse
from fastapi.security import OAuth2PasswordRequestForm

from app import crud
from app.api.deps import CurrentUser, SessionDep, get_current_active_superuser
from app.core import security
from app.core.config import settings
from app.models import Message, NewPassword, Token, UserPublic, UserUpdate
from app.utils import (
    generate_password_reset_token,
    generate_reset_password_email,
    send_email,
    verify_password_reset_token,
)

router = APIRouter(tags=["login"])


@router.post("/login/access-token")
def login_access_token(
    session: SessionDep, form_data: Annotated[OAuth2PasswordRequestForm, Depends()]
) -> Token:
    """
    Đăng nhập bằng OAuth2 tương thích, lấy Access Token cho các yêu cầu sau này.
    """
    user = crud.authenticate(
        session=session, email=form_data.username, password=form_data.password
    )
    if not user:
        raise HTTPException(status_code=400, detail="Email hoặc mật khẩu không chính xác.")
    elif not user.is_active:
        raise HTTPException(status_code=400, detail="Người dùng đang bị vô hiệu hóa.")
    
    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    return Token(
        access_token=security.create_access_token(
            user.id, expires_delta=access_token_expires
        )
    )


@router.post("/login/test-token", response_model=UserPublic)
def test_token(current_user: CurrentUser) -> Any:
    """
    Kiểm tra tính hợp lệ của Access Token hiện tại.
    """
    return current_user


import secrets
from app.utils import generate_new_password_email

@router.post("/password-recovery/{email}")
def recover_password(email: str, session: SessionDep) -> Message:
    """
    Yêu cầu phục hồi mật khẩu qua Email.
    Hệ thống sẽ tạo mật khẩu mới và gửi về email.
    """
    user = crud.get_user_by_email(session=session, email=email)

    if not user:
        raise HTTPException(
            status_code=404, 
            detail="Người dùng với email này không tồn tại trong hệ thống."
        )

    # Tạo mật khẩu mới ngẫu nhiên (ví dụ 10 ký tự an toàn)
    new_password = secrets.token_urlsafe(10)
    
    # Cập nhật mật khẩu trong cơ sở dữ liệu
    hashed_password = security.get_password_hash(new_password)
    user.hashed_password = hashed_password
    session.add(user)
    session.commit()

    if settings.emails_enabled:
        email_data = generate_new_password_email(
            email_to=user.email, password=new_password
        )
        send_email(
            email_to=user.email,
            subject=email_data.subject,
            html_content=email_data.html_content,
        )
        
    return Message(
        message="Mật khẩu mới đã được tạo và gửi đến email của bạn."
    )


@router.post("/reset-password/")
def reset_password(session: SessionDep, body: NewPassword) -> Message:
    """
    Đặt lại mật khẩu mới bằng Token đã nhận được từ email.
    """
    email = verify_password_reset_token(token=body.token)
    if not email:
        raise HTTPException(status_code=400, detail="Token không hợp lệ hoặc đã hết hạn.")
    
    user = crud.get_user_by_email(session=session, email=email)
    if not user:
        raise HTTPException(status_code=400, detail="Token không hợp lệ.")
    elif not user.is_active:
        raise HTTPException(status_code=400, detail="Người dùng bị vô hiệu hóa.")
        
    user_in_update = UserUpdate(password=body.new_password)
    crud.update_user(
        session=session,
        db_user=user,
        user_in=user_in_update,
    )
    return Message(message="Cập nhật mật khẩu thành công.")


@router.post(
    "/password-recovery-html-content/{email}",
    dependencies=[Depends(get_current_active_superuser)],
    response_class=HTMLResponse,
)
def recover_password_html_content(email: str, session: SessionDep) -> Any:
    """
    Lấy nội dung HTML của email phục hồi mật khẩu (Chỉ dành cho Admin).
    """
    user = crud.get_user_by_email(session=session, email=email)

    if not user:
        raise HTTPException(
            status_code=404,
            detail="Người dùng với email này không tồn tại.",
        )
    password_reset_token = generate_password_reset_token(email=email)
    email_data = generate_reset_password_email(
        email_to=user.email, email=email, token=password_reset_token
    )

    return HTMLResponse(
        content=email_data.html_content, headers={"subject:": email_data.subject}
    )
