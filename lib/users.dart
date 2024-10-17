import 'package:flutter/material.dart';
import 'package:collection/collection.dart';  // Import for firstWhereOrNull

class User {
  String username, password;
  double balance;
  int phoneNumber;
  String fullName;
  String? profilePicturePath;  // Add profile picture path
  
  List<List> history = [
    ["Scooter's Coffee", 7.39],
    ["ATM Fee", 2.00],
    ["Transfer from x0855", 73.50],
    ["Share 1000", 70.00],
  ];

  User({
    required this.username, 
    required this.password, 
    required this.balance,
    this.phoneNumber = 123456789,
    this.fullName = "None",
    this.profilePicturePath,
  });
}

class UserProvider extends ChangeNotifier {
  double bonus = 100;
  final List<User> _users = [
    User(username: "name", password: "password", balance: 200)
  ];
  
  User currentUser = User(username: "name", password: "password", balance: 200);

  // Add new user
  void addUser(String name, String password, [int phoneNumber = 123456789, String fullName = "None"]) {
    _users.add(User(username: name, password: password, balance: bonus, phoneNumber: phoneNumber, fullName: fullName));
    notifyListeners();
  }

  // Log in user
  bool logUser(String name, String password) {
    User? user = _users.firstWhereOrNull(
      (element) => element.username == name && element.password == password,
    );
    
    if (user == null) {
      return false;
    } else {
      currentUser = user;
      notifyListeners();
      return true;
    }
  }

  // Get balance for current user
  String getBalance() {
    return "Balance: \$${currentUser.balance.toStringAsFixed(2)}";
  }

  // Record transaction for the current user
  void recordTransaction(String transaction, double amount) {
    currentUser.history.add([transaction, amount]);
    notifyListeners();
  
  }

  // Transfer money to another user
  void transfer(double amount, String username) {
    User? user = _users.firstWhereOrNull(
      (element) => element.username == username,
    );
    
    if (currentUser.balance >= amount) {
      user?.balance += amount;
      currentUser.balance -= amount;
      recordTransaction("Transfer to $username", amount);
      recordTransaction("Received from ${currentUser.username}", amount);
      notifyListeners();
    }
  }

  // Update phone number for current user
  void updatePhoneNumber(int newPhoneNumber) {
    currentUser.phoneNumber = newPhoneNumber;
    notifyListeners();
  }

  // Update profile picture for current user
  void updateProfilePicture(String path) {
    if (currentUser != null) {
      currentUser!.profilePicturePath = path;
      notifyListeners();
    }
  }
}
