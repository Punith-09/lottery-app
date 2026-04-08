import 'package:flutter/material.dart';

class RevenueCard extends StatelessWidget{


  const RevenueCard({super.key});
  static const  List<String> days=["Mon","Tue","Wed","Autumn","Fri","Sat","Sun"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0x50000000)
        )
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Revenue (7 Days)",
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              Text(
                "₹6.8L",
                style: TextStyle(
                  color: Color(0xFFD77606),
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              )
            ],
          ),

          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((day) {
              return Text(
                day,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}