import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/drawer/admin_drawer.dart';
import 'package:lottery_app/screens/admin/drawer/drawer_menu.dart';
import 'package:lottery_app/screens/admin/Tickets/widgets/search_filter.dart';
import 'package:lottery_app/screens/admin/Tickets/widgets/ticket_widget.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  bool isMenuOpen = false;

  final TextEditingController searchController = TextEditingController();

  List<Map<String, String>> tickets = [
    {
      "ticket": "12345",
      "numbers": "1,2,3,4",
      "user": "Lokesh",
      "price": "₹100",
      "status": "Active",
      "date": "2026-04-07"
    },
    {
      "ticket": "67890",
      "numbers": "5,6,7,8",
      "user": "Ravi",
      "price": "₹200",
      "status": "Pending",
      "date": "2026-04-06"
    },
  ];

  List<Map<String, String>> filteredTickets = [];

  @override
  void initState() {
    super.initState();
    filteredTickets = tickets;
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  void filterTickets(String query) {
    setState(() {
      filteredTickets = tickets.where((ticket) {
        final ticketNumber = ticket["ticket"]!.toLowerCase();
        final userName = ticket["user"]!.toLowerCase();

        return ticketNumber.contains(query.toLowerCase()) ||
            userName.contains(query.toLowerCase());
      }).toList();
    });
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    /// 🔹 TOP BAR
                    AdminDrawer(onMenuPressed: toggleMenu),

                    const SizedBox(height: 20),

                    /// 🔹 TITLE
                    Column(
                      children: const [
                        Text(
                          "Purchased Tickets & Boxes",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "View all tickets with picked numbers and user details.",
                          style: TextStyle(
                            color: Color(0x50000000),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// 🔍 SEARCH BAR
                    SearchFilter(
                      controller: searchController,
                      onChanged: filterTickets,
                      totalCount: filteredTickets.length,
                    ),

                    const SizedBox(height: 20),

                    /// 📊 TABLE (IMPORTANT: wrap with Expanded)
                    Expanded(
                      child: TicketWidget(
                        tickets: filteredTickets,
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
