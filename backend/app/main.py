from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from .database import Base, engine
from .routers import meals, activities, recommendations, feedback, auth


Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="Smart Coaching Backend",
    description="AI-based fitness and nutrition coaching API (MSc prototype)",
    version="1.0.0",
)


# ✅ CORS (needed for Flutter Web / Chrome)
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:59673",  # example Flutter web dev port
        "http://127.0.0.1:59673",
        "http://localhost:8080",
        "http://127.0.0.1:8080",
        "http://localhost",
        "http://127.0.0.1",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(meals.router)
app.include_router(activities.router)
app.include_router(recommendations.router)
app.include_router(feedback.router)
app.include_router(auth.router) 
