import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _username = "";
  String _email = "";
  bool _isLoggedIn = false; // ✅ ADD THIS

  // ✅ Getters
  String get username => _username;
  String get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  // ✅ LOGIN
  void login({required String username, required String email}) {
    _username = username;
    _email = email;
    _isLoggedIn = true; // ✅ SET TRUE
    notifyListeners();
  }

  // ✅ LOGOUT
  void logout() {
    _username = "";
    _email = "";
    _isLoggedIn = false; // ✅ RESET
    notifyListeners();
  }
}
