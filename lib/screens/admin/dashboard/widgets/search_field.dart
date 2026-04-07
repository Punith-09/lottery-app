import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        
        Container(
          width: 250,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, size: 18, color: Color(0xFF000000)),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  style: TextStyle(
                    color: Color(0xFF000000)
                  ),
                  decoration: const InputDecoration(
                    hintText: "Search...",
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (value) {
                    
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 60),


      ],
    );
  }
}