import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _userid="";
  String _username = "";
  String _email = "";
  String _role = "";
  bool _isLoggedIn = false; // ✅ ADD THIS

  // ✅ Getters
  String get userid =>_userid;
  String get username => _username;
  String get email => _email;
  String get role => _role;
  bool get isLoggedIn => _isLoggedIn;

  // ✅ LOGIN
  void login({required String userid,required String username, required String email,required String role,}) {
    _userid = userid;
    _username = username;
    _email = email;
    _role= role;
    _isLoggedIn = true; // ✅ SET TRUE
    notifyListeners();
  }

  // ✅ LOGOUT
  void logout() {
    _userid = "";
    _username = "";
    _email = "";
    _role = "";
    _isLoggedIn = false; // ✅ RESET
    notifyListeners();
  }
}
