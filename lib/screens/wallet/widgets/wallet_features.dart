import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletFeatures extends StatelessWidget{
  const WalletFeatures({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeatureCard(svg: "assets/ticket.svg", title: "Buy Tickets", description: "Purchase lottery tickets"),
        const SizedBox(height: 20),
        FeatureCard(svg: "assets/refresh.svg", title: "Auto-Draw", description: "Set up subscriptions"),
        const SizedBox(height: 20),
        FeatureCard(svg: "assets/users.svg", title: "Referral Code", description: "Earn \$20 per referral"),
        const SizedBox(height: 20),
        FeatureCard(svg: "assets/clock.svg", title: "Transaction History", description: "View all transactions")
      ],
    );
  }
}

class FeatureCard extends StatelessWidget{
  final String svg;
  final String title;
  final String description;

  const FeatureCard({
    super.key,
    required this.svg,
    required this.title,
    required this.description
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Color(0xFF0F1613),
          borderRadius: BorderRadiusGeometry.circular(15),
          border: Border.all(
              color: Color(0xFF1F3D32)
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF069B6C).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10)
            ),
            child: SvgPicture.asset(
              svg,
              width: 26,
              height: 26,
              color: Color(0xFF00D391),
            ),
          ),

              const SizedBox(height: 14),
              Text(
                title,
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
                fontSize: 18,
                color: Color(0x85FFFFFF),
                fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}