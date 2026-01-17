from fastapi import APIRouter
from ..services.recommender import generate_daily_recommendation

router = APIRouter(prefix="/recommendations", tags=["Recommendations"])


@router.get("/today")
def get_today_recommendation():
    # Demo aggregated values
    total_calories = 1350
    total_activity_minutes = 24

    return generate_daily_recommendation(
        total_calories=total_calories,
        total_activity_minutes=total_activity_minutes
    )
