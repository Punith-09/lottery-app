import 'package:flutter/material.dart';

class ExistingCategoriesWidget extends StatelessWidget {
  final List categories;
  const ExistingCategoriesWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Existing Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black)),
                Chip(
                  backgroundColor: const Color(0xFFEFF6FF),
                  label: Text("Total: ${categories.length}",
                      style: const TextStyle(color: Color(0xFF1D4ED8), fontWeight: FontWeight.bold,)),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table Header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: const [
                      SizedBox(width: 20),
                      SizedBox(width: 60, child: Text("ICON", style: TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.bold))),
                      SizedBox(width: 140, child: Text("NAME", style: TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.bold))),
                      SizedBox(width: 200, child: Text("DESCRIPTION", style: TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.bold))),
                      SizedBox(width: 100, child: Text("STATUS", style: TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.bold))),
                      SizedBox(width: 150, child: Text("DATE", style: TextStyle(color: Colors.black38, fontSize: 12, fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                const Divider(height: 1),

                if (categories.isEmpty)
                  const SizedBox(
                    width: 670,
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: Text("No data found in categories list")),
                    ),
                  )
                else
                  ...categories.map((cat) => _buildRow(cat)).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(dynamic cat) {
    // Key mappings based on your JSON
    final String name = cat['name'] ?? "No Name";
    final String icon = cat['icon'] ?? "🎲";
    final String desc = cat['description'] ?? "No description";
    final bool isActive = cat['isActive'] ?? false;
    final String date = (cat['createdAt'] ?? "-").toString().split('T')[0];

    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const SizedBox(width: 20),
          SizedBox(width: 60, child: Text(icon, style: const TextStyle(fontSize: 20))),
          SizedBox(width: 140, child: Text(name, style: const TextStyle(fontWeight: FontWeight.w500))),
          SizedBox(width: 200, child: Text(desc, style: const TextStyle(color: Colors.black54), overflow: TextOverflow.ellipsis)),
          SizedBox(
            width: 100,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(isActive ? "Active" : "Inactive",
                  style: TextStyle(color: isActive ? Colors.green : Colors.red, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(width: 150, child: Text(date, style: const TextStyle(color: Colors.black45))),
        ],
      ),
    );
  }
}