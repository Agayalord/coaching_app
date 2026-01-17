class FeedbackCreateRequest {
  FeedbackCreateRequest({
    required this.userId,
    required this.susScore,
    required this.comments,
  });

  final int userId;
  final double susScore;
  final String comments;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'sus_score': susScore,
        'comments': comments,
      };
}
