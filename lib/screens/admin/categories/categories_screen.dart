import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/categories/widgets/exisiting_categorey.dart';
import 'package:lottery_app/screens/admin/categories/widgets/new_category.dart';
import 'package:lottery_app/screens/admin/dashboard/widgets/details_card.dart';
import 'package:lottery_app/screens/admin/drawer/admin_drawer.dart';
import 'package:lottery_app/screens/admin/drawer/drawer_menu.dart';
//import 'package:lottery_app/screens/admin/levelsrewards/widgets/points_configuration.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
              )
            ),
            child: SafeArea(
                child:
                Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              "Game Categories",
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Text(
                              "Manage lottery game types and their metadata.",
                              style: TextStyle(
                                  color: Color(0x50000000),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            NewCategory() ,// left side
                            SizedBox(height: 20),
                            ExistingCategoriesWidget()  // right side
                          ],
                        ),

                      ],
                    ),
                  ),
                )),

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
