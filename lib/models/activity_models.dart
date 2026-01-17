class ActivityCreateRequest {
  ActivityCreateRequest({
    required this.userId,
    required this.activityType,
    required this.durationMinutes,
    required this.intensity,
  });

  final int userId;
  final String activityType;
  final int durationMinutes;
  final String intensity;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'activity_type': activityType,
        'duration_minutes': durationMinutes,
        'intensity': intensity,
      };
}
