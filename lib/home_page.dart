import 'package:flutter/material.dart';
import 'login_page.dart';
import 'generate_meal_plan_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // ---------------- Sidebar ----------------
          Container(
            width: 220,
            color: const Color(0xFFF3E5F5), // soft pastel purple
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: const [
                      Icon(Icons.restaurant_menu, color: Color(0xFF8E44AD), size: 28),
                      SizedBox(width: 10),
                      Text(
                        "AI Meal Planner",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A148C),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                _buildSidebarItem(Icons.home, "Home", true),
                _buildSidebarItem(Icons.calendar_month, "Meal Plan", false),
                _buildSidebarItem(Icons.book, "Recipes", false),
                _buildSidebarItem(Icons.history, "Meal History", false),
                _buildSidebarItem(Icons.settings, "Settings", false),
                const Spacer(),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    children: const [
                      Icon(Icons.logout, color: Colors.black54),
                      SizedBox(width: 10),
                      Text("Logout", style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ---------------- Main Content ----------------
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with Generate Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Today's Meal Plan",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A148C),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GenerateMealPlanPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8E44AD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Generate Meal Plan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Meal Cards
                  _buildMealCard(
                    title: 'Breakfast: Overnight Oats with Berries',
                    description: 'A nutritious start with mixed berries and chia seeds.',
                    calories: '350 kcal',
                    logged: true,
                  ),
                  _buildMealCard(
                    title: 'Lunch: Grilled Chicken Salad',
                    description: 'Fresh greens, grilled chicken breast, and vinaigrette.',
                    calories: '420 kcal',
                    logged: true,
                  ),
                  _buildMealCard(
                    title: 'Dinner: Salmon with Roasted Vegetables',
                    description: 'Baked salmon fillet with asparagus and sweet potato.',
                    calories: '580 kcal',
                    logged: false,
                  ),
                  _buildMealCard(
                    title: 'Snacks: Apple Slices with Almond Butter',
                    description: 'Quick and healthy energy boost.',
                    calories: '180 kcal',
                    logged: false,
                  ),

                  const SizedBox(height: 40),

                  // Motivation Quote + Notifications
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quote
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F5FA),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            '"The journey to a healthier you begins with one simple step: a conscious choice."',
                            style: TextStyle(
                              color: Color(0xFF4A148C),
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Notifications
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F5FA),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Notifications & Reminders",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4A148C),
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              ListTile(
                                leading: Icon(Icons.notifications_none),
                                title: Text("Reminder: Log your dinner meal"),
                                subtitle: Text("5:30 PM"),
                              ),
                              ListTile(
                                leading: Icon(Icons.emoji_events_outlined),
                                title: Text("Achievement! Hit protein goal"),
                                subtitle: Text("8:00 AM"),
                              ),
                              ListTile(
                                leading: Icon(Icons.alarm),
                                title: Text("Snack time reminder"),
                                subtitle: Text("3:00 PM"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ---------------- Right Panel ----------------
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nutrition Summary",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildNutritionBar("Calories", 1530, 2000, Colors.orange),
                  _buildNutritionBar("Protein", 85, 120, Colors.purple),
                  _buildNutritionBar("Carbs", 150, 250, Colors.teal),
                  _buildNutritionBar("Fats", 60, 70, Colors.pink),
                  const SizedBox(height: 40),
                  const Text(
                    "Quick Recommendations",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildRecommendation("Winter Vegetable Soup", "Warm & Comforting"),
                  _buildRecommendation("Berry Smoothie", "Refreshing & Light"),
                  _buildRecommendation("Hearty Lentil Stew", "High in Fiber"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Sidebar Item ----------------
  static Widget _buildSidebarItem(IconData icon, String label, bool active) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        children: [
          Icon(icon, color: active ? Color(0xFF8E44AD) : Colors.black54),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: active ? Color(0xFF8E44AD) : Colors.black87,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Meal Card ----------------
  Widget _buildMealCard({
    required String title,
    required String description,
    required String calories,
    required bool logged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F5FA),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 85), // Placeholder for where the image was
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A148C))),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(color: Colors.black87)),
                const SizedBox(height: 4),
                Text(calories, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: logged ? Colors.green : const Color(0xFF8E44AD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(logged ? "Logged" : "Log Meal"),
          ),
        ],
      ),
    );
  }

  // ---------------- Nutrition Bar ----------------
  Widget _buildNutritionBar(String label, int current, int goal, Color color) {
    double progress = current / goal;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label: $current / $goal", style: const TextStyle(color: Colors.black87)),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            value: progress,
            color: color,
            backgroundColor: Colors.grey.shade300,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  // ---------------- Recommendation ----------------
  Widget _buildRecommendation(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const SizedBox(width: 60), // Placeholder for where the image was
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A148C))),
                Text(subtitle, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}