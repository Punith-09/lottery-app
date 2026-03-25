import 'package:flutter/material.dart';

class RewardCard extends StatelessWidget {
  const RewardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 400,
      // padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
        image: const DecorationImage(
          image: AssetImage('assets/reward.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.3),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "10-Level Rewards System",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Unlock exclusive perks as you play more",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white70,
                ),
              ),


              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical:10,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  border: Border.all(
                    color: Colors.orange.withOpacity(0.3)
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Your Level: Silver (Level 3)",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical:10,
                ),
                decoration: BoxDecoration(
                    color: Color(0xFF1E2939),

                  border: Border.all(
                    color: Color(0xFF313C4E),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "XP: 750 / 1,500",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}