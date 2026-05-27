"""
API Routes cho Chatbot — Các endpoint xử lý chat, streaming và kiểm tra sức khỏe hệ thống.
"""

import json
import logging
import asyncio
from typing import AsyncGenerator

from fastapi import APIRouter, HTTPException, Depends
from fastapi.responses import StreamingResponse
from pydantic import BaseModel

from app.api.deps import get_current_user
from app.models import User
from app.services.chat_agent import process_chat_message, get_cache_stats
from app.core.neo4j_db import neo4j_db

router = APIRouter(prefix="/chatbot", tags=["chatbot"])
logger = logging.getLogger(__name__)


# ── Mô hình Dữ liệu Request / Response ────────────────────────────────
class ChatMessage(BaseModel):
    """Định nghĩa cấu trúc một tin nhắn trong hội thoại."""
    role: str    # "user" hoặc "assistant"
    content: str # Nội dung tin nhắn


class ChatRequest(BaseModel):
    """Request gửi lên từ Frontend chứa danh sách tin nhắn."""
    messages: list[ChatMessage]


class ChatResponse(BaseModel):
    """Phản hồi trả về cho Frontend (Dạng không stream)."""
    reply: str


class HealthResponse(BaseModel):
    """Thông tin về tình trạng hoạt động của hệ thống."""
    status: str
    neo4j: str
    cache: dict


# ── POST /chatbot/chat ───────────────────────────────────────────────
@router.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest):
    """
    Xử lý tin nhắn chat với đầy đủ lịch sử hội thoại (hỗ trợ đa lượt).
    Đây là endpoint đồng bộ (trả về kết quả một lượt).
    """
    try:
        if not request.messages:
            raise HTTPException(status_code=400, detail="Chưa có tin nhắn nào được gửi.")

        # Chuyển đổi Pydantic model sang Dictionary để lớp service xử lý
        messages_dicts = [
            {"role": msg.role, "content": msg.content}
            for msg in request.messages
        ]

        # Kiểm tra xem có tin nhắn nào từ người dùng không
        has_user_msg = any(m["role"] == "user" for m in messages_dicts)
        if not has_user_msg:
            raise HTTPException(status_code=400, detail="Không tìm thấy tin nhắn của người dùng.")

        # Gọi Chat Agent để xử lý logic RAG
        reply_text = process_chat_message(messages_dicts)
        return ChatResponse(reply=reply_text)

    except HTTPException:
        raise
    except Exception as e:
        logger.error("Chat processing error: %s", str(e), exc_info=True)
        raise HTTPException(
            status_code=500,
            detail="Đã xảy ra lỗi khi xử lý tin nhắn. Vui lòng thử lại.",
        )


# ── POST /chatbot/chat/stream (SSE) ─────────────────────────────────
@router.post("/chat/stream")
async def chat_stream(
    request: ChatRequest,
    current_user: User = Depends(get_current_user)
) -> StreamingResponse:
    """
    Endpoint xử lý chat dạng Streaming (SSE).
    Trả về dữ liệu theo từng từ để tạo hiệu ứng gõ chữ mượt mà cho UI.
    Chỉ cho phép người dùng đã đăng nhập sử dụng.
    """
    if not request.messages:
        raise HTTPException(status_code=400, detail="Chưa có tin nhắn nào được gửi.")

    messages_dicts = [
        {"role": msg.role, "content": msg.content}
        for msg in request.messages
    ]

    async def event_generator() -> AsyncGenerator[str, None]:
        try:
            # Lấy toàn bộ câu trả lời từ AI
            reply_text = process_chat_message(messages_dicts)
            
            # Chia nhỏ câu trả lời thành các từ để giả lập streaming
            words = reply_text.split(" ")
            for i, word in enumerate(words):
                chunk = word + (" " if i < len(words) - 1 else "")
                # Gửi dữ liệu theo định dạng SSE
                data = json.dumps({"type": "chunk", "content": chunk}, ensure_ascii=False)
                yield f"data: {data}\n\n"
                
                # Delay nhỏ (20ms) để UI hiển thị mượt hơn
                await asyncio.sleep(0.02)

            # Gửi tín hiệu hoàn tất
            yield f"data: {json.dumps({'type': 'done'})}\n\n"
            
        except Exception as e:
            logger.error("Stream error: %s", e, exc_info=True)
            error_data = json.dumps(
                {"type": "error", "content": "Đã xảy ra lỗi trong quá trình truyền tải dữ liệu."},
                ensure_ascii=False,
            )
            yield f"data: {error_data}\n\n"

    return StreamingResponse(
        event_generator(),
        media_type="text/event-stream",
        headers={
            "Cache-Control": "no-cache",
            "Connection": "keep-alive",
            "X-Accel-Buffering": "no", # Quan trọng cho Nginx proxy
        },
    )


# ── GET /chatbot/health ─────────────────────────────────────────────
@router.get("/health", response_model=HealthResponse)
async def health():
    """
    Kiểm tra sức khỏe hệ thống: Kết nối Neo4j và thống kê bộ nhớ đệm.
    """
    neo4j_health = neo4j_db.health_check()
    cache_stats = get_cache_stats()
    overall = "healthy" if neo4j_health.get("neo4j") == "healthy" else "degraded"

    return HealthResponse(
        status=overall,
        neo4j=neo4j_health.get("neo4j", "unknown"),
        cache=cache_stats,
    )
