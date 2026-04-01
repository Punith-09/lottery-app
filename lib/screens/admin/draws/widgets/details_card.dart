import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailsCard extends StatelessWidget{
  final String svgIcon;
  final String value;
  final String title;
  final Color textColor;

  const DetailsCard({
    super.key,
    required this.svgIcon,
    required this.value,
    required this.title,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color(0xFFD3CECE)
        )
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0x85D6CFCF),
              borderRadius: BorderRadius.circular(10)
            ),
            child:
            Text(
              svgIcon,
              style: TextStyle(
                  fontSize: 24,
              ),
            )
          ),
          const SizedBox(height: 15),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF6A717F),
              fontSize: 16
            ),
          )
        ],
      ),
    );
  }
}