import 'package:flutter/material.dart';


class CustomDrawer extends StatelessWidget {
  final Function(int) onTap;

  const CustomDrawer({super.key, required this.onTap});

  Widget item(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => onTap(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text("Lottery Network"),

          item(Icons.home, "Home", 0),
          item(Icons.videogame_asset, "Games", 1),
          item(Icons.emoji_events, "Results", 2),
          item(Icons.layers, "Levels", 3),
          item(Icons.account_balance_wallet, "Wallet", 4),
          item(Icons.help, "How to Play", 5),
        ],
      ),
    );
  }
}
