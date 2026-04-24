import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/drawer/admin_drawer.dart';
import 'package:lottery_app/screens/admin/drawer/drawer_menu.dart';

import '../../../services/api_services.dart';

class WalletScreenn extends StatefulWidget {
  const WalletScreenn({super.key});

  @override
  State<WalletScreenn> createState() => _WalletScreennState();
}

class _WalletScreennState extends State<WalletScreenn> {
  TextEditingController controller = TextEditingController();

  List<Map<String, dynamic>> users = [];

  List<Map<String, dynamic>> filteredResults = [];

  bool isMenuOpen = false;
  bool isLoading = true;

  int totalWallet = 0;
  int avgBalance = 0;
  int totalTxns = 0;
  int lockedAmount = 0;



  @override
  void initState() {
    super.initState();
    filteredResults = users;
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  void filterUsers(String query) {
    final results = users.where((user) {
      final name = user['name'].toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredResults = results;
    });
  }

  Future<void> fetchWallets() async{
    setState(()=>isLoading=true);
    try{
      final response = await ApiServices.getRequest("/admin/wallets");
      print("Api response : $response");
      setState(() {
        users = response['users'] ?? [];
        filteredResults = users;

        totalWallet = response['totalBalance'] ?? 0;
        lockedAmount = response['totalLocked'] ?? 0;
        isLoading = false;
      });
    }catch (e){
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load wallet")),);
    }
  }

  Future<void> adjustBalance(String userId,int amount,String type) async{
    try{
      await ApiServices.postRequest("/admin/wallet/adjust", {
        "userId" : userId,
        "amount" : amount,
        "type" : type,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wallet updated successfully!")),
      );
      fetchWallets();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Adjustment failed: $e")),
      );
    }
  }

  Widget buildCard(String title, String value, Color color) {
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
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color)),
            const SizedBox(height: 6),
            Text(title,
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget buildUserTile(Map<String, dynamic> user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue[900],
            child: Text(user['name'][0]),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user['name'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black)),
                Text(user['lastTxn']),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("₹${user['balance']}",
                  style: const TextStyle(color: Colors.green)),
              Text("₹${user['bonus']}",
                  style: const TextStyle(color: Colors.orange)),
              Text("₹${user['locked']}",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    /// 🔹 TOP BAR
                    AdminDrawer(onMenuPressed: toggleMenu),

                    const SizedBox(height: 20),

                    /// 🔹 TITLE
                    const Column(
                      children: [
                        Text(
                          "Wallet Management",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        Text(
                          "Manage user wallets and balance.",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// 🔍 SEARCH BAR
                    TextField(
                      controller: controller,
                      onChanged: filterUsers,
                      decoration: InputDecoration(
                        hintText: "Search user...",
                        prefixIcon: const Icon(Icons.search,color: Colors.blue,),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 📊 CARDS
                    Row(
                      children: [
                        buildCard("Total Wallet", "₹0", Color(0xFFF57C00),),
                        buildCard("Average Balance", "₹0",  Color(0xFF0D47A1)),
                      ],
                    ),
                    Row(
                      children: [
                        buildCard("Transactions", "0", Colors.green),
                        buildCard("Locked", "₹0", Color(0xFFB71C1C)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// 📋 LIST
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredResults.length,
                        itemBuilder: (context, index) {
                          return buildUserTile(filteredResults[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 🔹 OVERLAY
          if (isMenuOpen)
            GestureDetector(
              onTap: toggleMenu,
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),

          /// 🔹 DRAWER
          if (isMenuOpen)
            DrawerMenu(
              onClose: toggleMenu,
            ),
        ],
      ),
    );
  }
}
