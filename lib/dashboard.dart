//import 'package:bank_app/main.dart';
import 'package:bank_app/users.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);
    
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              provider.getBalance(),
              style: const TextStyle(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.deepPurpleAccent),
                  ),
                  onPressed: () {
                    GoRouter.of(context).push('/transfer', extra: "deposit");
                  }, 
                  child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Deposit", style: TextStyle(color: Colors.white),),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.deepPurpleAccent),
                  ),
                  onPressed: () {
                    GoRouter.of(context).push('/transfer', extra: "withdraw");
                  }, 
                  child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Withdraw", style: TextStyle(color: Colors.white),),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.deepPurpleAccent),
                  ),
                  onPressed: () {
                    GoRouter.of(context).push('/transfer', extra: "transfer");
                  }, 
                  child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Transfer", style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            ),
            FloatingActionButton(
              elevation: 12,
              onPressed: () {
                GoRouter.of(context).go('/');
              },
              child: const Text("Sign out"),
            )
          ],
        ),
      ),
    );
  }
}