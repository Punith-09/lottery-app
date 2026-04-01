import 'package:flutter/material.dart';
import 'package:lottery_app/screens/drawer/app_footer.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import 'package:lottery_app/screens/how_to_play/widgets/howtoplay_card.dart';
import 'package:lottery_app/screens/how_to_play/widgets/questions_card.dart';
// import 'package:lottery_app/screens/how_to_play/widgets/questions_card.dart';
import 'package:lottery_app/screens/how_to_play/widgets/security_compliance.dart';

import '../drawer/app_menu.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {

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

                      const SizedBox(height: 40),

                      HowtoplayCard(),

                      const SizedBox(height:40),

                      SecurityCompliance(),

                      const SizedBox(height: 100),
                      Text(
                        "   Frequently asked Questions",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 26),
                      QuestionsCard(title: "How do i know the draws are fair?", description: "All draws use a verifiable RNG that is \n independently audited."),
                      const SizedBox(height: 16),
                      QuestionsCard(title: "What os the minimum deposit?", description: "The minimum deposit is \$5 via any supported \npayment method."),
                      const SizedBox(height: 16),
                      QuestionsCard(title: "How long do withdrawls take?", description: "Standard withdrawals are processed within 24 hours."),
                      const SizedBox(height: 16),
                      QuestionsCard(title: "Can i set up auto-draw subscriptions?", description: "Yes! You can subscribe to automatic ticket purchases."),
                      const SizedBox(height: 16),
                      QuestionsCard(title: "How does the referal program work?", description: "Share your referral code and earn bonus credits."),
                      const SizedBox(height: 100),
                      AppFooter()
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