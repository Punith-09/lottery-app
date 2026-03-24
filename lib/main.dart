import 'package:flutter/material.dart';
import 'package:lottery_app/screens/home/home_screen.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Lottery Network",
      theme: AppTheme.darkTheme,
      home: HomeScreen(),
    );
  }
}
