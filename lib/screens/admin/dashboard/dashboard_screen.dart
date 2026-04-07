import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/dashboard/widgets/details_card.dart';
import 'package:lottery_app/screens/admin/dashboard/widgets/draws_card.dart';
import 'package:lottery_app/screens/admin/dashboard/widgets/level_distribution.dart';
import 'package:lottery_app/screens/admin/dashboard/widgets/search_field.dart';
import '../drawer/admin_drawer.dart';
import '../drawer/drawer_menu.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

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

                      AdminDrawer(onMenuPressed: toggleMenu),

                      const SizedBox(height: 20),
                    Column(
                      children: [
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 24
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Welcome back to your control center",
                          style: TextStyle(
                            color: Color(0x85000000)
                          ),
                        )

                      ],
                    ),
                      const SizedBox(height: 20),

                      SearchField(),

                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: DetailsCard(svgIcon: "👥", value: "0", title: "Total Users",percentage: "0", textColor:Color(0xFF1E40AE) )),

                          const SizedBox(width: 10),

                          Expanded(child: DetailsCard(svgIcon: "💰", value: "0", title: "Total Revenue",percentage: "0", textColor: Color(0xFF16A24A)),)
                        ],
                      ),


                      const SizedBox(height: 20),

                      Row(

                        children: [
                          Expanded(child: DetailsCard(svgIcon: "🎫", value: "0", title: "Tickets Sold",percentage: "0", textColor: Color(0xFFD77606)),),

                          const SizedBox(width: 20),

                          Expanded(child: DetailsCard(svgIcon: "🎰", value: "0", title: "Active Draws",percentage: "0", textColor: Color(0xFF16A24A)),)
                        ],
                      ),
                      const SizedBox(height: 50),

                      DrawsCard(),

                      const SizedBox(height: 50),

                      LevelDistribution()
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