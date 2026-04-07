import 'package:flutter/material.dart';

class LevelDistribution extends StatelessWidget{
  const LevelDistribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0x50000000),
          
        ),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Level Distribution",
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(width: 90)
            ],
          ),


          const SizedBox(height: 30),
          
          Levels(title: "VIP", percentage: "0%"),
          const SizedBox(height: 20),
          Levels(title: "Titan", percentage: "0%"),
          const SizedBox(height: 20),
          Levels(title: "SuperStar", percentage: "0%"),
          const SizedBox(height: 20),
          Levels(title: "Elite", percentage: "0%"),
          const SizedBox(height: 20),
          Levels(title: "Diamond", percentage: "0%"),
          const SizedBox(height: 20),
          Levels(title: "Platinum", percentage: "0%"),
          const SizedBox(height: 20),
          Levels(title: "Gold", percentage: "0%"),
          const SizedBox(height: 20),
          Levels(title: "Silver", percentage: "0%"),
          const SizedBox(height: 20),
          Levels(title: "Bronze", percentage: "0%"),
          const SizedBox(height: 20),
          Levels(title: "Basic", percentage: "0%"),


        ],
      ),
    );
  }
}


class Levels extends StatelessWidget{
  final String title;
  final String percentage;
  const Levels({
    super.key,
    required this.title,
    required this.percentage
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Color(0x90000000),
              fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
              color: Color(0x85000000),
              fontSize: 16
          ),
        ),
      ],
    );
  }
}