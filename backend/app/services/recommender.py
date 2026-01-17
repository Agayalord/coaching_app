def generate_daily_recommendation(total_calories: float, total_activity_minutes: int):
    """
    Lightweight rule-based recommendation logic.
    Designed for transparency and MSc-level evaluation.
    """

    target_kcal = 1950

    if total_activity_minutes < 30:
        activity_plan = "30–40 minutes brisk walking"
        focus = "Increase light daily activity"
    else:
        activity_plan = "Maintain current activity level"
        focus = "Maintain consistency"

    if total_calories < target_kcal - 200:
        nutrition_focus = "Increase protein and complex carbohydrates"
    elif total_calories > target_kcal + 200:
        nutrition_focus = "Reduce portion size at dinner"
    else:
        nutrition_focus = "Balanced intake – stay on track"

    return {
        "target_kcal": target_kcal,
        "activity_plan": activity_plan,
        "nutrition_focus": nutrition_focus,
        "note": "Generated using rule-based AI logic (demo)"
    }
