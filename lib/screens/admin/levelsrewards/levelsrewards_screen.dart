import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/draws/widgets/details_card.dart';
import 'package:lottery_app/screens/admin/levelsrewards/widgets/active_level.dart';
import 'package:lottery_app/screens/admin/levelsrewards/widgets/points_configuration.dart';
import 'package:lottery_app/services/api_services.dart';
import '../drawer/admin_drawer.dart';
import '../drawer/drawer_menu.dart';

class LevelsRewardsScreen extends StatefulWidget {
  const LevelsRewardsScreen({super.key});

  @override
  State<LevelsRewardsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsRewardsScreen> {
  Map<String,dynamic> stats={};
  bool isMenuOpen = false;

  @override
  void initState(){
    super.initState();
    fetchStats();
  }
  
  
  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  Future<void> fetchStats() async{
    try{
      final response = await ApiServices.getRequest("/admin/level-games/stats");
      setState(() {
        stats= response;
      });

    }catch(e){
      debugPrint("Error: $e");
    }
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
                            "Levels & Rewards",
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 26,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Manage user levels and rewards",
                            style: TextStyle(
                                color: Color(0x50000000),
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(18),
                                    shadowColor: Color(0xFFF34A00),
                                    backgroundColor: Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.circular(15),

                                    )
                                  ),
                                  child: Text(
                                    "+ Add Level Pool",
                                    style: TextStyle(
                                      color: Color(0xFFF34A00)
                                    ),
                                  )
                              ),

                              const SizedBox(width: 30),

                              ElevatedButton(
                                  onPressed: (){},
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(18),
                                    backgroundColor: Color(0xFFF34A00),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusGeometry.circular(15),

                                      )
                                  ),
                                  child: Text(
                                    "+ Create Game",
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF)
                                    ),
                                  )
                              )
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 40),

                      Row(
                        children: [
                          Expanded(child: DetailsCard(svgIcon: "🏅", value: "${stats["totalGames"]}", title: "Total Levels", textColor: Color(0xFF0890B1)),),

                          const SizedBox(width: 10),

                          Expanded(child: DetailsCard(svgIcon: "👑", value: "${stats["activePools"]}", title: "VIP Members", textColor: Color(0xFFD77606)),)
                        ],
                      ),


                      Row(
                        children: [
                          Expanded(child: DetailsCard(svgIcon: "💰", value: "${stats["totalUsers"]}", title: "Rewards Paid", textColor: Color(0xFF16A24A)),),

                          const SizedBox(width: 10),

                          Expanded(child: DetailsCard(svgIcon: "📊", value: "₹${stats["totalPayouts"]}", title: "Avg Level Progress", textColor: Color(0xFF7B3AEB)),),
                        ],
                      ),
                      const SizedBox(height: 40),

                      ActiveLevel(),

                      const SizedBox(height: 40),
                      PointsConfiguration(),



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