import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuestionsCard extends StatefulWidget {
  final String title;
  final String description;

  const QuestionsCard({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<QuestionsCard> createState() => _QuestionsCardState();
}

class _QuestionsCardState extends State<QuestionsCard> {
  bool isOpen = false;

  void toggleCard() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCard,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          border: Border.all(color: const Color(0x85FFFFFF)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  "assets/circle-question-mark.svg",
                  width: 23,
                  height: 23,
                  color: isOpen
                      ? Colors.white
                      : const Color(0x50FFFFFF),
                ),
              ],
            ),

            if (isOpen) ...[
              const SizedBox(height: 10),
              Text(
                widget.description,
                style: const TextStyle(
                  color: Color(0x80FFFFFF),
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}