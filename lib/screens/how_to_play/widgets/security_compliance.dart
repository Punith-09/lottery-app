import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecurityCompliance extends StatelessWidget{
  const SecurityCompliance({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xFF292929)
        )
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/shield.svg",
                width: 24,
                height: 24,
                color: Color(0xFF98A0AE),
              ),
              const SizedBox(width: 10),
              Text(
                "Security & Compliance",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          const SizedBox(height: 10),

          Data(value: "256-bit SSL data encryption"),

          const SizedBox(height: 18),

          Data(value: "PCI-DSS compliant payment \n processing"),

          const SizedBox(height: 18),

          Data(value: "KYC verification for legal compliance"),

          const SizedBox(height: 18),

          Data(value: "Multi-factor authentication \n (SMS/Email)"),

          const SizedBox(height: 18),

          Data(value: "Independent Rng auditing"),

          const SizedBox(height:18),

          Data(value:"Licensed & regulated platform"),

          const SizedBox(height: 18),

          Data(value: "Responsible gaming tools"),

          const SizedBox(height: 18),

          Data(value: "24/7 fraud monitoring")
        ],
      ),
    );
  }
}

class Data extends StatelessWidget{
  final String value;
  const Data({
    super.key,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return
    Row(
    children: [
    Icon(
    Icons.check,
    color: Color(0xFF717E8B),
    ),
    const SizedBox(width: 10),
    Text(
    value,
    style: TextStyle(
    color: Color(0xFF98A0AE),
      fontWeight: FontWeight.bold
    ),
    ),
    ],
    );
  }
}