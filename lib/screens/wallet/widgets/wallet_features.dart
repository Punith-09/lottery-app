import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottery_app/screens/wallet/transactions_screen.dart';

class WalletFeatures extends StatelessWidget {
  const WalletFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeatureCard(
          svg: "assets/ticket.svg",
          title: "Buy Tickets",
          description: "Purchase lottery tickets",
          onTap: () => print("Navigate to Tickets"),
        ),
        const SizedBox(height: 20),
        FeatureCard(
          svg: "assets/refresh.svg",
          title: "Auto-Draw",
          description: "Set up subscriptions",
          onTap: () => print("Navigate to Auto-Draw"),
        ),
        const SizedBox(height: 20),
        FeatureCard(
          svg: "assets/users.svg",
          title: "Referral Code",
          description: "Earn \$20 per referral",
          onTap: () => print("Navigate to Referral"),
        ),
        const SizedBox(height: 20),
        FeatureCard(
          svg: "assets/clock.svg",
          title: "Transaction History",
          description: "View all transactions",
          onTap : (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>const TransactionsScreen()));
          }
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String svg;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.svg,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0F1613),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFF1F3D32)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF069B6C).withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                svg,
                width: 26,
                height: 26,
                // Modern way to apply color to SVG
                colorFilter: const ColorFilter.mode(
                  Color(0xFF00D391),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16, // Slightly reduced for better hierarchy
                color: Color(0x85FFFFFF),
                fontWeight: FontWeight.w500, // Semi-bold is usually better for descriptions
              ),
            ),
          ],
        ),
      ),
    );
  }
}