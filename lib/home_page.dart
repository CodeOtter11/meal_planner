import 'package:flutter/material.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      appBar: AppBar(
        title: const Text("AI Meal Planner"),
        backgroundColor: const Color(0xFF8E44AD), // minimal purple
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5), // light purple card
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "Welcome to your AI Meal Planner!\nPlan your meals, track your nutrition, and stay healthy",
                style: TextStyle(
                  color: Color(0xFF4A148C), // dark purple text
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Quick Actions Section
            Row(
              children: [
                _buildCard(
                  title: "Generate Meal Plan",
                  icon: Icons.restaurant_menu,
                  color: const Color(0xFFE1BEE7), // light purple
                  textColor: const Color(0xFF6A1B9A),
                  onTap: () {},
                ),
                const SizedBox(width: 10),
                _buildCard(
                  title: "Track Calories",
                  icon: Icons.local_fire_department,
                  color: const Color(0xFFE1BEE7),
                  textColor: const Color(0xFF6A1B9A),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildCard(
                  title: "View Recipes",
                  icon: Icons.book,
                  color: const Color(0xFFE1BEE7),
                  textColor: const Color(0xFF6A1B9A),
                  onTap: () {},
                ),
                const SizedBox(width: 10),
                _buildCard(
                  title: "Nutrition Tips",
                  icon: Icons.health_and_safety,
                  color: const Color(0xFFE1BEE7),
                  textColor: const Color(0xFF6A1B9A),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Recent Meal Plans Section
            const Text(
              "Your Recent Meal Plans",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C)), // dark purple
            ),
            const SizedBox(height: 10),
            _buildMealPlanCard(
                "Weekly Keto Plan", "7-day keto meal plan for weight loss"),
            _buildMealPlanCard(
                "Vegetarian Plan", "Balanced vegetarian meals for the week"),
            _buildMealPlanCard(
                "High Protein Plan", "Muscle building meal plan"),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Icon(icon, color: textColor, size: 36),
              const SizedBox(height: 10),
              Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: textColor, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealPlanCard(String title, String description) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5), // light purple background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A))), // dark purple
          const SizedBox(height: 5),
          Text(description, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
