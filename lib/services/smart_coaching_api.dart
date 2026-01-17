import '../models/activity_models.dart';
import '../models/feedback_models.dart';
import '../models/meal_models.dart';
import '../models/recommendation_models.dart';
import 'api_client.dart';

class SmartCoachingApi {
  SmartCoachingApi(this._client);

  final ApiClient _client;

  // ---------------- Meals ----------------
  Future<void> logMeal(MealCreateRequest req) async {
    await _client.postJson('/meals/', body: req.toJson());
  }

  // ---------------- Activities ----------------
  Future<void> logActivity(ActivityCreateRequest req) async {
    await _client.postJson('/activities/', body: req.toJson());
  }

  // ---------------- Recommendations ----------------
  Future<TodayRecommendation> getTodayRecommendation() async {
    final json = await _client.getJson('/recommendations/today');
    return TodayRecommendation.fromJson(json);
  }

  // ---------------- Feedback (SUS) ----------------
  Future<void> submitSusFeedback(FeedbackCreateRequest req) async {
    await _client.postJson('/feedback/sus', body: req.toJson());
  }
}
