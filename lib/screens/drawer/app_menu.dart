import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottery_app/providers/login_provider.dart';
import 'package:lottery_app/providers/wallet_provider.dart';
import 'package:lottery_app/screens/auth/Profile_screen.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';

class AppMenu extends StatelessWidget {
  final VoidCallback onClose;

   const AppMenu({
    super.key,
    required this.onClose,
  });


  @override
  Widget build(BuildContext context) {
    final wallet= context.watch<WalletProvider>();
    final halfHeight = MediaQuery.of(context).size.height * 0.85;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 800,
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

                const SizedBox(height: 10),

                const Divider(color: Colors.white10),

                const SizedBox(height: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFF161D1A),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/wallet.svg",
                            width: 16,
                            height: 16,
                            color:Color(0xFF05DA70),
                          ),
                          const SizedBox(width: 8,),
                          Text(
                            "Wallet:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text("₹${wallet.balance.toStringAsFixed(2)}")
                        ],
                      )
                    ),
                    const SizedBox(height: 10,),
                    Consumer<AuthProvider>(builder: (context,auth,child){
                      if(auth.isLoggedIn){
                        return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF161D1A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )
                          ),
                          onPressed: (){
                            Navigator.push(
                                context,
                              MaterialPageRoute(builder: (_)=>const ProfileScreen(),),
                            );
                          },
                          icon: const Icon(Icons.person,color: Colors.white),
                          label: Text(
                            auth.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }else{
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                             onPressed: (){
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ));
                      }
                    }),

                    const SizedBox(height: 10),
                    Consumer<AuthProvider>(
                      builder: (context, auth, child) {
                        return Column(
                          children: [
                            /// 🔐 LOGOUT BUTTON (only when logged in)
                            if (auth.isLoggedIn)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  onPressed: () {
                                    Provider.of<AuthProvider>(context, listen: false)
                                        .logout();

                                    Navigator.pop(context); // close drawer
                                  },
                                  child: const Text("Logout"),
                                ),
                              ),

                            /// 🆕 SIGNUP + ADMIN (only when NOT logged in)
                            if (!auth.isLoggedIn) ...[
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                  child: const Text("Sign Up"),
                                ),
                              ),

                              const SizedBox(height: 10),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to admin login
                                  },
                                  child: const Text("Admin Login"),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    )

                    // ),
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