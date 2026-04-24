import 'package:flutter/material.dart';
import '../../models/transcation_model.dart';
import '../../services/api_services.dart';
import '../drawer/app_footer.dart';
import '../drawer/app_menu.dart';
import '../drawer/custom_drawer.dart';



class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  bool isMenuOpen = false;
  bool isLoading = true;

  List<TranscationModel> transactions = [];

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }


  // ✅ FETCH TRANSACTIONS API
  Future<void> fetchTransactions() async {
    try {
      await ApiServices.loadCookie();
      final response =
      await ApiServices.getRequest("/wallet/transactions");

      print("API RESPONSE: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == true) {
          final List data = response['transactions'] ?? [];

          setState(() {
            transactions =
                data.map((e) => TranscationModel.fromJson(e)).toList();
            isLoading = false;
          });
        } else {
          print("API ERROR: ${response['message']}");

          setState(() {
            transactions = [];
            isLoading = false;
          });
        }
      } else if (response is List) {
        // fallback if API directly returns list
        setState(() {
          transactions =
              response.map((e) => TranscationModel.fromJson(e)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          transactions = [];
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Transaction API Error: $e");

      setState(() {
        transactions = [];
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505), // Pure dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Keep Header static at the top
              CustomDrawer(onMenuPressed: toggleMenu),

              // The rest of the page should be a single scrollable area
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // 1. THE TRANSACTIONS LIST
                    // Use shrinkWrap because it's inside another ListView
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        return _buildTransactionTile(transactions[index]);
                      },
                    ),

                    const SizedBox(height: 40),

                    // 2. THE FOOTER
                    // Now it will naturally sit below the transactions
                    const AppFooter(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ TRANSACTION TILE (UI MATCHING YOUR IMAGE)
  Widget _buildTransactionTile(TranscationModel txn) {
    // Logic for colors based on your API 'type'
    bool isCredit = txn.type == "PrizePayout" || txn.type == "ReferralReward" || txn.type == "Deposit";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1F3D32), width: 0.5)),
      ),
      child: Row(
        children: [
          // ICON
          CircleAvatar(
            backgroundColor: const Color(0xFF121212),
            child: Icon(
              isCredit ? Icons.south_west : Icons.north_east,
              color: isCredit ? const Color(0xFF00FFA3) : Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 14),
          // TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${txn.type}", // Displays "Deposit — Ravi Kumar"
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  txn.date.split('T')[0], // Cleans up the date string
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          // AMOUNT
          Text(
            "${isCredit ? "+" : "-"}₹${txn.amount.toStringAsFixed(2)}",
            style: TextStyle(
              color: isCredit ? const Color(0xFF00FFA3) : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
