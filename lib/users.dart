import 'package:flutter/material.dart';
import 'package:collection/collection.dart';  

class User {
  String username, password;
  double balance;
  int phoneNumber;
  String fullName;
  
  List<List> history = [];

  User({
    required this.username, 
    required this.password, 
    required this.balance,
    this.phoneNumber = 123456789,
    this.fullName = "None",
  });
}

class UserProvider extends ChangeNotifier {
  double bonus = 100;
  final List<User> _users = [
    User(username: "name", password: "password", balance: 200)
  ];
  
  User? currentUser;


  void addUser(String name, String password, [int phoneNumber = 123456789, String fullName = "None"]) {
    _users.add(User(username: name, password: password, balance: bonus, phoneNumber: phoneNumber, fullName: fullName));
    notifyListeners();
  }


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

 
  String getBalance() {
    return "Balance: \$${currentUser?.balance.toStringAsFixed(2) ?? "0.00"}";
  }


  void recordTransaction(String transaction, double amount) {
    if (currentUser != null) {
      currentUser?.history.add([transaction, amount]);
      notifyListeners();
    }
  }


  void transfer(double amount, String username) {
    User? user = _users.firstWhereOrNull(
      (element) => element.username == username,
    );
    
    if (user != null && currentUser != null && currentUser!.balance >= amount) {
      user.balance += amount;
      currentUser!.balance -= amount;
      recordTransaction("Transfer to $username", amount);
      recordTransaction("Received from ${currentUser!.username}", amount);
      notifyListeners();
    }
  }

  // Update phone number for current user
  void updatePhoneNumber(int newPhoneNumber) {
    if (currentUser != null) {
      currentUser!.phoneNumber = newPhoneNumber;
      notifyListeners();
    }
  }
}
