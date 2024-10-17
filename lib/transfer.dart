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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transfer"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Select amount to transfer into your wallet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            _buildAmountInput(),
            const SizedBox(height: 24),

            if (condition == "transfer") _buildIBANInputField(),
            const Spacer(),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }


  Widget _buildAmountInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.blue),
            onPressed: () {
              double currentAmount = double.tryParse(amountController.text) ?? 0;
              currentAmount = currentAmount > 0 ? currentAmount - 50 : 0;
              amountController.text = currentAmount.toStringAsFixed(2);
            },
          ),
          Expanded(
            child: Center(
              child: TextField(
                controller: amountController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '0.00 KD',
                  hintStyle: TextStyle(fontSize: 24),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blue),
            onPressed: () {
              double currentAmount = double.tryParse(amountController.text) ?? 0;
              currentAmount += 10;
              amountController.text = currentAmount.toStringAsFixed(2);
            },
          ),
        ],
      ),
    );
  }

  // IBAN Input Field
  Widget _buildIBANInputField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextField(
        controller: destinationController,
        decoration: InputDecoration(
          labelText: "Enter IBAN",
          prefixIcon: const Icon(Icons.credit_card, color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  // Submit Button
  Widget _buildSubmitButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          double mod = (condition == "deposit") ? 1 : -1;
          Provider.of<UserProvider>(context, listen: false)
              .currentUser
              ?.balance += (double.parse(amountController.text) * mod);
          if (condition == "transfer") {
            Provider.of<UserProvider>(context, listen: false).transfer(
                double.parse(amountController.text), destinationController.text);
          }
          GoRouter.of(context).pop();
        },
        child: const Text(
          "Continue",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
