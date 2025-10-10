import 'package:flutter/material.dart';
import 'meal_plan_generator_page.dart';

class MealInputPage extends StatefulWidget {
  const MealInputPage({super.key});

  @override
  State<MealInputPage> createState() => _MealInputPageState();
}

class _MealInputPageState extends State<MealInputPage> {
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final allergyController = TextEditingController();
  String selectedGender = "Male";
  String selectedGoal = "Maintain Weight";

  void generateMealPlan() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MealPlanGeneratorPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Enter Your Details",
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInput("Age", ageController, TextInputType.number),
              _buildDropdown("Gender", ["Male", "Female"], (val) {
                setState(() => selectedGender = val!);
              }, selectedGender),
              _buildInput("Weight (kg)", weightController, TextInputType.number),
              _buildInput("Height (cm)", heightController, TextInputType.number),
              _buildDropdown(
                "Goal",
                ["Lose Weight", "Maintain Weight", "Gain Weight"],
                    (val) => setState(() => selectedGoal = val!),
                selectedGoal,
              ),
              _buildInput("Allergies (if any)", allergyController, TextInputType.text),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: generateMealPlan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E44AD),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Generate Meal Plan",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller, TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF8E44AD)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF8E44AD)),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items,
      ValueChanged<String?> onChanged, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF8E44AD)),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            onChanged: onChanged,
            items: items
                .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
