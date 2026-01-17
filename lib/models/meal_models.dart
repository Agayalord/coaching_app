class MealCreateRequest {
  MealCreateRequest({
    required this.userId,
    required this.mealType,
    required this.description,
    required this.calories,
  });

  final int userId;
  final String mealType;
  final String description;
  final double calories;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'meal_type': mealType,
        'description': description,
        'calories': calories,
      };
}
