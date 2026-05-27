from fastapi import APIRouter

<<<<<<< HEAD
from app.api.routes import items, login, private, users, utils, chatbot, analytics, knowledge
=======
from app.api.routes import items, login, private, users, utils, chatbot
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
from app.core.config import settings

api_router = APIRouter()
api_router.include_router(login.router)
api_router.include_router(users.router)
api_router.include_router(utils.router)
api_router.include_router(items.router)
api_router.include_router(chatbot.router)
<<<<<<< HEAD
api_router.include_router(analytics.router, prefix="/analytics", tags=["analytics"])
api_router.include_router(knowledge.router, prefix="/knowledge", tags=["knowledge"])
=======
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113


if settings.ENVIRONMENT == "local":
    api_router.include_router(private.router)
