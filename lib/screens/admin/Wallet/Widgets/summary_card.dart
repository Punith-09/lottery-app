import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  const SummaryCard({super.key,required this.title,
    required this.value,});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                style: const TextStyle(
                  fontSize: 22,fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(color: Colors.grey)),
            ],
          ),
    )
    );
  }
}
