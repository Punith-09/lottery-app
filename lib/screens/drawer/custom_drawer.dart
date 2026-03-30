import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';


class CustomDrawer extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const CustomDrawer({
    super.key,
    required this.onMenuPressed,
  });

  @override

  Widget build(BuildContext context) {
    return Column(
      children: [
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        const Text(
          "🎰 Lottery Network",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              // color: Color(0xFFFFC857),
              color: AppColors.accent
          ),
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white,size: 30,),
          onPressed: onMenuPressed,
        )

      ],
    ),
        Divider(color: Colors.white24),
        SizedBox(height: 20),
      ],
    );
  }
}