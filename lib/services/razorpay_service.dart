import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;

  void init({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
    required Function(ExternalWalletResponse) onExternalWallet,
  }) {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onExternalWallet);
  }

  void openCheckout(double amount) {
    var options = {
      'key': 'rzp_test_SRrKIfsKje5uNq',
      'amount': (amount * 100).toInt(), // convert to paise
      'name': 'Lottery App',
      'description': 'Add Money to Wallet',
      'prefill': {
        'contact': '9999999999',
        'email': 'test@razorpay.com'
      },
      'theme': {
        'color': '#00BB7C'
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Razorpay Error: $e");
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}
