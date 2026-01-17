from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from ..database import SessionLocal
from ..models import Feedback
from ..schemas import FeedbackCreate

router = APIRouter(prefix="/feedback", tags=["Feedback"])


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/sus")
def submit_feedback(feedback: FeedbackCreate, db: Session = Depends(get_db)):
    db_feedback = Feedback(**feedback.dict())
    db.add(db_feedback)
    db.commit()
    return {"message": "Feedback submitted successfully"}
