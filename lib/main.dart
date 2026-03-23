import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../games/games_screen.dart';
import '../results/results_screen.dart';
import '../levels/levels_screen.dart';
import '../wallet/wallet_screen.dart';
import '../how_to_play/how_to_play_screen.dart';
import '../drawer/custom_drawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int selectedIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const GamesScreen(),
    const ResultsScreen(),
    const LevelsScreen(),
    const WalletScreen(),
    const HowToPlayScreen(),
  ];

  final List<String> titles = [
    "Home",
    "Games",
    "Results",
    "Levels",
    "Wallet",
    "How to Play",
  ];

  void onItemTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    Navigator.pop(context); // close drawer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedIndex]),
      ),

      drawer: CustomDrawer(onTap: onItemTap),

      body: screens[selectedIndex],
    );
  }
}
