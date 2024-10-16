import 'package:bank_app/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);
    
    return Scaffold(
        appBar: AppBar(title: const Text("Profile"),),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200.0),
                  child: const Image(image: AssetImage("images/profile.jpg"), width: 300, height: 300, fit: BoxFit.cover)
                ),
                Container(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Full Name: ${provider.currentUser?.fullName}", style: TextStyle(fontSize: 28.0)),
                      Text("PhoneNumber: ${provider.currentUser?.phoneNumber}", style: TextStyle(fontSize: 28.0)),
                      //Text("Gender: Male", style: TextStyle(fontSize: 28.0)),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      );
  }
}