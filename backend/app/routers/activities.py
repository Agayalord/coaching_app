from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from ..database import SessionLocal
from ..models import Activity
from ..schemas import ActivityCreate

router = APIRouter(prefix="/activities", tags=["Activities"])


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/")
def log_activity(activity: ActivityCreate, db: Session = Depends(get_db)):
    calories_estimated = activity.duration_minutes * 5  # simple heuristic

    db_activity = Activity(
        user_id=activity.user_id,
        activity_type=activity.activity_type,
        duration_minutes=activity.duration_minutes,
        intensity=activity.intensity,
        calories_burned=calories_estimated,
    )

    db.add(db_activity)
    db.commit()
    return {"message": "Activity logged successfully"}
