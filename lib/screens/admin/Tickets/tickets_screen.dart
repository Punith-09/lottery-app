import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/drawer/admin_drawer.dart';
import 'package:lottery_app/screens/admin/drawer/drawer_menu.dart';
import 'package:lottery_app/screens/admin/Tickets/widgets/search_filter.dart';
import 'package:lottery_app/screens/admin/Tickets/widgets/ticket_widget.dart';
import 'package:lottery_app/services/api_services.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  bool isMenuOpen = false;
  bool isLoading = true; // ✅ FIXED (should be true initially)

  final TextEditingController searchController = TextEditingController();

  List<Map<String, String>> tickets = [];
  List<Map<String, String>> filteredTickets = [];

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  /// 🔥 FETCH API DATA
  Future<void> fetchTickets() async {
    try {
      final ticketsRes = await ApiServices.getRequest("/tickets");
      final usersRes = await ApiServices.getRequest("/users");

      final List ticketsData = ticketsRes["data"] ?? ticketsRes;
      final List usersData = usersRes["data"] ?? usersRes;
      Map userMap = {
        for (var user in usersData)
          user["id"] ?? user["_id"]: user["name"] ?? user["username"]
      };
      print(ticketsData);

      final loadedTickets = ticketsData.map<Map<String, String>>((ticket) {
        /// ✅ Ticket Number (handle multiple keys)
        String ticketNumber =
            ticket["ticketNumber"]?.toString() ??
                ticket["ticket_number"]?.toString() ??
                ticket["ticket"]?.toString() ??
                "";

        /// ✅ Picked Numbers Fix (handles List or String)
        String numbers = "";
        if (ticket["pickedNumbers"] is List) {
          numbers = (ticket["pickedNumbers"] as List)
              .map((e) => e is Map ? e["number"].toString() : e.toString())
              .join(", ");
        } else {
          numbers = ticket["pickedNumbers"]?.toString() ??
              ticket["picked_numbers"]?.toString() ??
              "";
        }

        /// ✅ User Fix
        String userName =
            userMap[ticket["userId"]] ??
                userMap[ticket["user_id"]] ??
                ticket["userName"] ??
                ticket["user_name"] ??
                "Unknown";

        /// ✅ Date Fix
        /// ✅ FIXED DATE LOGIC
        String date = "";

        if (ticket["purchased_at"] != null) {
          try {
            DateTime parsedDate = DateTime.parse(ticket["purchased_at"]);
            date =
            "${parsedDate.day.toString().padLeft(2, '0')}/"
                "${parsedDate.month.toString().padLeft(2, '0')}/"
                "${parsedDate.year}";
          } catch (e) {
            date = ticket["purchased_at"].toString();
          }
        }



        return {
          "ticket": ticketNumber,
          "numbers": numbers,
          "user": userName,
          "price": "₹${ticket["price"] ?? 0}",
          "status": ticket["status"]?.toString() ?? "",
          "date": date,
        };
      }).toList();

      setState(() {
        tickets = loadedTickets;
        filteredTickets = loadedTickets;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching tickets: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  /// 🔹 Drawer toggle
  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  /// 🔹 Search filter
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

                    AdminDrawer(onMenuPressed: toggleMenu),

                    const SizedBox(height: 20),

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

                    SearchFilter(
                      controller: searchController,
                      onChanged: filterTickets,
                      totalCount: filteredTickets.length,
                    ),

                    const SizedBox(height: 20),

                    /// ✅ LOADER + DATA
                    Expanded(
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : TicketWidget(
                        tickets: filteredTickets,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          if (isMenuOpen)
            GestureDetector(
              onTap: toggleMenu,
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),

          if (isMenuOpen)
            DrawerMenu(
              onClose: toggleMenu,
            ),
        ],
      ),
    );
  }
}
