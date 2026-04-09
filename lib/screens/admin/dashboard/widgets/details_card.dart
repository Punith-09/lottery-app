import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class DetailsCard extends StatefulWidget{
  final String svgIcon;
  final String value;
  final String title;
  final String percentage;
  final Color textColor;

  const DetailsCard({
    super.key,
    required this.svgIcon,
    required this.value,
    required this.title,
    required this.percentage,
    required this.textColor
  });

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
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

              Text(
                widget.svgIcon,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
          const SizedBox(height: 15),
          Text(
            widget.value,
            style: TextStyle(
                color: widget.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 24
            ),
          ),
          const SizedBox(height: 15),
          Text(
            widget.title,
            style: TextStyle(
                color: Color(0xFF6A717F),
                fontSize: 16
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "${widget.percentage}%",
            style: TextStyle(
              color: Color(0xFF16A24A),
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}