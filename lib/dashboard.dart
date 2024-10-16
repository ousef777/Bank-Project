import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Balance: \$100.0",
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.deepPurpleAccent),
              ),
              onPressed: () {
                GoRouter.of(context).push('/profile');
              }, 
              child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Profile", style: TextStyle(color: Colors.white),),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all<Color>(Colors.deepPurpleAccent),
              ),
              onPressed: () {
                GoRouter.of(context).push('/transfer');
              }, 
              child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Transfer", style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }
}