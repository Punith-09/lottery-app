import 'package:flutter/material.dart';

class SearchFilter extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final int totalCount;

  const SearchFilter({super.key,required this.controller,required this.onChanged,required this.totalCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search by Ticket or user...",
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              )
            ),
          ),),
          const SizedBox(width: 20),
          Text(
            "Total Tickets: $totalCount",
            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
          ),
        ],
      ),
    );
  }
}
