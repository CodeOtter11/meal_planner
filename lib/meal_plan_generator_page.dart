import 'package:flutter/material.dart';

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

  // 🔹 Sample meal plan for testing
  void generateMealPlan() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        mealPlanResult = '''
🍳 **Breakfast:**
• Oats with milk, banana, and almonds  
• 1 boiled egg or tofu  

🥗 **Lunch:**
• Brown rice with dal and sautéed vegetables  
• Grilled paneer/chicken (optional)  

🍝 **Dinner:**
• Mixed vegetable soup  
• 2 chapatis or quinoa bowl  

🍎 **Snacks:**
• Handful of nuts  
• Green tea or fruit smoothie  
''';
        showForm = false;
      });
    }
  }

  // 🎨 Input field design — now with dark text
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
      backgroundColor: const Color(0xFFF3E5F5), // Light purple background
      appBar: AppBar(
        backgroundColor: const Color(0xFF8E44AD), // Purple app bar
        title: const Text('AI Meal Planner',
            style: TextStyle(fontWeight: FontWeight.w600)),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
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

          // 🔹 Popup form overlay
          if (showForm)
            GestureDetector(
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
                        colors: [
                          Color(0xFFF3E5F5),
                          Color(0xFFE1BEE7)
                        ], // Light purple tones
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 24),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Column(
                                    children: const [
                                      Icon(Icons.restaurant_menu_rounded,
                                          color: Color(0xFF8E44AD), size: 40),
                                      SizedBox(height: 8),
                                      Text(
                                        'Personalized Meal Plan 🍽️',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF6C3483),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24),

                                // AGE FIELD
                                TextFormField(
                                  controller: ageController,
                                  keyboardType: TextInputType.number,
                                  style:
                                  const TextStyle(color: Colors.black87),
                                  decoration: _inputDecoration('Age'),
                                  validator: (v) =>
                                  v!.isEmpty ? 'Enter your age' : null,
                                ),
                                const SizedBox(height: 14),

                                // GENDER
                                DropdownButtonFormField<String>(
                                  value: gender,
                                  decoration: _inputDecoration('Gender'),
                                  items: genders
                                      .map((g) => DropdownMenuItem(
                                      value: g, child: Text(g)))
                                      .toList(),
                                  onChanged: (val) => setState(() => gender = val),
                                  validator: (v) =>
                                  v == null ? 'Select gender' : null,
                                ),
                                const SizedBox(height: 14),

                                // HEIGHT
                                TextFormField(
                                  controller: heightController,
                                  keyboardType: TextInputType.number,
                                  style:
                                  const TextStyle(color: Colors.black87),
                                  decoration: _inputDecoration('Height (cm)'),
                                  validator: (v) =>
                                  v!.isEmpty ? 'Enter height' : null,
                                ),
                                const SizedBox(height: 14),

                                // WEIGHT
                                TextFormField(
                                  controller: weightController,
                                  keyboardType: TextInputType.number,
                                  style:
                                  const TextStyle(color: Colors.black87),
                                  decoration: _inputDecoration('Weight (kg)'),
                                  validator: (v) =>
                                  v!.isEmpty ? 'Enter weight' : null,
                                ),
                                const SizedBox(height: 14),

                                // GOAL
                                DropdownButtonFormField<String>(
                                  value: goal,
                                  decoration: _inputDecoration('Goal'),
                                  items: goals
                                      .map((g) => DropdownMenuItem(
                                      value: g, child: Text(g)))
                                      .toList(),
                                  onChanged: (val) => setState(() => goal = val),
                                  validator: (v) =>
                                  v == null ? 'Select goal' : null,
                                ),
                                const SizedBox(height: 14),

                                // ALLERGIES
                                TextFormField(
                                  controller: allergiesController,
                                  style:
                                  const TextStyle(color: Colors.black87),
                                  decoration:
                                  _inputDecoration('Allergies (if any)'),
                                ),
                                const SizedBox(height: 14),

                                // DIETARY PREFERENCE
                                DropdownButtonFormField<String>(
                                  value: dietaryPreference,
                                  decoration:
                                  _inputDecoration('Dietary Preference'),
                                  items: dietaryPreferences
                                      .map((g) => DropdownMenuItem(
                                      value: g, child: Text(g)))
                                      .toList(),
                                  onChanged: (val) => setState(
                                          () => dietaryPreference = val),
                                ),
                                const SizedBox(height: 24),

                                // BUTTON
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: generateMealPlan,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xFF8E44AD),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(25),
                                      ),
                                      elevation: 8,
                                    ),
                                    child: const Text(
                                      '✨ Generate Plan',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
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
