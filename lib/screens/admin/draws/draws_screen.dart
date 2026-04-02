import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/draws/widgets/details_card.dart';
import '../drawer/admin_drawer.dart';
import '../drawer/drawer_menu.dart';

class DrawsScreen extends StatefulWidget {
  const DrawsScreen({super.key});

  @override
  State<DrawsScreen> createState() => _DrawsScreenState();
}

class _DrawsScreenState extends State<DrawsScreen> {

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      AdminDrawer(onMenuPressed: toggleMenu,),

                      const SizedBox(height: 20),
                      Column(

                        children: [
                          Text(
                            "Draws",
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 26,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Manage all lottery draws",
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
                         Expanded(child: DetailsCard(svgIcon: "🎰", value: "0", title: "Live Draws", textColor: Color(0xFF16A24A)),),

                         const SizedBox(width: 10),

                         Expanded(child: DetailsCard(svgIcon: "⏳", value: "0", title: "Scheduled", textColor: Color(0xFF1E40AE)),)
                       ],
                     ),


                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(child: DetailsCard(svgIcon: "✅", value: "0", title: "Completed", textColor: Color(0xFFD77606)),),

                          const SizedBox(width: 20),
                          Expanded(child: DetailsCard(svgIcon: "💰", value: "0", title: "Total Prizes Paid", textColor: Color(0xFF1E40AE)),)
                        ],
                      ),

                      const SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(

                            style: ElevatedButton.styleFrom(
                              padding:EdgeInsets.all(18),
                              backgroundColor: Color(0xFFD77606),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/createDraws');
                            },
                            child: const Text(
                              "🎯 Create Draw",
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              ),
                            ),
                          ),
                          const SizedBox(height: 200)
                        ],
                      )

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