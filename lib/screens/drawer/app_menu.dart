import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';

class AppMenu extends StatelessWidget {

  final VoidCallback onClose;

  const AppMenu({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {

    final halfHeight = MediaQuery.of(context).size.height * 0.67;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 570,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF0A0F0D),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "🎰 Lottery Network",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        // color: Color(0xFFFFC857),
                          color: AppColors.accent
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.close,color: Colors.white, size: 30,),
                      onPressed: onClose,
                    )
                  ],
                ),

                const SizedBox(height: 20),

                menuItem(Icons.home_outlined, "Home",() {
                  Navigator.pushNamed(context, '/');
                }),
                menuItem(Icons.videogame_asset_outlined, "Games",() {
                  Navigator.pushNamed(context, '/all-games');
                }),
                menuItem(Icons.bar_chart_outlined, "Results",() {
                  Navigator.pushNamed(context, '/results');
                }),
                menuItem(Icons.leaderboard_outlined, "Levels",() {
                  Navigator.pushNamed(context, '/levels');
                }),
                menuItem(Icons.account_balance_wallet_outlined, "Wallet",() {
                  Navigator.pushNamed(context, '/wallet');
                }),
                menuItem(Icons.help_outline, "How to Play",() {
                  Navigator.pushNamed(context, '/how-to-play');
                }),

                const Spacer(),

                const Divider(color: Colors.white10),

                const SizedBox(height: 10),

                Row(
                  children: [

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C896),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menuItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}