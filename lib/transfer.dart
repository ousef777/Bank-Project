import 'package:flutter/material.dart';

class Transfer extends StatelessWidget {
  const Transfer({super.key});

  final bool appear = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Transfer"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.0),
              child: TextField(
                //controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Transfer Amount",
                  prefixIcon: const Icon(
                    Icons.attach_money,
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
            ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(Colors.deepPurpleAccent),
            ),
            onPressed: () {
              //GoRouter.of(context).push('/transfer');
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