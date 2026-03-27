import 'package:flutter/material.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import 'package:lottery_app/screens/levels/widgets/level_progress.dart';
import 'package:lottery_app/screens/levels/widgets/levels_description.dart';
import 'package:lottery_app/screens/levels/widgets/levels_overview.dart';
import 'package:lottery_app/screens/levels/widgets/reward_card.dart';

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

                      const RewardCard(),

                      const SizedBox(height: 40),

                      const LevelsOverview(),

                      const SizedBox(height: 60),

                      const LevelProgress(progress: 0.5, xpText: "750/1,500 XP" ),

                      const SizedBox(height: 60),

                      const LevelsDescription()
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