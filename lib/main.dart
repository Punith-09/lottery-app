import 'package:flutter/material.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import 'package:lottery_app/screens/games/games_screen.dart';
import 'package:lottery_app/screens/home/home_screen.dart';
import 'package:lottery_app/screens/how_to_play/how_to_play_screen.dart';
import 'package:lottery_app/screens/levels/levels_screen.dart';
import 'package:lottery_app/screens/results/results_screen.dart';
import 'package:lottery_app/screens/wallet/wallet_screen.dart';

import 'core/theme/app_theme.dart';

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
      theme: AppTheme.darkTheme,

        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/all-games': (context) => const GamesScreen(),
          '/results': (context) => const ResultScreen(),
          '/levels': (context) => const LevelsScreen(),
          '/wallet': (context) => const WalletScreen(),
          '/how-to-play': (context) => const HowToPlayScreen(),
        }
    );
  }
}
