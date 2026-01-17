class TodayRecommendation {
  TodayRecommendation({
    required this.targetKcal,
    required this.activityPlan,
    required this.nutritionFocus,
    required this.note,
  });

  final int targetKcal;
  final String activityPlan;
  final String nutritionFocus;
  final String note;

  factory TodayRecommendation.fromJson(Map<String, dynamic> json) {
    return TodayRecommendation(
      targetKcal: (json['target_kcal'] as num).toInt(),
      activityPlan: (json['activity_plan'] ?? '').toString(),
      nutritionFocus: (json['nutrition_focus'] ?? '').toString(),
      note: (json['note'] ?? '').toString(),
    );
  }
}
