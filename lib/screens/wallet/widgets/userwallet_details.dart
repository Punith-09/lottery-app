import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottery_app/providers/auth_provider.dart';
import 'package:lottery_app/screens/drawer/login_required_dialog.dart';
import 'package:lottery_app/services/razorpay_service.dart';
import 'package:provider/provider.dart';
import 'package:lottery_app/providers/wallet_provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../providers/login_provider.dart';

class UserwalletDetails extends StatefulWidget {
  const UserwalletDetails({super.key});

  @override
  State<UserwalletDetails> createState() => _UserwalletDetailsState();
}

class _UserwalletDetailsState extends State<UserwalletDetails> {
  final TextEditingController amountController = TextEditingController();
  late final authProvider = Provider.of<AuthProvider>(context, listen: false);

  late RazorpayService razorpayService;
  @override
  void initState() {
    super.initState();
    razorpayService = RazorpayService();
    razorpayService.init(
      onSuccess: _handlePaymentSuccess,
      onFailure: _handlePaymentFailure,
      onExternalWallet: _handleExternalWallet,
    );
  }
  // ✅ PAYMENT SUCCESS
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final wallet = context.read<WalletProvider>();
    double amount = double.tryParse(amountController.text) ?? 0;
    wallet.addBalance(amount);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Successful ✅")),
    );
  }
  // ✅ PAYMENT FAILURE
  void _handlePaymentFailure(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Failed ❌")),
    );
  }
  // ✅ EXTERNAL WALLET
  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("External Wallet: ${response.walletName}");
  }
  @override
  void dispose() {
    razorpayService.dispose();
    amountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final wallet = context.watch<WalletProvider>();
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: const Color(0xFF0D1915),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color(0xFF1F3D32)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/wallet.svg",
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF069B6C),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Total Balance",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // 💰 BALANCE
              Text(
                "₹${wallet.balance.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Color(0xFFFBC600),
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                         if (!authProvider.isLoggedIn) {
                           showLoginRequiredDialog(context);
                         }else {
                           _showAddMoneyBottomSheet(context);
                         }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00BB7C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(15),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Add\nFunds",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final isLoggedIn = context.read<AuthProvider1>().isLoggedIn;

                        print("ADD FUNDS LOGIN STATUS: $isLoggedIn");

                        if (!isLoggedIn) {
                          showLoginRequiredDialog(context);
                          return;
                        }

                        _showAddMoneyBottomSheet(context);
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1C2B26),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/credit-card.svg",
                            width: 16,
                            height: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Withdraw",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        const SizedBox(height: 26),
        _buildStatCard("Total won", "₹2,500.00", "assets/trending-up.svg", const Color(0xFF00D391)),
        const SizedBox(height: 26),
        _buildStatCard("Credits Used", "3,450", "assets/credit-card.svg", const Color(0xFFFBC600)),
      ],
    );
  }


  void _showAddMoneyBottomSheet(BuildContext context) {
    final isLoggedIn = context.read<AuthProvider1>().isLoggedIn;

    if (!isLoggedIn) {
      showLoginRequiredDialog(context);
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0D1915),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Add Money to Wallet",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "₹ Enter amount",
                  filled: true,
                  fillColor: const Color(0xFF1C2B26),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  String amountText = amountController.text.trim();

                  if (amountText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Enter amount")),
                    );
                    return;
                  }

                  double amount = double.tryParse(amountText) ?? 0;

                  if (amount < 50) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Minimum ₹50 required")),
                    );
                    return;
                  }

                  Navigator.pop(context);

                  // 🚀 OPEN RAZORPAY
                  razorpayService.openCheckout(amount);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BB7C),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Proceed to Pay"),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String title, String value, String icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1915),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF1F3D32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(icon, width: 16, height: 16, color: color),
              const SizedBox(width: 10),
              Text(title, style: TextStyle(color: color, fontSize: 16)),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
