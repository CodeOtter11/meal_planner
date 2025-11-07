import 'dart:convert';
import 'package:http/http.dart' as http;

class MealPlanGeneratorService {
  static const String _apiKey = "AIzaSyC7CRcPq6Tl8kDzDB9cZyuQXtNCaGuqhxw"; // Your Gemini API key

  Future<String> generateMealPlan(String prompt) async {
    final uri = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions"
    );

    final response = await http.post(
      uri,
      headers: {
        "Authorization": "Bearer $_apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gemini-2.5-flash",
        "messages": [
          {
            "role": "system",
            "content":
            "You are an expert nutritionist and meal planner. Create meal plans that are healthy, balanced, and personalized based on the user's preferences."
          },
          {
            "role": "user",
            "content": prompt
          }
        ],
        "reasoning_effort": "medium"

      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Gemini AI Error: ${response.statusCode} ${response.body}");
    }

    final data = jsonDecode(response.body);

    // Extract AI message text safely
    try {
      return data["choices"][0]["message"]["content"];
    } catch (e) {
      return "Error parsing Gemini response: $e";
    }
  }
}
