import 'package:flutter/material.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';

import '../drawer/app_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

      Text("This is home", style: TextStyle(fontSize: 40),)
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

          /// MENU
          if (isMenuOpen)
            AppMenu(
              onClose: toggleMenu,
            ),
    ],
    ),
    );
  }
}