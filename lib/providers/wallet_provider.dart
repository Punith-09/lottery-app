import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier{
  double _balance =0.0;
  double get balance => _balance;
  void setBalance(double newBalance){
    _balance=newBalance;
    notifyListeners();
  }
  void addFunds(double amount){
    _balance+=amount;
    notifyListeners();
  }
}