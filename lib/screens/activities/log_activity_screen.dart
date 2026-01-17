import 'package:flutter/material.dart';
import '../../services/service_locator.dart';
import '../../models/activity_models.dart';

class LogActivityScreen extends StatefulWidget {
  const LogActivityScreen({super.key});

  @override
  State<LogActivityScreen> createState() => _LogActivityScreenState();
}

class _LogActivityScreenState extends State<LogActivityScreen> {
  final _durationController = TextEditingController();

  String _selectedActivityType = 'Walking';
  String _selectedIntensity = 'Medium';

  // Dummy list of recent activities for "Last 7 Activities"
  final List<Map<String, String>> _dummyActivities = [
    {
      'type': 'Walking',
      'duration': '30 min',
      'intensity': 'Low',
      'calories': '120 kcal',
    },
    {
      'type': 'Running',
      'duration': '20 min',
      'intensity': 'High',
      'calories': '260 kcal',
    },
    {
      'type': 'Gym',
      'duration': '45 min',
      'intensity': 'Medium',
      'calories': '350 kcal',
    },
    {
      'type': 'Cycling',
      'duration': '40 min',
      'intensity': 'Medium',
      'calories': '300 kcal',
    },
  ];

  @override
  void dispose() {
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _onSaveActivity() async {
    try {
      const userId = 1;

      final duration = int.tryParse(_durationController.text.trim()) ?? 0;

      final req = ActivityCreateRequest(
        userId: userId,
        activityType: _selectedActivityType,
        durationMinutes: duration,
        intensity: _selectedIntensity,
      );

      await ServiceLocator.api.logActivity(req);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Activity saved successfully.')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save activity: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F52B5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Activity'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black87,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===================== Form Section =====================
              const SizedBox(height: 8),
              const Text(
                'Add Activity Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                'Log your exercise so Smart Coaching can adjust your daily plan.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 20),

              // Activity Type
              const Text(
                'Activity Type',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedActivityType,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'Walking',
                        child: Text('Walking'),
                      ),
                      DropdownMenuItem(
                        value: 'Running',
                        child: Text('Running'),
                      ),
                      DropdownMenuItem(value: 'Gym', child: Text('Gym')),
                      DropdownMenuItem(
                        value: 'Cycling',
                        child: Text('Cycling'),
                      ),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _selectedActivityType = value);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Duration
              const Text(
                'Duration (minutes)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'e.g. 30',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Intensity
              const Text(
                'Intensity',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedIntensity,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'Low', child: Text('Low')),
                      DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'High', child: Text('High')),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _selectedIntensity = value);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Estimated calories (placeholder)
              const Text(
                'Estimated calories',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Text(
                  'Estimated calories: 230 kcal',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),

              const SizedBox(height: 24),

              // Save Activity button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSaveActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'SAVE ACTIVITY',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ===================== Last 7 Activities =====================
              const Text(
                'Last 7 Activities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'A quick view of your recent exercises.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 14),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _dummyActivities.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final activity = _dummyActivities[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      children: [
                        // Leading badge for activity type
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            activity['type']!,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Activity details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${activity['duration']} • ${activity['intensity']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                activity['calories']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
