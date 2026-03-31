import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
class LevelsOverview extends StatelessWidget{
  const LevelsOverview ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Row(
          children: [
            const LevelCard(svgIcon: 'assets/shield.svg', level: "Level 1", title: "Basic", iconColor: Colors.grey),
            const SizedBox(width: 15),
            const LevelCard(svgIcon: 'assets/award.svg', level: "Level 2", title: "Bronze",iconColor: Colors.orange),
          ],
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            const LevelCard(svgIcon: 'assets/star.svg', level: "Level 3", title: "Silver",iconColor: Colors.blueGrey),
            const SizedBox(width: 15),
            const LevelCard(svgIcon: 'assets/crown.svg', level: "Level 4", title: "Gold",iconColor: Colors.yellowAccent),
          ],
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            const LevelCard(svgIcon: 'assets/gem.svg', level: "Level 5", title: "Platinum",iconColor: Colors.lightBlueAccent),
            const SizedBox(width: 15),
            const LevelCard(svgIcon: 'assets/sparkles.svg', level: "Level 6", title: "Diamond",iconColor: Colors.blue),
          ],
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            const LevelCard(svgIcon: 'assets/zap.svg', level: "Level 7", title: "Elite",iconColor: Colors.purple),
            const SizedBox(width: 15),
            const LevelCard(svgIcon: 'assets/flame.svg', level: "Level 8", title: "Superstar",iconColor: Colors.orange),
          ],
        ),
        const SizedBox(height: 20),

        Row(
          children: [
            const LevelCard(svgIcon: 'assets/badge-check.svg', level: "Level 9", title: "Titan",iconColor: Colors.pinkAccent),
            const SizedBox(width: 15),
            const LevelCard(svgIcon: 'assets/trophy.svg', level: "Level 10", title: "VIP",iconColor: Colors.yellowAccent),
          ],
        ),
      ],
    );

  }
}

class LevelCard extends StatelessWidget{
  // final IconData icon;
  final String? svgIcon;
  final String level;
  final String title;
  final Color iconColor;

  const LevelCard({
    super.key,
    // required this.icon,
    this.svgIcon,
    required this.level,
    required this.title,
    required this.iconColor
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 150,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xFF101828),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: const Color(0xFF232B38)

          )
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            svgIcon!,
            width: 35,
            height:35,
            color: iconColor,
          ),
          const SizedBox(height: 14),

          Text(
            level,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.grey
            ),
          ),

          const SizedBox(height: 3),

          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          )
        ],
      ),
    );
  }
}