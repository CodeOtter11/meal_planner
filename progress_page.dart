import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2ECF9), // light lavender background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'My Progress 💪',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🟪 WEIGHT TRACKING CARD
            ProgressCard(
              title: 'Weight Tracking',
              child: SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.deepPurple,
                        barWidth: 4,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.deepPurple.shade100,
                        ),
                        spots: const [
                          FlSpot(0, 54),
                          FlSpot(1, 55),
                          FlSpot(2, 56),
                          FlSpot(3, 56.5),
                          FlSpot(4, 57),
                          FlSpot(5, 57.5),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🟣 CALORIES CARD
            ProgressCard(
              title: 'Calories: Consumed vs Recommended 🔥',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: const [
                        Icon(Icons.fastfood, color: Colors.deepPurple, size: 32),
                        SizedBox(height: 8),
                        Text('Consumed',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('1800 kcal', style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                    Column(
                      children: const [
                        Icon(Icons.local_fire_department, color: Colors.orangeAccent, size: 32),
                        SizedBox(height: 8),
                        Text('Recommended',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text('2000 kcal', style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 🧁 NUTRIENT BREAKDOWN CARD
            ProgressCard(
              title: 'Nutrient Breakdown 🍳',
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 10.0,
                        percent: 0.6,
                        center: const Text("Protein\n60%", textAlign: TextAlign.center),
                        progressColor: Colors.blueAccent,
                        backgroundColor: Colors.blue.shade50,
                      ),
                      CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 10.0,
                        percent: 0.8,
                        center: const Text("Carbs\n80%", textAlign: TextAlign.center),
                        progressColor: Colors.orangeAccent,
                        backgroundColor: Colors.orange.shade50,
                      ),
                      CircularPercentIndicator(
                        radius: 50.0,
                        lineWidth: 10.0,
                        percent: 0.5,
                        center: const Text("Fat\n50%", textAlign: TextAlign.center),
                        progressColor: Colors.pinkAccent,
                        backgroundColor: Colors.pink.shade50,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // small divider
                  Divider(color: Colors.grey.shade300, thickness: 1, indent: 20, endIndent: 20),
                  const SizedBox(height: 12),
                  NutritionBox(
                    title: 'Protein',
                    color: Colors.blueAccent,
                    percentage: 0.6,
                    grams: 72,
                  ),
                  NutritionBox(
                    title: 'Carbohydrates',
                    color: Colors.orangeAccent,
                    percentage: 0.8,
                    grams: 200,
                  ),
                  NutritionBox(
                    title: 'Fats',
                    color: Colors.pinkAccent,
                    percentage: 0.5,
                    grams: 45,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 💬 MOTIVATION CARD
            ProgressCard(
              title: 'Motivational Feedback 🌟',
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Column(
                  children: const [
                    Text(
                      '"Awesome! You stayed on track for 5 days straight!"',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Keep pushing — your consistency is inspiring 💜',
                      style: TextStyle(color: Colors.deepPurple),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🟪 Common Card Widget for all sections
class ProgressCard extends StatelessWidget {
  final String title;
  final Widget child;

  const ProgressCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

// 🍫 Nutrition Info Box Widget
class NutritionBox extends StatelessWidget {
  final String title;
  final double percentage;
  final int grams;
  final Color color;

  const NutritionBox({
    super.key,
    required this.title,
    required this.percentage,
    required this.grams,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
          ),
          Text('$grams g', style: TextStyle(color: Colors.grey[700])),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey.shade300,
              color: color,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}