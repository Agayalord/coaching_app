from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from ..database import SessionLocal
from ..models import Meal
from ..schemas import MealCreate

router = APIRouter(prefix="/meals", tags=["Meals"])


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/")
def log_meal(meal: MealCreate, db: Session = Depends(get_db)):
    db_meal = Meal(**meal.dict())
    db.add(db_meal)
    db.commit()
    return {"message": "Meal logged successfully"}
