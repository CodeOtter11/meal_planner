import 'package:flutter/material.dart';

class GenerateMealPlanPage extends StatelessWidget {
  const GenerateMealPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Generate Meal Plan", style: TextStyle(color: Color(0xFF4A148C))),
        backgroundColor: const Color(0xFFF3E5F5),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Generating your personalized meal plan...",
              style: TextStyle(fontSize: 20, color: Color(0xFF4A148C)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            CircularProgressIndicator(color: Color(0xFF8E44AD)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Back to HomePage
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E44AD),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Back", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}