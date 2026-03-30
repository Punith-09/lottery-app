import 'package:flutter/material.dart';
import 'package:lottery_app/core/constants/app_constants.dart';
import 'package:lottery_app/screens/drawer/app_footer.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import '../drawer/app_menu.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isMenuOpen = false;
  String searchQuery="";

  // Data for the results list
  final List<Map<String,dynamic>> results=[
    {
      "title":"Mega Millions",
      "date":"Feb 22, 2026",
      "numbers":[7,14,21,35,42],
      "special":10,
      "prize":"\$1,000,000",
      "winners":"3 winners"
    },
    {
      "title":"Super Jackpot",
      "date":"Feb 20, 2026",
      "numbers":[3,18,25,33,48],
      "special":6,
      "prize":"\$2,000,000",
      "winners":"1 winner"

    },
    {
      "title":"Power Ball",
      "date":"Feb 18, 2026",
      "numbers":[5,12,28,37,44,15],
      "special":7,
      "prize":"\$5,00,000",
      "winners":"5 winners"
    },
    {
      "title":"Lucky 7",
      "date":"Feb 18, 2026",
      "numbers":[1,7,14,21,28,7],
      "special":7,
      "prize":"\$75,000",
      "winners":"12 winners"
    },
    {
      "title":"Daily Draw",
      "date":"Feb 17, 2026",
      "numbers":[9,16,23,31,39,4],
      "special":4,
      "prize":"\$10,000",
      "winners":"45 winners"
    },
    {
      "title":"Mega Millions",
      "date":"Feb 15, 2026",
      "numbers":[2,11,24,36,49,8],
      "special":8,
      "prize":"\$1,000,000",
      "winners":"2 winners"
    },
    {
      "title":"Diamond Rush",
      "date":"Feb 14, 2026",
      "numbers":[6,13,27,34,47,19],
      "special":19,
      "prize":"\$5,000,000",
      "winners":"0 winners"
    },
    {
      "title":"Golden Wheel",
      "date":"Feb 13, 2026",
      "numbers":[4,17,22,38,43,11],
      "special":19,
      "prize":"\$150,0000",
      "winners":"8 winners"
    },


  ];

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredResults = results.where((game){
    final title=game['title'].toString().toLowerCase();
    return title.contains(searchQuery);
    }).toList();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [Color(0xFF0A0F0D), Color(0xFF0A0F0D)],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    CustomDrawer(onMenuPressed: toggleMenu),
                    const SizedBox(height: 30),

                    // Header Banner
                    _builderHeaderBanner(),
                    const SizedBox(height: 30),

                    // Search Bar
                    _buildSearchBar(),
                    const SizedBox(height: 30),

                    if (filteredResults.isNotEmpty)
                      ...filteredResults.map((data) => _buildResultCard(data)),

                    if (filteredResults.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text(
                            "No games found",
                            style: TextStyle(color: Colors.white54, fontSize: 16),
                          ),
                        ),
                      ),
                    const SizedBox(height: 40),
                    const AppFooter(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          if (isMenuOpen)
            GestureDetector(
              onTap: toggleMenu,
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
          if (isMenuOpen) AppMenu(onClose: toggleMenu),
        ],
      ),
    );
  }
 Widget _builderHeaderBanner(){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.scaffoldBg,
        border:Border.all(color: const Color(0xFF0A2E2A)),
        image: const DecorationImage(image: AssetImage('assets/result.png'),
          fit: BoxFit.cover,
          opacity: 0.6
        )
      ),
      child:const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text("Lottery\nResults", style: TextStyle(color: Colors.white,fontSize: 34,fontWeight: FontWeight.bold,)),
          SizedBox(height: 8),
          Text("View past draw results and \nwinning numbers",style: TextStyle(color:Colors.white70,fontSize:20)),
        ],
      )
    );
 }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) => setState(() => searchQuery = value),
      decoration: InputDecoration(
        hintText: "Search by game name...",
        hintStyle: const TextStyle(color: Colors.white24),
        prefixIcon: const Icon(Icons.search, color: Colors.white24),
        filled: true,
        fillColor: AppColors.scaffoldBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0A2E2A)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0A2E2A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0A2E2A), width: 2),
        ),
      ),
    );
  }

  Widget _buildResultCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
       // color: const Color(0xFF051C1A), // Dark card background
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF0A2E2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 1. TOP SECTION: Icon + (Title and Date Column)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns icon with top of Title
            children: [
              const Icon(
                  Icons.emoji_events_outlined,
                  color: AppColors.primary,
                  size: 28
              ),
              const SizedBox(width: 15),

              // This Column places the date exactly below the title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6), // Spacing between Title and Date
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, color: Colors.white30, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        data['date'],
                        style: const TextStyle(color: Colors.white30, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 35),

          // 2. MIDDLE SECTION: Winning Numbers
          Wrap(
            spacing: 10,
            children: [
              ...data['numbers'].map<Widget>((n) => _ball(n.toString(), false)),
              _ball(data['special'].toString(), true),
            ],
          ),

          const SizedBox(height: 30),

          // 3. BOTTOM SECTION: Prize and Winner Count
          Align(
            alignment: Alignment.bottomRight, // Aligns content to bottom right
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data['prize'],
                  style: const TextStyle(
                    color: AppColors.accent, // Gold color for prize
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${data['winners']}",
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
Widget _ball(String txt,bool isSpecial){
  return Container(
    width: 60, height: 60,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: isSpecial? Color(0xFF392D0A).withOpacity(1) : AppColors.card.withOpacity(1)),
      boxShadow: [
        BoxShadow(
          color: (isSpecial ? Color(0xFF392D0A) : AppColors.card).withOpacity(0.25),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Center(child: Text(txt,style: TextStyle(color: isSpecial? AppColors.accent:AppColors.primary),
      )
    ),
  );}
}