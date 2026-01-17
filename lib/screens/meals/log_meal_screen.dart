import 'package:flutter/material.dart';
import '../../services/service_locator.dart';
import '../../models/meal_models.dart';

class LogMealScreen extends StatefulWidget {
  const LogMealScreen({super.key});

  @override
  State<LogMealScreen> createState() => _LogMealScreenState();
}

class _LogMealScreenState extends State<LogMealScreen> {
  final _foodController = TextEditingController();
  final _portionController = TextEditingController();
  final _caloriesController = TextEditingController();

  String _selectedMealType = 'Breakfast';

  // Dummy list of meals for the "Today’s Meals" section
  final List<Map<String, String>> _dummyMeals = [
    {
      'mealType': 'Breakfast',
      'food': 'Oatmeal with banana',
      'calories': '320 kcal',
    },
    {
      'mealType': 'Lunch',
      'food': 'Rice and chicken stew',
      'calories': '650 kcal',
    },
    {'mealType': 'Snack', 'food': 'Apple and peanuts', 'calories': '180 kcal'},
  ];

  @override
  void dispose() {
    _foodController.dispose();
    _portionController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  Future<void> _onSaveMeal() async {
    try {
      // Demo user_id for now (until auth is implemented)
      const userId = 1;

      final calories = double.tryParse(_caloriesController.text.trim()) ?? 0;

      final req = MealCreateRequest(
        userId: userId,
        mealType: _selectedMealType,
        description: _foodController.text.trim(),
        calories: calories,
      );

      await ServiceLocator.api.logMeal(req);

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Meal saved successfully.')));
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save meal: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F52B5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Meal'),
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
                'Add Meal Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                'Log what you ate so Smart Coaching can personalise your plan.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 20),

              // Meal Type
              const Text(
                'Meal Type',
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
                    value: _selectedMealType,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'Breakfast',
                        child: Text('Breakfast'),
                      ),
                      DropdownMenuItem(value: 'Lunch', child: Text('Lunch')),
                      DropdownMenuItem(value: 'Dinner', child: Text('Dinner')),
                      DropdownMenuItem(value: 'Snack', child: Text('Snack')),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() => _selectedMealType = value);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Food description
              const Text(
                'Food description',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _foodController,
                decoration: InputDecoration(
                  hintText: 'e.g. Rice and chicken stew',
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

              // Portion size
              const Text(
                'Portion size (grams or pieces)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _portionController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'e.g. 200 g',
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

              // Calories
              const Text(
                'Calories (kcal)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _caloriesController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'e.g. 450',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Save Meal button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onSaveMeal,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'SAVE MEAL',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),
              // ===================== Today's Meals Section =====================
              const Text(
                'Today\'s Meals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                'Here is a quick view of what you’ve logged today.',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 14),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _dummyMeals.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final meal = _dummyMeals[index];
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
                        // Leading badge for meal type
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
                            meal['mealType']!,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Food description + calories
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meal['food']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                meal['calories']!,
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
