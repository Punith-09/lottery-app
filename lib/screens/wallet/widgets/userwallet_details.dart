import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart'; // Add this
import 'package:lottery_app/providers/wallet_provider.dart'; // Add your path

class UserwalletDetails extends StatelessWidget {
  const UserwalletDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // 📻 Listen to the WalletProvider
    final wallet = context.watch<WalletProvider>();

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
              color: const Color(0xFF0D1915),
              borderRadius: BorderRadius.circular(15), // Fixed BorderRadius
              border: Border.all(color: const Color(0xFF1F3D32))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/wallet.svg",
                    width: 16, height: 16,
                    colorFilter: const ColorFilter.mode(Color(0xFF069B6C), BlendMode.srcIn),
                  ),
                  const SizedBox(width: 10),
                  const Text("Total Balance", style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 10),

              // 💰 DYNAMIC BALANCE
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
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Color(0xFF0D1915),
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

                                    Text(
                                      "Add Money to Wallet",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    const SizedBox(height: 20),
                                    Text(
                                      "Amount (Min ₹50)",
                                      textAlign: TextAlign.start,
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "₹ Enter amount",
                                        filled: true,
                                        fillColor: Color(0xFF1C2B26),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF00BB7C),
                                        minimumSize: Size(double.infinity, 50),
                                      ),
                                      child: Text("Proceed to Pay"),
                                    ),

                                    const SizedBox(height: 20),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BB7C),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(15)),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.black),
                          SizedBox(width: 10),
                          Text("Add\nFunds", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1C2B26),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/credit-card.svg", width: 16, height: 16, color: Colors.white),
                          const SizedBox(width: 8),
                          const Text("Withdraw", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        // You can also add "Total Won" to your Provider later to make this dynamic too!
        const SizedBox(height: 26),
        _buildStatCard("Total won", "₹2,500.00", "assets/trending-up.svg", const Color(0xFF00D391)),
        const SizedBox(height: 26),
        _buildStatCard("Credits Used", "3,450", "assets/credit-card.svg", const Color(0xFFFBC600)),
      ],
    );
  }

  // Helper to keep code clean
  Widget _buildStatCard(String title, String value, String icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xFF0D1915),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFF1F3D32))),
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
          Text(value, style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showAddFundsDialog(BuildContext context) {
    // This is where you would integrate Razorpay
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Funds"),
        content: const Text("Integration with Razorpay goes here."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))
        ],
      ),
    );
  }
}