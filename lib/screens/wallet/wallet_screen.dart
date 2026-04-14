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
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  bool isMenuOpen = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // We wait for the first frame to render BEFORE fetching data.
    // This prevents the "Blank Screen" caused by blocking the main thread.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchWalletBalance();
    });
  }

  Future<void> _fetchWalletBalance() async {
    if (!mounted) return;

    setState(() => isLoading = true);

    try {
      // Adding a tiny delay helps the UI thread "breathe"
      await Future.delayed(const Duration(milliseconds: 100));

      final response = await ApiServices.getRequest("/wallet");

      if (response != null && response['success'] == true) {
        double balance = double.parse(response['balance'].toString());
        if (mounted) {
          context.read<WalletProvider>().setBalance(balance);
        }
      }
    } catch (e) {
      debugPrint("WALLET API ERROR: $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
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
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : const UserwalletDetails(),
                      const UserwalletDetails(),
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