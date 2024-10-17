import 'package:bank_app/users.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Transfer extends StatelessWidget {
  final String condition;
  Transfer({super.key, required this.condition});
  final destinationController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Transfer"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (condition == "transfer") Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: TextField(
                controller: destinationController,
                decoration: const InputDecoration(
                  hintText: "IBAN",
                  prefixIcon: Icon(
                    Icons.person,
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
              double mod = (condition == "deposit") ? 1 : -1;
              provider.currentUser.balance += (double.parse(amountController.text) * mod);
              provider.recordTransaction(condition, double.parse(amountController.text));

              if (condition == "transfer") {
                provider.transfer(double.parse(amountController.text), destinationController.text);
              }
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