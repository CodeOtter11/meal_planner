import 'dart:convert';

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool agreedToTerms = false;

  void signup() async {
    if (!agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must agree to Terms & Conditions')));
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', firstNameController.text);
    await prefs.setString('lastName', lastNameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);

    var response = await http.post(
      Uri.parse("http://localhost:3000/signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "firstName" : firstNameController.value.toString(),
            "lastName" : lastNameController.value.toString(),
            "email" : emailController.value.toString(),
            "password" : passwordController.value.toString(),
          }
        )
      );
    print(response.statusCode.toString());

    // Redirect to login page
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width > 800)
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/signup_bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: const Center(
                    child: Text(
                      "Plan Smart, Eat Better",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            flex: 1,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Create an Account",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Join us to create your personalized meal plan",
                      style: TextStyle(color: Colors.white54),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: firstNameController,
                            decoration:
                            const InputDecoration(hintText: "First Name"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: lastNameController,
                            decoration:
                            const InputDecoration(hintText: "Last Name"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(hintText: "Email"),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon:
                        Icon(Icons.visibility_off, color: Colors.white54),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: agreedToTerms,
                          onChanged: (value) {
                            setState(() {
                              agreedToTerms = value ?? false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text(
                            "I agree to the Terms & Conditions",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: signup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8E44AD),
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Create Account",
                          style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginPage()),
                          ),
                          child: const Text("Log In",
                              style: TextStyle(color: Color(0xFF8E44AD))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
