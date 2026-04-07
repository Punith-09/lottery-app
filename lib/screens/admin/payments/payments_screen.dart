import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/draws/widgets/details_card.dart';
import 'package:lottery_app/screens/admin/payments/widgets/dates_card.dart';
import '../drawer/admin_drawer.dart';
import '../drawer/drawer_menu.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {

  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      AdminDrawer(onMenuPressed: toggleMenu,),

                      const SizedBox(height: 20),

                      Column(

                        children: [
                          Text(
                            "Payments",
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 26,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Monitor all transactions",
                            style: TextStyle(
                                color: Color(0x50000000),
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),


                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: DetailsCard(svgIcon: "💰", value: "₹0", title: "Total Revenue", textColor: Color(0xFF16A24A)),),

                          const SizedBox(width: 10),

                          Expanded(child: DetailsCard(svgIcon: "📥", value: "₹0", title: "Total Deposits", textColor: Color(0xFF1E40AE)),)
                        ],
                      ),


                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(child: DetailsCard(svgIcon: "📥", value: "₹0", title: "Total Withdrawals", textColor: Color(
                              0xFFDA2626)),),

                          const SizedBox(width: 20),

                          Expanded(child: DetailsCard(svgIcon: "⏳", value: "₹0", title: "Total Prizes Paid", textColor: Color(
                              0xFFF3C418)),)
                        ],
                      ),

                      const SizedBox(height: 40),

                      DatesCard()

                    ],
                  ),
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