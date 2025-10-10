import 'package:flutter/material.dart';

class MealPlanGeneratorPage extends StatelessWidget {
  const MealPlanGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AI Meal Plan Generator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF8E44AD),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(
        child: Text(
          "Your personalized AI meal plan will appear here 🍎",
          style: TextStyle(fontSize: 18, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
