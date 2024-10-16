//import 'package:bank_app/dashboard.dart';
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

  Color emailBorderColor = Colors.deepPurpleAccent;
  Color passwordBorderColor = Colors.deepPurpleAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Username",
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: emailBorderColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: emailBorderColor,
                  ),
                ),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,   //hide the text
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(
                  Icons.key,
                  color: passwordBorderColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: passwordBorderColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: createTextField("Full Name", fullnameController, passwordBorderColor)
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: createTextField("Phone Number", phoneController, passwordBorderColor)
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(Colors.deepPurpleAccent),
            ),
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).addUser(usernameController.text, passwordController.text, int.parse(phoneController.text), fullnameController.text);
              GoRouter.of(context).pop();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Submit", style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 5),
      content: Text(message),
    )
  );
}

TextField createTextField(String hintText, TextEditingController controller, Color borderColor) {
  return TextField(
              controller: controller,  //hide the text
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Icon(
                  Icons.key,
                  color: borderColor,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            );
}