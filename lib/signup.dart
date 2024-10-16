import 'package:bank_app/users.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final fullnameController = TextEditingController();
  final phoneController = TextEditingController();

  Color usernameBorderColor = const Color(0xFF005BAA);
  Color passwordBorderColor = const Color(0xFF005BAA);
  Color fullnameBorderColor = const Color(0xFF005BAA);
  Color phoneBorderColor = const Color(0xFF005BAA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F1F9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(height: 40),
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/burgan.jpg'),
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Create a New Account',
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
                hintText: "Email",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: usernameBorderColor,
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
                  color: passwordBorderColor,
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
            const SizedBox(height: 20),
            TextField(
              controller: fullnameController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Full Name",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.person,
                  color: fullnameBorderColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: fullnameBorderColor,
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
              controller: phoneController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Phone Number",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.phone,
                  color: phoneBorderColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: phoneBorderColor,
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
                List<bool> checkList = [
                  usernameController.text.isNotEmpty,
                  passwordController.text.isNotEmpty,
                  fullnameController.text.isNotEmpty,
                  phoneController.text.isNotEmpty
                ];
                setState(() {
                  usernameBorderColor = checkList[0] ? const Color(0xFF005BAA) : Colors.red;
                  passwordBorderColor = checkList[1] ? const Color(0xFF005BAA) : Colors.red;
                  fullnameBorderColor = checkList[2] ? const Color(0xFF005BAA) : Colors.red;
                  phoneBorderColor = checkList[3] ? const Color(0xFF005BAA) : Colors.red;
                });
                if (checkList.every((element) => element)) {
                  Provider.of<UserProvider>(context, listen: false).addUser(
                    usernameController.text,
                    passwordController.text,
                    int.parse(phoneController.text),
                    fullnameController.text,
                  );
                  GoRouter.of(context).pop();
                }
              },
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
