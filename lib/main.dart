import 'package:flutter/material.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import 'package:lottery_app/screens/games/games_screen.dart';
import 'package:lottery_app/screens/home/home_screen.dart';
import 'package:lottery_app/screens/how_to_play/how_to_play_screen.dart';
import 'package:lottery_app/screens/levels/levels_screen.dart';
import 'package:lottery_app/screens/results/results_screen.dart';
import 'package:lottery_app/screens/wallet/wallet_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lottery Network',
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.darkTheme,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

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
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(titles[selectedIndex]),
      // ),
      //
      // drawer: CustomDrawer( onMenuPressed: toggleMenu,),


      body: screens[selectedIndex],
    );
  }
}
