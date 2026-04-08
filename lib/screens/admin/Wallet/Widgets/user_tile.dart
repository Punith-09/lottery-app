import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserTile({super.key,required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Text(user['name'][0]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text("Last: ${user['lastTxn']}"),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("₹${user['balance']}",
                  style: const TextStyle(color: Colors.green)),
              Text("Bonus ₹${user['bonus']}"),
              Text("Locked ₹${user['locked']}",
                  style: const TextStyle(color: Colors.red)),
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.add, color: Colors.green),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.red),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
