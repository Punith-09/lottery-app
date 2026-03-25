import 'package:flutter/material.dart';
import 'package:lottery_app/core/constants/app_constants.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    // We remove the Container and its decoration/padding.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Branding
        Row(
          children: [
            Text(
              "🎰 Lottery Network",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Text(
          "The most trusted decentralized lottery platform with transparent draws and instant payouts.",
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 40),

        // Quick Links
        _buildLinkGroup(
          context,
          title: "Quick Links",
          links: [
            {"text": "Home", "onTap": () => _navigateTo(context, '/home')},
            {"text": "Games", "onTap": () => _navigateTo(context, '/games')},
            {"text": "Results", "onTap": () => _navigateTo(context, '/results')},
            {"text": "How to Play", "onTap": () => _navigateTo(context, '/how-to-play')},
          ],
        ),
        const SizedBox(height: 30),

        // Support
        _buildLinkGroup(
          context,
          title: "Support",
          links: [
            {"text": "Help Center", "onTap": () {}},
            {"text": "Terms of Service", "onTap": () {}},
            {"text": "Privacy Policy", "onTap": () {}},
            {"text": "Security", "onTap": () {}},
            {"text": "Contact Us", "onTap": () {}},
          ],
        ),
        const SizedBox(height: 30),

        // Connect
        _buildLinkGroup(
          context,
          title: "connect",
          links: [
            {"text": "Twitter", "onTap": () {}},
            {"text": "Discord", "onTap": () {}},
            {"text": "Telegram", "onTap": () {}},
          ],
        ),
        const SizedBox(height: 40),

        Divider(
          color: AppColors.textPrimary.withOpacity(0.1),
          thickness: 1,
        ),
        const SizedBox(height: 30),

        // Copyright Section
        Center(
          child: Text(
            "© 2026 Lottery Network. All rights reserved. Play responsibly.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.5),
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLinkGroup(
      BuildContext context, {
        required String title,
        required List<Map<String, dynamic>> links,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GestureDetector(
            onTap: link['onTap'],
            child: Text(
              link['text'],
              style: TextStyle(
                color: AppColors.textPrimary.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        )),
      ],
    );
  }

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }
}