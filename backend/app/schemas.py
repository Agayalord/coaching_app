from pydantic import BaseModel
from typing import List


class MealCreate(BaseModel):
    user_id: int
    meal_type: str
    description: str
    calories: float


class ActivityCreate(BaseModel):
    user_id: int
    activity_type: str
    duration_minutes: int
    intensity: str


class FeedbackCreate(BaseModel):
    user_id: int
    sus_score: float
    comments: str
