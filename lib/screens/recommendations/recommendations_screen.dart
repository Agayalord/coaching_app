import 'package:flutter/material.dart';
import '../../services/service_locator.dart';
import '../../models/recommendation_models.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F52B5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Recommendations'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: FutureBuilder<TodayRecommendation>(
          future: ServiceLocator.api.getTodayRecommendation(),
          builder: (context, snapshot) {
            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // Error state
            if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 12,
                ),
                child: Text(
                  'Failed to load recommendations: ${snapshot.error}',
                  style: const TextStyle(fontSize: 14),
                ),
              );
            }

            // Data state
            final rec = snapshot.data!;
            return _buildContent(primaryColor: primaryColor, rec: rec);
          },
        ),
      ),
    );
  }

  // Keeps your existing UI layout, but uses backend values where relevant
  Widget _buildContent({
    required Color primaryColor,
    required TodayRecommendation rec,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===================== Today’s Plan Card =====================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today\'s Smart Plan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Text(
                  'Here is your personalised plan for today based on your recent meals and activity.',
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 14),

                // ✅ Now using backend recommendation values
                _BulletItem(text: 'Target: ${rec.targetKcal} kcal'),
                _BulletItem(text: 'Suggested Activity: ${rec.activityPlan}'),
                const _BulletItem(
                  text:
                      'Hydration: Aim for 6–8 glasses of water throughout the day',
                ),
                _BulletItem(text: 'Nutrition focus: ${rec.nutritionFocus}'),

                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    rec.note.isNotEmpty
                        ? rec.note
                        : 'Powered by AI (demo data)',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===================== Tomorrow’s Preview Card =====================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 18),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F5FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Tomorrow\'s Preview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10),
                _BulletItem(
                  text:
                      'Forecast target: ~2,000 kcal (depending on your activity today)',
                ),
                _BulletItem(
                  text:
                      'Planned focus: maintain consistent breakfast and add a light evening walk',
                ),
                _BulletItem(
                  text:
                      'Tip: Plan your meals ahead tonight to stay on track tomorrow.',
                ),
              ],
            ),
          ),

          // ===================== Why this plan? =====================
          const Text(
            'Why this plan?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Based on your recent low activity and slightly reduced calorie intake, '
            'your targets have been adjusted to stay realistic and sustainable. '
            'The app prioritises gradual progress over extreme changes so that you '
            'can build habits that last.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'As you continue logging your meals and activities, Smart Coaching will refine '
            'your daily recommendations, aiming to balance energy intake, movement, and '
            'recovery. This demo view shows how recommendations might be presented once '
            'the AI model is fully integrated.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),

          // ===================== Gentle hint / footer =====================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 20, color: primaryColor),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'These recommendations are demo values for now. In the full version, '
                    'they will be driven by your real data and AI predictions.',
                    style: TextStyle(fontSize: 13, color: primaryColor),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ======================= Helper Widget =======================

class _BulletItem extends StatelessWidget {
  final String text;

  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 14)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
