import 'dart:io';
import 'package:bank_app/users.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);
    String? profilePicturePath = provider.currentUser.profilePicturePath;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFF005BAA),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _changeProfilePicture(context, provider);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200.0),
                  child: profilePicturePath != null && File(profilePicturePath).existsSync()
                      ? Image.file(
                          File(profilePicturePath),
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        )
                      : const Image(
                          image: AssetImage("assets/images/profile.jpg"), // Default image
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Tap to change profile picture",
                style: TextStyle(color: Colors.black54),
              ),
              Container(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Full Name: ${provider.currentUser.fullName}",
                        style: const TextStyle(fontSize: 28.0)),
                    Text("Phone Number: ${provider.currentUser.phoneNumber}",
                        style: const TextStyle(fontSize: 28.0)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF005BAA),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _editPhoneNumber(context, provider);
                      },
                      child: const Text(
                        "Edit Phone Number",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _editPhoneNumber(BuildContext context, UserProvider provider) {
    final phoneController = TextEditingController(text: provider.currentUser.phoneNumber.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Phone Number"),
          content: TextField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: "Phone Number",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                provider.updatePhoneNumber(int.parse(phoneController.text));
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _changeProfilePicture(BuildContext context, UserProvider provider) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      provider.updateProfilePicture(image.path);
    }
  }
}
