import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const CustomDrawer({
    super.key,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Lottery Network",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFFFFC857),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: onMenuPressed,
        )
      ],
    );
  }
}