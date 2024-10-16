import 'package:bank_app/users.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Transfer extends StatelessWidget {
  Transfer({super.key});

  final bool appear = false;
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transfer"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (appear) const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.0),
              child: TextField(
                //controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Destination",
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  hintText: "Transfer Amount",
                  prefixIcon: Icon(
                    Icons.attach_money,
                    color: Colors.blue,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(Colors.deepPurpleAccent),
            ),
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false).currentUser?.balance += double.parse(amountController.text);
              GoRouter.of(context).pop();
            }, 
            child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Submit", style: TextStyle(color: Colors.white),),
            ),
          )
          ],
        ),
      ),
    );
  }
}