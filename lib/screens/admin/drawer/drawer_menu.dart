import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DrawerMenu extends StatelessWidget {

  final VoidCallback onClose;

  const DrawerMenu({
    super.key,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {

    final halfHeight = MediaQuery.of(context).size.height * 0.75;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: halfHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF),
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
                      "🎰 LottoAdmin",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000)
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.close,color: Color(0xFF000000), size: 30,),
                      onPressed: onClose,
                    )
                  ],
                ),

                const SizedBox(height: 20),

                menuItem(Icons.home_outlined, "Dashboard",() {
                  Navigator.pushNamed(context, '/dashboard');
                }),
                menuItem(Icons.videogame_asset_outlined, "Users",() {
                  Navigator.pushNamed(context, '/users');
                }),
                menuItem(Icons.bar_chart_outlined, "Draws",() {
                  Navigator.pushNamed(context, '/draws');
                }),
                menuItem(Icons.category_outlined, "Categories",() {
                  Navigator.pushNamed(context, '/categories');
                }),
                menuItem(Icons.leaderboard_outlined, "LevelsRewards",() {
                  Navigator.pushNamed(context, '/levelsRewards');
                }),
                menuItem(Icons.account_balance_wallet_outlined, "Payments",() {
                  Navigator.pushNamed(context, '/payments');
                }),
                menuItem(Icons.airplane_ticket_outlined, "Tickets",() {
                  Navigator.pushNamed(context, '/tickets');
                }),


                const SizedBox(height: 10),

                // const Divider(color: Colors.white10),
                //
                // const SizedBox(height: 10),
                //
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                //   children: [
                //
                //     Container(
                //         width: double.infinity,
                //         padding: const EdgeInsets.all(15),
                //         decoration: BoxDecoration(
                //             color: Color(0xFF161D1A),
                //             borderRadius: BorderRadius.circular(12)
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             SvgPicture.asset(
                //               "assets/wallet.svg",
                //               width: 16,
                //               height: 16,
                //               color:Color(0xFF05DA70),
                //             ),
                //             const SizedBox(width: 8,),
                //             Text(
                //               "Wallet:",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.bold
                //               ),
                //             ),
                //             Text(
                //               "\$1,480",
                //               style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.bold
                //               ),
                //             ),
                //           ],
                //         )
                //     ),
                //     ElevatedButton(
                //
                //       style: ElevatedButton.styleFrom(
                //
                //         backgroundColor: Colors.transparent,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //       ),
                //       onPressed: () {
                //         Navigator.pushNamed(context, '/login');
                //       },
                //       child: const Text(
                //         "Login",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //
                //     const SizedBox(height: 10),
                //
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: const Color(0xFF00C896),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //       ),
                //       onPressed: () {
                //         Navigator.pushNamed(context, '/signup');
                //       },
                //       child: const Text(
                //         "Sign Up",
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //     // ),
                //   ],
                // )
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
            Icon(icon, color: Color(0xFF000000)),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF000000),
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }
}