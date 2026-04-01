import 'package:flutter/material.dart';

// import '../../core/constants/app_constants.dart';


class AdminDrawer extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const AdminDrawer({
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
              "🎰 LottoAdmin",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  // color: Color(0xFFFFC857),
                  color: Color(0xFFD77606)
              ),
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF000000),size: 30,),
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