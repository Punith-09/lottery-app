import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import 'package:lottery_app/screens/levels/widgets/level_game_section.dart';
import 'package:lottery_app/screens/levels/widgets/level_progress.dart';
import 'package:lottery_app/screens/levels/widgets/levels_description.dart';
import 'package:lottery_app/screens/levels/widgets/levels_overview.dart';
import 'package:lottery_app/screens/levels/widgets/reward_card.dart';
import 'package:lottery_app/screens/levels/widgets/withdraw_details.dart';

import '../drawer/app_footer.dart';
import '../drawer/app_menu.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {

  bool isMenuOpen = false;

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

                      // const RewardCard(),

                      const SizedBox(height: 30),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                              "assets/gamepad-2.svg",
                            width: 50,
                            height: 50,
                            color: Color(0xffeeb000),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Level Game",
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              // const SizedBox(height: 2),
                              Text(
                                "Join pools and earn rewards",
                                style: TextStyle(
                                    color: Color(0x85FFFFFF),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      // const LevelsOverview(),
                      //
                      const SizedBox(height: 40),


                      const WithdrawDetails(),


                      const SizedBox(height: 40),

                      const LevelGameSection(),

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