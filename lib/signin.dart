import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'users.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Color usernameBorderColor = const Color(0xFF005BAA); // Matching Burgan Bank blue
  Color passwordBorderColor = const Color(0xFF005BAA); // Matching Burgan Bank blue

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F1F9), 
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            const SizedBox(height: 40), 
            const Center(
              child: CircleAvatar(
                radius: 60, 
                backgroundImage: AssetImage('assets/images/burgan.jpg'), 
                backgroundColor: Colors.transparent, 
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Burgan Bank',
              style: TextStyle(
                color: Color(0xFF005BAA), 
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: usernameController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Username / Email",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: usernameBorderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFF005BAA), 
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Password",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: passwordBorderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFF005BAA), 
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF005BAA), 
                padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (Provider.of<UserProvider>(context, listen: false)
                    .logUser(usernameController.text, passwordController.text)) {
                  usernameController.clear();
                  passwordController.clear();
                  GoRouter.of(context).go('/dashboard');
                } else {
                  showError(context, "Email and/or Password is wrong");
                }
              },
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                GoRouter.of(context).push('/signed_up');
              },
              child: const Text(
                "Don't have an account? Sign Up",
                style: TextStyle(color: Color(0xFF005BAA)), // Burgan Bank Blue
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(message),
    ),
  );
}
