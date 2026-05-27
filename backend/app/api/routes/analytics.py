import uuid
from datetime import datetime, timezone

from fastapi import APIRouter, Depends, HTTPException, Request
from sqlmodel import Session, func, select

from app.api.deps import get_current_user, get_db
from app.models import (
    AnalyticsChartData,
    AnalyticsDashboard,
    AnalyticsStats,
    User,
    VisitEvent,
    VisitEventPublic,
    VisitEventsPublic,
    Visitor,
    VisitorPublic,
)

router = APIRouter()

def get_datetime_utc() -> datetime:
    return datetime.now(timezone.utc)

@router.post("/track", response_model=VisitorPublic)
def track_visitor(
    request: Request,
    path: str,
    session: Session = Depends(get_db),
):
    """
    Theo dõi lượt truy cập. Nếu không có visitor cookie, tạo mới một visitor.
    """
    # Simple logic: for demo/basic tracking we'll just log based on IP or a simple token
    # In a real app we might read/set a cookie.
    client_host = request.client.host if request.client else "unknown"
    user_agent = request.headers.get("user-agent", "")
    
    # Check if a visitor with this IP created recently exists (e.g. today)
    # This is a naive approach; better is to use a cookie token from frontend
    statement = select(Visitor).where(Visitor.ip_address == client_host).order_by(Visitor.created_at.desc()) # type: ignore
    visitor = session.exec(statement).first()
    
    if not visitor:
        visitor = Visitor(
            ip_address=client_host,
            user_agent=user_agent,
            # We can parse device/browser from user_agent but skip for simplicity
        )
        session.add(visitor)
        session.commit()
        session.refresh(visitor)
        
    visit_event = VisitEvent(visitor_id=visitor.id, path=path)
    session.add(visit_event)
    session.commit()
    
    return visitor

@router.get("/stats", response_model=AnalyticsDashboard)
def get_analytics_stats(
    session: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
) -> AnalyticsDashboard:
    """
    Lấy thống kê tổng quan cho Dashboard. Chỉ dành cho Admin.
    """
    if not current_user.is_superuser:
        raise HTTPException(status_code=403, detail="Not enough permissions")
        
    total_users = session.exec(select(func.count(User.id))).one()
    total_visitors = session.exec(select(func.count(Visitor.id))).one()
    total_visits = session.exec(select(func.count(VisitEvent.id))).one()
    
    # today visits
    today = get_datetime_utc().replace(hour=0, minute=0, second=0, microsecond=0)
    visits_today = session.exec(
        select(func.count(VisitEvent.id)).where(VisitEvent.timestamp >= today) # type: ignore
    ).one()
    
    stats = AnalyticsStats(
        total_users=total_users,
        total_visitors=total_visitors,
        total_visits=total_visits,
        visits_today=visits_today,
    )
    
    # Mock chart data (in real life group by date)
    chart_data = [
        AnalyticsChartData(date=today.strftime("%Y-%m-%d"), visits=visits_today)
    ]
    
    return AnalyticsDashboard(stats=stats, chart_data=chart_data)

@router.get("/visitors", response_model=VisitEventsPublic)
def get_visit_events(
    session: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
    skip: int = 0,
    limit: int = 100,
) -> VisitEventsPublic:
    """
    Lấy danh sách các sự kiện truy cập.
    """
    if not current_user.is_superuser:
        raise HTTPException(status_code=403, detail="Not enough permissions")
        
    statement = select(VisitEvent).order_by(VisitEvent.timestamp.desc()).offset(skip).limit(limit) # type: ignore
    events = session.exec(statement).all()
    count = session.exec(select(func.count(VisitEvent.id))).one()
    
    return VisitEventsPublic(data=events, count=count)
