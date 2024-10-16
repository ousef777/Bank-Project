import 'package:flutter/material.dart';

class User {
  String username, password;
  double balance;
  int phoneNumber = 123456789;
  String fullName = "None";
  
  List<List> history = [];

  User({
    required this.username, 
    required this.password, 
    required this.balance
  });
}

class UserProvider extends ChangeNotifier {
  double bonus = 100;
  final List<User> _users = [
    User(username: "name", password: "password", balance: 200)
  ];
  
  User? currentUser; //= User(name: "name", password: "unknown", balance: 0.0);

  void addUser(String name, String password, [int phoneNumber = 123456789, String fullName = "None"]) {
    _users.add(User(username: name, password: password, balance: bonus));
    _users.last.phoneNumber = phoneNumber;
    _users.last.fullName = fullName;
  }

  bool logUser(String name, String password) {
    User user = _users.firstWhere((element) => element.username == name, orElse: () => User(username: "unknown", password: "unknown", balance: bonus));
    
    if (user.username == "unknown" || user.password != password) {
      return false;
    } else {
      currentUser = user;
      notifyListeners();
      return true;
    }
  }

  String getBalance() {
    return "Balance: \$${currentUser?.balance}";
  }

  void recordTransaction(String transaction, double amount) {
    currentUser?.history.add([transaction, amount]);
  }

  void transfer(double amount, String username) {
    User user = _users.firstWhere((element) => element.username == username, orElse: () => User(username: "unknown", password: "unknown", balance: bonus));
    user.balance += amount;
  }
}
