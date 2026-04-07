import 'package:flutter/material.dart';


class PointsConfiguration extends StatelessWidget{
  const PointsConfiguration({super.key});
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Color(0x40000000)
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          "Points Configuration",
          style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 24,
              fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 30),
            
            PointsCard(title: "Ticket Purchase", points: "0pts", description: "10 points per ₹100 spent"),
            const SizedBox(height: 30),
            PointsCard(title: "Referral Signup", points: "50pts", description: "50 points per successful referral"),
            const SizedBox(height: 30),
            PointsCard(title: "Win Draw", points: "200pts" ,description: "200 points for winning any draw"),
            const SizedBox(height: 30),
            PointsCard(title: "Daily Login", points: "5 pts", description: "5 points per day login streak"),
            const SizedBox(height: 30),
            PointsCard(title: "Wallet Top-up", points: "5 pts", description: "5 points per ₹100 deposited"),
            const SizedBox(height: 30),
            PointsCard(title: "Social Share", points: "10 pts", description: "10 points per verified social share"),
            const SizedBox(height: 30),
          ],
        ),
    );
  }
}


class PointsCard extends StatelessWidget{
  final String title;
  final String points;
  final String description;

  const PointsCard({
    super.key,
    required this.title,
    required this.points,
    required this.description
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0x40000000)
        ),
        borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                 color: Color(0xFF000000),
                  fontWeight: FontWeight.bold
                ),
              ),
              Icon(
                  Icons.edit,
                color: Color(0x85000000),

              ),
            ],
          ),
          const SizedBox(height: 20),

          Text(
            points,
            style: TextStyle(
              color: Color(0xFFF3C418),
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height:20),
          Text(
            description,
            style: TextStyle(
              color: Color(0xFF232323)
            ),
          )
        ],
      ),
    );



  }
}