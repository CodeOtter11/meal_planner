import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MealPlanGeneratorPage extends StatefulWidget {
  const MealPlanGeneratorPage({super.key});

  @override
  State<MealPlanGeneratorPage> createState() => _MealPlanGeneratorPageState();
}

class _MealPlanGeneratorPageState extends State<MealPlanGeneratorPage> {
  final _formKey = GlobalKey<FormState>();
  bool showForm = false;
  String? mealPlanResult = '';

  // Form fields
  final TextEditingController ageController = TextEditingController();
  String? gender;
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String? goal;
  final TextEditingController allergiesController = TextEditingController();
  String? dietaryPreference;

  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> goals = ['Lose Weight', 'Maintain Weight', 'Gain Muscle'];
  final List<String> dietaryPreferences = [
    'Vegetarian',
    'Vegan',
    'Non-Vegetarian',
    'Keto',
    'Paleo'
  ];

  // Spoonacular API key
  final String apiKey = 'e65793b8783e499fb8c80e6902f70c46';

  Future<void> generateMealPlan() async {
    if (_formKey.currentState!.validate()) {
      final String diet = dietaryPreference ?? 'balanced';
      final String intolerances =
      allergiesController.text.isNotEmpty ? allergiesController.text : 'peanuts';
      final String targetCalories = _calculateTargetCalories().toString();

      final url = Uri.parse(
        'https://api.spoonacular.com/mealplanner/generate?timeFrame=day&targetCalories=$targetCalories&diet=$diet&exclude=$intolerances&cuisine=Indian&apiKey=$apiKey',
      );

      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final meals = data['meals'];
          final nutrients = data['nutrients'];
          final mealPlan = StringBuffer();
          mealPlan.write('🍛 **Your Indian Meal Plan** 🍛\n\n');
          for (var meal in meals) {
            mealPlan.write(
                '• ${meal['title']} (⏱ ${meal['readyInMinutes']} mins, 🍽 Servings: ${meal['servings']})\n');
          }
          mealPlan.write(
              '\n**Nutrients Summary:**\nCalories: ${nutrients['calories'].toStringAsFixed(2)} kcal\nProtein: ${nutrients['protein'].toStringAsFixed(2)} g\nFat: ${nutrients['fat'].toStringAsFixed(2)} g\nCarbs: ${nutrients['carbohydrates'].toStringAsFixed(2)} g');

          setState(() {
            mealPlanResult = mealPlan.toString();
            showForm = false; // close popup
          });
        } else {
          setState(() {
            mealPlanResult =
            'Failed to generate meal plan. Please check your API key or try again later.';
          });
        }
      } catch (e) {
        setState(() {
          mealPlanResult = 'Error: $e';
        });
      }
    }
  }

  int _calculateTargetCalories() {
    final int age = int.tryParse(ageController.text) ?? 25;
    final double height = double.tryParse(heightController.text) ?? 170;
    final double weight = double.tryParse(weightController.text) ?? 70;
    final String genderValue = gender ?? 'Male';
    final String goalValue = goal ?? 'Maintain Weight';

    double bmr = genderValue == 'Male'
        ? 10 * weight + 6.25 * height - 5 * age + 5
        : 10 * weight + 6.25 * height - 5 * age - 161;

    if (goalValue == 'Lose Weight') bmr *= 0.85;
    if (goalValue == 'Gain Muscle') bmr *= 1.15;

    return bmr.round();
  }

  // Helper for consistent text field design
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Color(0xFF6C3483), fontWeight: FontWeight.w500),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFB57EDC), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFFB57EDC), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xFF8E44AD), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8E44AD),
        title: const Text('AI Meal Planner', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    'Customize your preferences and generate a meal plan designed for your lifestyle 🍱',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() => showForm = true);
                    },
                    icon: const Icon(Icons.auto_awesome, color: Colors.white),
                    label: const Text('Generate Meal Plan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E44AD),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (mealPlanResult != null && mealPlanResult!.isNotEmpty)
                    Card(
                      elevation: 10,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          mealPlanResult!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Popup form overlay
          if (showForm)
            GestureDetector(
              onTap: () => setState(() => showForm = false),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Card(
                      elevation: 20,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Fill Your Details 🍽️',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF6C3483),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: ageController,
                                  keyboardType: TextInputType.number,
                                  decoration: _inputDecoration('Age'),
                                  validator: (v) => v!.isEmpty ? 'Enter your age' : null,
                                ),
                                const SizedBox(height: 12),
                                DropdownButtonFormField<String>(
                                  value: gender,
                                  decoration: _inputDecoration('Gender'),
                                  items: genders
                                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                                      .toList(),
                                  onChanged: (val) => setState(() => gender = val),
                                  validator: (v) => v == null ? 'Select gender' : null,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: heightController,
                                  keyboardType: TextInputType.number,
                                  decoration: _inputDecoration('Height (cm)'),
                                  validator: (v) => v!.isEmpty ? 'Enter your height' : null,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: weightController,
                                  keyboardType: TextInputType.number,
                                  decoration: _inputDecoration('Weight (kg)'),
                                  validator: (v) => v!.isEmpty ? 'Enter your weight' : null,
                                ),
                                const SizedBox(height: 12),
                                DropdownButtonFormField<String>(
                                  value: goal,
                                  decoration: _inputDecoration('Goal'),
                                  items: goals
                                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                                      .toList(),
                                  onChanged: (val) => setState(() => goal = val),
                                  validator: (v) => v == null ? 'Select goal' : null,
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: allergiesController,
                                  decoration: _inputDecoration('Allergies (if any)'),
                                ),
                                const SizedBox(height: 12),
                                DropdownButtonFormField<String>(
                                  value: dietaryPreference,
                                  decoration: _inputDecoration('Dietary Preference'),
                                  items: dietaryPreferences
                                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                                      .toList(),
                                  onChanged: (val) =>
                                      setState(() => dietaryPreference = val),
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: generateMealPlan,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF8E44AD),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      'Generate Now',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
