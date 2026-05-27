import logging

import sentry_sdk
from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.routing import APIRoute
from starlette.middleware.cors import CORSMiddleware

from app.api.main import api_router
from app.core.config import settings
from app.core.neo4j_db import neo4j_db

# Cấu hình logging cho ứng dụng
logger = logging.getLogger("app")


def custom_generate_unique_id(route: APIRoute) -> str:
    """
    Tạo ID duy nhất cho mỗi route API để hỗ trợ sinh code client (như TypeScript).
    """
    return f"{route.tags[0]}-{route.name}"


@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Quản lý vòng đời của ứng dụng (Startup và Shutdown).
    Sử dụng asynccontextmanager để thay thế cho các decorator @app.on_event cũ.
    """
    # ── Startup (Khởi chạy hệ thống) ───────────────────────────────
    logger.info("Đang khởi động — kết nối tới Neo4j...")
    try:
        # Cố gắng kết nối tới Graph Database ngay khi server bật
        neo4j_db.connect()
        logger.info("Kết nối Neo4j thành công.")
    except Exception as e:
        # Nếu lỗi, log lại cảnh báo (hệ thống sẽ thử lại khi có request đầu tiên)
        logger.warning("Kết nối Neo4j thất bại lúc khởi động (sẽ thử lại sau): %s", e)

    yield  # Tại đây ứng dụng bắt đầu nhận và xử lý các request

    # ── Shutdown (Đóng hệ thống) ──────────────────────────────────
    logger.info("Đang tắt server — đóng kết nối Neo4j...")
    neo4j_db.close()
    logger.info("Hoàn tất dọn dẹp tài nguyên.")


# Khởi tạo Sentry nếu có cấu hình DSN và không phải môi trường local
if settings.SENTRY_DSN and settings.ENVIRONMENT != "local":
    sentry_sdk.init(dsn=str(settings.SENTRY_DSN), enable_tracing=True)

# Khởi tạo instance FastAPI
app = FastAPI(
    title=settings.PROJECT_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
    generate_unique_id_function=custom_generate_unique_id,
    lifespan=lifespan,
)

# Cấu hình CORS (Cross-Origin Resource Sharing)
# Cho phép Frontend từ các domain khác truy cập vào API
if settings.all_cors_origins:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.all_cors_origins,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

# Tích hợp các route API từ module api.main
app.include_router(api_router, prefix=settings.API_V1_STR)
