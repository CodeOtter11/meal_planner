import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MealPlannerApp());
}

class MealPlannerApp extends StatelessWidget {
  const MealPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Meal Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF8E44AD),
        scaffoldBackgroundColor: const Color(0xFF1E1E2A),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2C2C3A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          hintStyle: const TextStyle(color: Colors.white54),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
