import 'package:flutter/material.dart';

class HowtoplayCard extends StatelessWidget{
  const HowtoplayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      // padding: EdgeInsets.all(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            Image.asset(
              "assets/welcome.jpeg",
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            Container(color: Colors.black.withOpacity(0.10)),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Text(
                    "How to Play",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Everything you need to know to \nstart winning.",
                    style: TextStyle(
                      color: Color(0x85FFFFFF),
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}