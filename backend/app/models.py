from sqlalchemy import Column, Integer, String, Float, DateTime
from datetime import datetime
from .database import Base


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
#     email = Column(String, unique=True, index=True)
#     name = Column(String)

    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    full_name = Column(String, nullable=True)
    goal = Column(String)


class Meal(Base):
    __tablename__ = "meals"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer)
    meal_type = Column(String)
    description = Column(String)
    calories = Column(Float)
    created_at = Column(DateTime, default=datetime.utcnow)


class Activity(Base):
    __tablename__ = "activities"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer)
    activity_type = Column(String)
    duration_minutes = Column(Integer)
    intensity = Column(String)
    calories_burned = Column(Float)
    created_at = Column(DateTime, default=datetime.utcnow)


class Feedback(Base):
    __tablename__ = "feedback"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer)
    sus_score = Column(Float)
    comments = Column(String)
    created_at = Column(DateTime, default=datetime.utcnow)
