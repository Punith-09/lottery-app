import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  double _balance = 0.0;

  double get balance => _balance;

  void setBalance(double value) {
    _balance = value;
    notifyListeners();
  }

  void addBalance(double amount) {
    _balance += amount;
    notifyListeners();
  }

  void deductBalance(double amount) {
    _balance -= amount;
    notifyListeners();
  }

  void reset() {
    _balance = 0.0;
    notifyListeners();
  }
}
