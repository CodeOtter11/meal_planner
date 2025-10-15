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
  final List<String> dietaryPreferences = ['Vegetarian', 'Vegan', 'Non-Vegetarian', 'Keto', 'Paleo'];

  // Spoonacular API key (replace with your own)
  final String apiKey = 'e65793b8783e499fb8c80e6902f70c46';

  Future<void> generateMealPlan() async {
    if (_formKey.currentState!.validate()) {
      final String diet = dietaryPreference ?? 'balanced';
      final String intolerances = allergiesController.text.isNotEmpty ? allergiesController.text : 'peanuts';
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
          mealPlan.write('Daily Indian Meal Plan:\n');
          for (var meal in meals) {
            mealPlan.write('- ${meal['title']} (Ready in ${meal['readyInMinutes']} mins, Servings: ${meal['servings']})\n');
          }
          mealPlan.write('Nutrients: Calories: ${nutrients['calories'].toStringAsFixed(2)}, '
              'Protein: ${nutrients['protein'].toStringAsFixed(2)} g, '
              'Fat: ${nutrients['fat'].toStringAsFixed(2)} g, '
              'Carbs: ${nutrients['carbohydrates'].toStringAsFixed(2)} g');

          setState(() {
            mealPlanResult = mealPlan.toString();
          });
        } else {
          setState(() {
            mealPlanResult = 'Failed to generate meal plan. Status: ${response.statusCode}. Please check your API key or try again later.';
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

    // Simplified BMR calculation (Mifflin-St Jeor Equation)
    double bmr = genderValue == 'Male'
        ? 10 * weight + 6.25 * height - 5 * age + 5
        : 10 * weight + 6.25 * height - 5 * age - 161;

    // Adjust for goal
    if (goalValue == 'Lose Weight') bmr *= 0.85; // 15% deficit
    if (goalValue == 'Gain Muscle') bmr *= 1.15; // 15% surplus

    return bmr.round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A2C5A),
        title: const Text('AI Meal Planner'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Welcome to your AI Meal Planner!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4A2C5A)),
              ),
              const SizedBox(height: 10),
              const Text(
                'Here you can generate a personalized Indian meal plan based on your goals, preferences, and dietary restrictions. 🍛',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A2C5A),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    showForm = true;
                  });
                },
                child: const Text('Generate Meal Plan', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
              if (showForm)
                Center(
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Generate Your Meal Plan 🍽️',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF4A2C5A)),
                            ),
                            const SizedBox(height: 15),
                            TextFormField(
                              controller: ageController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Age',
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) => value!.isEmpty ? 'Enter your age' : null,
                            ),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: gender,
                              decoration: const InputDecoration(
                                labelText: 'Gender',
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: genders
                                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                                  .toList(),
                              onChanged: (val) => setState(() => gender = val),
                              validator: (value) => value == null ? 'Select gender' : null,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Height (cm)',
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) => value!.isEmpty ? 'Enter your height' : null,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Weight (kg)',
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              validator: (value) => value!.isEmpty ? 'Enter your weight' : null,
                            ),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: goal,
                              decoration: const InputDecoration(
                                labelText: 'Goal',
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: goals
                                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                                  .toList(),
                              onChanged: (val) => setState(() => goal = val),
                              validator: (value) => value == null ? 'Select goal' : null,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: allergiesController,
                              decoration: const InputDecoration(
                                labelText: 'Allergies',
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            DropdownButtonFormField<String>(
                              value: dietaryPreference,
                              decoration: const InputDecoration(
                                labelText: 'Dietary Preference',
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              items: dietaryPreferences
                                  .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                                  .toList(),
                              onChanged: (val) => setState(() => dietaryPreference = val),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4A2C5A),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: generateMealPlan,
                              child: const Text('Generate Now'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (mealPlanResult != null && mealPlanResult!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 8,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        mealPlanResult!,
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}