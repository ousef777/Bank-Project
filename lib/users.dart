import 'package:flutter/material.dart';

class User {
  String username, password;
  double balance;
  int phoneNumber = 123456789;
  String fullName = "None";

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
    notifyListeners();
    return "Balance: \$${currentUser?.balance}";
  }
}
