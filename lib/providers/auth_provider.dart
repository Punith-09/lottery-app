import 'package:flutter/widgets.dart';

import '../services/api_services.dart';

class AuthProvider1 with ChangeNotifier{
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  void setLogin(bool value){
    _isLoggedIn=value;
    notifyListeners();
  }

  Future<void> checkLogin() async {
    await ApiServices.loadCookie();

    if (ApiServices.cookie != null) {
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }

    notifyListeners();
  }
}
