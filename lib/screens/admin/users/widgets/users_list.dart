import 'package:flutter/material.dart';

class UsersList extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  const UsersList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Center(child: Text("No users found",style: TextStyle(color: Color(0xFFFF0000)),));
    }

    return ListView.builder(
      itemCount: users.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return UserCard(user: users[index]);
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final name = user["name"] ?? "";
    final email = user["email"] ?? "";
    final wallet = user["wallet"]?.toString() ?? "0";
    final status = user["status"] ?? "active";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue,
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : "?",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),

            
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      email,
                      style: const TextStyle(

                        fontSize: 12,
                        color: Color(0xFF000000),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

             
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: status == "active"
                      ? Colors.green.withOpacity(0.1)
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: status == "active"
                        ? Color(0xFF48FF00)
                        : Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

         
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wallet: ₹$wallet",
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w500,
                ),
              ),

              TextButton(
                onPressed: () {
                  
                },
                child: const Text("View →",style: TextStyle(color: Color(0xFF000000)),),
              )
            ],
          )
        ],
      ),
    );
  }
}