import 'package:flutter/material.dart';
import 'services/meal_plan_generator_service.dart';

class MealPlanGeneratorPage extends StatefulWidget {
  const MealPlanGeneratorPage({super.key});

  @override
  State<MealPlanGeneratorPage> createState() => _MealPlanGeneratorPageState();
}

class _MealPlanGeneratorPageState extends State<MealPlanGeneratorPage> {
  final _formKey = GlobalKey<FormState>();
  bool showForm = false;
  String? mealPlanResult = '';
  bool isWeekly = false; // Toggle for weekly/daily plan
  bool _isloading = false;
  final _mealService = MealPlanGeneratorService(); // ✅ Service instance

// ⬇️ Paste here
  Future<void> swapMeal(String mealType) async {
    setState(() => _isloading = true);

    try {
      final newMeal = await _mealService.generateMealPlan(
          "Generate a new $mealType option only for ${isWeekly ? 'weekly' : 'daily'} plan with Indian-style meals."
      );

      setState(() {
        mealPlanResult = "${mealPlanResult!}\n\n🔄 Updated $mealType:\n$newMeal";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$mealType swapped successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error swapping meal: $e')),
      );
    } finally {
      setState(() => _isloading = false);
    }
  }


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

  // 🔹 Sample data for demonstration
  List<String> groceryList = [];
  double estimatedBudget = 0;

  // ✅ Meal progress tracking
  Map<String, bool> _mealStatus = {
    "Breakfast": false,
    "Lunch": false,
    "Dinner": false,
  };
  double _userProgress = 0.0;

  // 🔹 Generate plan using Gemini API
  Future<void> generateMealPlan() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isloading = true;
    });

    final prompt = """
Generate a ${isWeekly ? "weekly" : "daily"} meal plan for:
Age: ${ageController.text},
Gender: $gender,
Height: ${heightController.text} cm,
Weight: ${weightController.text} kg,
Goal: $goal,
Allergies: ${allergiesController.text.isEmpty ? "None" : allergiesController.text},
Dietary Preference: $dietaryPreference.

Provide meals (Breakfast, Lunch, Dinner, Snacks) with Indian-style suggestions if possible.
Include variety, portion balance, and nutrition-conscious foods.
""";

    try {
      final result = await _mealService.generateMealPlan(prompt);
      setState(() {
        mealPlanResult = result;
        estimatedBudget = isWeekly ? 2100 : 300;
        showForm = false;
        _isloading = false;

        _mealStatus = {"Breakfast": false, "Lunch": false, "Dinner": false};
        _userProgress = 0.0;
      });
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error generating meal plan: $e")),
      );
    }
  }


  // ✅ Mark meal completed
  void _markMealAsCompleted(String meal) {
    if (!_mealStatus[meal]!) {
      setState(() {
        _mealStatus[meal] = true;
        _userProgress = (_mealStatus.values.where((done) => done).length /
            _mealStatus.length)
            .clamp(0.0, 1.0);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$meal marked as completed!')),
      );
    }
  }

  // 🎯 Input decoration style
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(
        color: Color(0xFF6C3483),
        fontWeight: FontWeight.w500,
      ),
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
        title: const Text('AI Meal Planner',
            style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          Row(
            children: [
              const Text("Daily", style: TextStyle(color: Colors.white)),
              Switch(
                activeColor: Colors.white,
                value: isWeekly,
                onChanged: (val) => setState(() => isWeekly = val),
              ),
              const Text("Weekly", style: TextStyle(color: Colors.white)),
              const SizedBox(width: 10)
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // 🥘 Meal Plan Display
                if (mealPlanResult != null && mealPlanResult!.isNotEmpty)
                  Column(
                    children: [
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
                      const SizedBox(height: 20),

                      // 🔁 Swap Meal Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _actionButton(
                              'Swap Breakfast', () => swapMeal('Breakfast')),
                          _actionButton('Swap Lunch', () => swapMeal('Lunch')),
                          _actionButton('Swap Dinner', () => swapMeal('Dinner')),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ✅ Meal Progress Section
                      const Text(
                        "Mark Your Meals as Completed 🍽️",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: _mealStatus.keys.map((meal) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              title: Text(meal,
                                  style: const TextStyle(fontSize: 16)),
                              trailing: _mealStatus[meal]!
                                  ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                                  : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple),
                                onPressed: () =>
                                    _markMealAsCompleted(meal),
                                child: const Text("Done",
                                    style:
                                    TextStyle(color: Colors.white)),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      LinearProgressIndicator(
                        value: _userProgress,
                        minHeight: 10,
                        backgroundColor: Colors.grey[300],
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${(_userProgress * 100).toInt()}% Completed",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 30),
                      _buildGrocerySection(),
                      const SizedBox(height: 20),
                      _buildBudgetSection(),
                    ],
                  ),
              ],
            ),
          ),

          // Popup form overlay
          if (showForm) _buildFormPopup(context),
        ],
      ),
    );
  }

  // 🔹 Action Buttons
  Widget _actionButton(String label, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8E44AD),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }

  // 🛒 Grocery Section
  Widget _buildGrocerySection() {
    return Card(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🛒 Grocery List',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6C3483))),
            const Divider(),
            ...groceryList.map((item) => Text(
              '• $item',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            )),
          ],
        ),
      ),
    );
  }

  // 💰 Budget Section
  Widget _buildBudgetSection() {
    return Card(
      color: Colors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Text('💰 Estimated Budget',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6C3483))),
            const SizedBox(height: 8),
            Text(
              isWeekly
                  ? 'Approx. ₹${estimatedBudget.toStringAsFixed(0)} per week'
                  : 'Approx. ₹${estimatedBudget.toStringAsFixed(0)} per day',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  // 🧾 Form Popup
  Widget _buildFormPopup(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => showForm = false),
      child: Container(
        color: Colors.black.withOpacity(0.3),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            width: MediaQuery.of(context).size.width * 0.42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Card(
              color: Colors.white.withOpacity(0.95),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 10,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: const [
                              Icon(Icons.restaurant_menu_rounded,
                                  color: Color(0xFF8E44AD), size: 40),
                              SizedBox(height: 8),
                              Text('Personalized Meal Plan 🍽️',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF6C3483))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildFormFields(),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: generateMealPlan,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8E44AD),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text('✨ Generate Plan',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
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
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        TextFormField(
          controller: ageController,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('Age'),
          validator: (v) => v!.isEmpty ? 'Enter your age' : null,
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          value: gender,
          decoration: _inputDecoration('Gender'),
          items:
          genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
          onChanged: (val) => setState(() => gender = val),
          validator: (v) => v == null ? 'Select gender' : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: heightController,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('Height (cm)'),
          validator: (v) => v!.isEmpty ? 'Enter height' : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: weightController,
          keyboardType: TextInputType.number,
          decoration: _inputDecoration('Weight (kg)'),
          validator: (v) => v!.isEmpty ? 'Enter weight' : null,
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          value: goal,
          decoration: _inputDecoration('Goal'),
          items:
          goals.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
          onChanged: (val) => setState(() => goal = val),
          validator: (v) => v == null ? 'Select goal' : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: allergiesController,
          decoration: _inputDecoration('Allergies (if any)'),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          value: dietaryPreference,
          decoration: _inputDecoration('Dietary Preference'),
          items: dietaryPreferences
              .map((g) => DropdownMenuItem(value: g, child: Text(g)))
              .toList(),
          onChanged: (val) => setState(() => dietaryPreference = val),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}