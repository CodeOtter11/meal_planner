import 'package:flutter/material.dart';
import 'login_page.dart';
import 'generate_meal_plan_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "AI Meal Planner",
          style: TextStyle(color: Color(0xFF4A148C)),
        ),
        backgroundColor: const Color(0xFFF3E5F5),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF8E44AD)), // For drawer icon
      ),
      drawer: _buildDrawer(context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(constraints.maxWidth < 600 ? 15.0 : 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Generate Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Today's Meal Plan",
                      style: TextStyle(
                        fontSize: constraints.maxWidth < 600 ? 22 : 26,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4A148C),
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
                      child: Text(
                        "Generate Meal Plan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: constraints.maxWidth < 600 ? 14 : 16,
                        ),
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

                // Nutrition Summary
                Container(
                  padding: const EdgeInsets.all(15),
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
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Quick Recommendations
                Container(
                  padding: const EdgeInsets.all(15),
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
                    children: [
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

                const SizedBox(height: 40),

                // Motivation Quote + Notifications
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quote
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
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
                    const SizedBox(width: 10),
                    // Notifications
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
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
          );
        },
      ),
    );
  }

  // ---------------- Drawer ----------------
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFF3E5F5),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF8E44AD)),
              child: Text(
                "AI Meal Planner",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerItem(Icons.home, "Home", () {
              Navigator.pop(context); // Close drawer
            }),
            _buildDrawerItem(Icons.calendar_month, "Meal Plan", () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(Icons.book, "Recipes", () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(Icons.history, "Meal History", () {
              Navigator.pop(context);
            }),
            _buildDrawerItem(Icons.settings, "Settings", () {
              Navigator.pop(context);
            }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black54),
              title: const Text("Logout", style: TextStyle(color: Colors.black54)),
              onTap: () {
                Navigator.pop(context);
                // Add logout logic here
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Drawer Item ----------------
  Widget _buildDrawerItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4A148C)),
      title: Text(label, style: const TextStyle(color: Color(0xFF4A148C))),
      onTap: onTap,
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
          const SizedBox(width: 85), // Placeholder for image space
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
          const SizedBox(width: 60), // Placeholder for image space
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