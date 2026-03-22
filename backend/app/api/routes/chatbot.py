from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List, Optional
import logging

from app.services.chat_agent import process_chat_message

router = APIRouter(prefix="/chatbot", tags=["chatbot"])
logger = logging.getLogger(__name__)

class ChatMessage(BaseModel):
    role: str
    content: str

class ChatRequest(BaseModel):
    messages: List[ChatMessage]

class ChatResponse(BaseModel):
    reply: str

@router.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest):
    try:
        # Get the latest user message
        user_message = next((msg.content for msg in reversed(request.messages) if msg.role == "user"), "")
        if not user_message:
            raise HTTPException(status_code=400, detail="No user message provided")
            
        reply_text = process_chat_message(user_message)
        
        return ChatResponse(reply=reply_text)
        
    except Exception as e:
        logger.error(f"Chat processing error: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))
