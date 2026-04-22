import 'package:flutter/material.dart';
import 'package:lottery_app/screens/drawer/app_footer.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import 'package:lottery_app/screens/wallet/widgets/userwallet_details.dart';
import 'package:lottery_app/screens/wallet/widgets/wallet_features.dart';
import 'package:provider/provider.dart';
import 'package:lottery_app/providers/wallet_provider.dart';
import 'package:lottery_app/services/api_services.dart';
import '../drawer/app_menu.dart';

class WalletScreen extends StatefulWidget {
  final int? amount;
  final String? poolId;
  final String? from;

  const WalletScreen({
    super.key,
    this.amount,
    this.poolId,
    this.from,
  });

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  bool isMenuOpen = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchWalletBalance();
    });
  }

  Future<void> _fetchWalletBalance() async {
    if (!mounted) return;

    setState(() => isLoading = true);

    try {
      await Future.delayed(const Duration(milliseconds: 100));

      final response = await ApiServices.getRequest("/wallet");

      print("WALLET RESPONSE: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == true) {
          double balance =
              double.tryParse(response['balance']?.toString() ?? '') ?? 0.0;

          if (mounted) {
            context.read<WalletProvider>().setBalance(balance);
          }
        } else {
          // 🔥 Handle backend error properly
          debugPrint("Wallet Error: ${response['message']}");

          if (mounted) {
            context.read<WalletProvider>().setBalance(0.0);
          }
        }
      }
    } catch (e) {
      debugPrint("WALLET API ERROR: $e");

      if (mounted) {
        context.read<WalletProvider>().setBalance(0.0);
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _handleJoinPayment() async {
    if (widget.poolId == null) return;

    setState(() => isLoading = true);

    try {
      final res = await ApiServices.postRequest(
        "/levels/join",
        {
          "poolId": widget.poolId,
        },
      );

      if (res != null && res['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Joined successfully")),
        );

        Navigator.pop(context);
      } else {
        throw Exception(res?['error'] ?? "Join failed");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [
                  Color(0xFF0A0F0D),
                  Color(0xFF0A0F0D),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      CustomDrawer(onMenuPressed: toggleMenu,),
                      const SizedBox(height: 20),
                    if (widget.amount != null) ...[
              Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Complete Your Entry",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "You are joining a Level Game. Please complete the payment of ₹${widget.amount}.",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _handleJoinPayment,
                          style:ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFEEB000)
                          ),
                          child: const Text("PAY NOW"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xFF2F2E18),
                          ),
                          child: const Text("Cancel",style: TextStyle(color: Color(0xFFFFFFFF)),),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
              ],
                      const SizedBox(height: 20),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : const UserwalletDetails(),
                     // const UserwalletDetails(),
                      const SizedBox(height:40),
                      const WalletFeatures(),
                      const SizedBox(height: 80),
                      const AppFooter()
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isMenuOpen)
            GestureDetector(
              onTap: toggleMenu,
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),

          if (isMenuOpen)
            AppMenu(
              onClose: toggleMenu,
            ),
        ],
      ),
    );
  }
}