import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LevelsDescription extends StatelessWidget {
  const LevelsDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LevelCard(
          svgIcon: 'assets/shield.svg',
          level: "Level 1-Basic",
          tickets: "1 Free ticket/month",
          discount: "Standard Support",
          iconColor: Colors.grey,
        ),
        const SizedBox(height: 20),

        const LevelCard(
          svgIcon: 'assets/award.svg',
          level: "Level 2-Bronze",
          tickets: "2 Free tickets/month",
          discount: "5% ticket discount",
          iconColor: Colors.orange,
        ),
        const SizedBox(height: 20),

        const LevelCard(
          svgIcon: 'assets/star.svg',
          level: "Level 3-Silver",
          tickets: "5 Free tickets/month",
          discount: "10% ticket discount",
          privileges: "Bonus number picks",
          iconColor: Colors.blueGrey,
        ),
        const SizedBox(height: 20),


        const LevelCard(
          svgIcon: 'assets/crown.svg',
          level: "Level 4-Gold",
          tickets: "10 Free tickets/month",
          discount: "15% discount",
          privileges: "Priority payouts",
          XP: "1,500 XP required",
          iconColor: Colors.amber,
        ),
        const SizedBox(height: 20),

        const LevelCard(
          svgIcon: 'assets/gem.svg',
          level: "Level 5-Platinum",
          tickets: "15 tickets/month",
          discount: "20% discount",
          privileges: "Exclusive draws",
          XP: "3,000 XP required",
          iconColor: Colors.lightBlueAccent,
        ),
        const SizedBox(height: 20),

        const LevelCard(
          svgIcon: 'assets/sparkles.svg',
          level: "Level 6-Diamond",
          tickets: "20 tickets/month",
          discount: "25% discount",
          privileges: "Personal manager",
          XP: "6,000 XP required",
          iconColor: Colors.blue,
        ),
        const SizedBox(height: 20),

        const LevelCard(
          svgIcon: 'assets/zap.svg',
          level: "Level 7-Elite",
          tickets: "Unlimited tickets",
          discount: "30% discount",
          privileges: "Advanced analytics",
          XP: "10,000 XP required",
          iconColor: Colors.purple,
        ),
        const SizedBox(height: 20),

        const LevelCard(
          svgIcon: 'assets/flame.svg',
          level: "Level 8-Superstar",
          tickets: "All Elite perks",
          discount: "Double referral reward",
          privileges: "VIP events",
          XP: "20,000 XP required",
          iconColor: Colors.orange,
        ),
        const SizedBox(height: 20),

        const LevelCard(
          svgIcon: 'assets/badge-check.svg',
          level: "Level 9-Titan",
          tickets: "All Superstar perks",
          discount: "Highest referral bonus",
          privileges: "Custom draws",
          XP: "35,000 XP required",
          iconColor: Colors.pinkAccent,
        ),
        const SizedBox(height: 20),

        const LevelCard(
          svgIcon: 'assets/trophy.svg',
          level: "Level 10-VIP",
          tickets: "All perks unlocked",
          discount: "Priority winnings",
          privileges: "Concierge service",
          XP: "50,000 XP required",
          iconColor: Colors.yellowAccent,
        ),
      ],
    );
  }
}

class LevelCard extends StatelessWidget {
  final IconData? icon;
  final String? svgIcon;
  final String level;
  final String tickets;
  final String discount;
  final String? privileges;
  final String? XP;
  final Color iconColor;

  const LevelCard({
    super.key,
    this.icon,
    this.svgIcon,
    required this.level,
    required this.tickets,
    required this.discount,
    this.privileges,
    this.XP,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF101828),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF232B38)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: svgIcon != null
                ? SvgPicture.asset(
              svgIcon!,
              width: 30,
              height: 30,
              color: iconColor,
            )
                : Icon(
              icon,
              color: iconColor,
              size: 40,
            ),
          ),

          const SizedBox(height: 14),


          Text(
            level,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  const Icon(Icons.check, color: Colors.orange, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    tickets,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.check, color: Colors.orange, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    discount,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(height: 4),



              if (privileges != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.check, color: Colors.orange, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      privileges!,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],

              if (XP != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.lock_outline, color: Colors.white38, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      XP!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white38,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}