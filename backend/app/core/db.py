from sqlmodel import Session, create_engine, select

from app import crud
from app.core.config import settings
from app.models import User, UserCreate

# Khởi tạo engine để kết nối tới Postgres Database
engine = create_engine(str(settings.SQLALCHEMY_DATABASE_URI))


# Lưu ý: Cần đảm bảo tất cả các SQLModel models (app.models) được import 
# trước khi khởi tạo DB để các mối quan hệ (relationships) được đăng ký đúng cách.


def init_db(session: Session) -> None:
    """
    Khởi tạo dữ liệu ban đầu cho database.
    Thường được gọi khi setup hệ thống lần đầu hoặc reset dữ liệu.
    """
    # Các bảng nên được tạo thông qua migration của Alembic (trong thực tế)
    # Nếu muốn tự động tạo bảng trực tiếp, bạn có thể sử dụng SQLModel.metadata.create_all(engine)

    # Kiểm tra xem tài khoản Superuser đầu tiên đã tồn tại chưa
    user = session.exec(
        select(User).where(User.email == settings.FIRST_SUPERUSER)
    ).first()
    
    if not user:
        # Nếu chưa có, tạo tài khoản quản trị viên tối cao (Superuser)
        user_in = UserCreate(
            email=settings.FIRST_SUPERUSER,
            password=settings.FIRST_SUPERUSER_PASSWORD,
            is_superuser=True,
        )
        user = crud.create_user(session=session, user_create=user_in)
