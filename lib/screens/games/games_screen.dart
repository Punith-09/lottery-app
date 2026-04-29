import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottery_app/core/constants/app_constants.dart';
import 'package:lottery_app/screens/drawer/app_footer.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import 'package:lottery_app/screens/drawer/login_required_dialog.dart';
import 'package:provider/provider.dart';
import '../../providers/login_provider.dart';
import '../drawer/app_menu.dart';
import 'package:lottery_app/services/api_services.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  bool isMenuOpen = false;
  String selectedCategory = "All";

  List<Map<String, dynamic>> allGames = [];
  bool isLoading = true;

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "icon": Icons.auto_awesome},
    {"label": "Jackpot", "icon": Icons.emoji_events_outlined},
    {"label": "Daily", "icon": Icons.calendar_month_outlined},
    {"label": "Premium", "icon": Icons.workspace_premium_outlined},
    {"label": "Special", "icon": Icons.star_border_outlined},
    {"label": "Instant", "icon": Icons.bolt_outlined},
  ];

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  Future<void> fetchGames() async {
    try {
      final response = await ApiServices.getRequest("/draws");

      debugPrint("API RESPONSE: $response");

      if (response['success']) {
        List data = response['data'];

        setState(() {
          allGames = data.map<Map<String, dynamic>>((game) {
            return {
              "title": game['name'],
              "amount": "₹${game['prizePool']}",
              "players": game['currentEntries'],
              "odds": "1 in ${game['maxEntries']}",
              "price": game['ticketPrice'],
              "badge": game['isGuaranteed'] ? "Featured" : "Hot",
              "category": _mapCategory(game['gameTypeName']),
            };
          }).toList();

          isLoading = false;
        });

        debugPrint("ALL GAMES: $allGames");
      }
    } catch (e) {
      debugPrint("Error fetching games: $e");
      setState(() => isLoading = false);
    }
  }


  String _mapCategory(String type) {
    switch (type) {
      case "Mega Millions":
        return "Jackpot";
      case "Daily":
        return "Daily";
      case "Premium":
        return "Premium";
      default:
        return "Special";
    }
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> displayedGames = selectedCategory == "All"
        ? allGames
        : allGames
        .where((game) => game['category'] == selectedCategory)
        .toList();

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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      CustomDrawer(onMenuPressed: toggleMenu),
                      const SizedBox(height: 40),

                      const Center(
                        child: Column(
                          children: [
                            Text("All Games",
                                style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            SizedBox(height: 10),
                            Text(
                              "Choose from exciting lottery games",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 35),
                      _buildCategoryFilters(),
                      const SizedBox(height: 50),

                      Row(
                        children: [
                          Icon(
                            selectedCategory == "All"
                                ? Icons.stars
                                : Icons.auto_awesome,
                            color: AppColors.accent,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            selectedCategory == "All"
                                ? "Featured Games"
                                : "$selectedCategory Games",
                            style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ✅ FIXED ALIGNMENT
                      if (isLoading)
                        const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (displayedGames.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "No Games Found",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        )
                      else
                        Column(
                          children: displayedGames
                              .map((game) => Padding(
                            padding:
                            const EdgeInsets.only(bottom: 25),
                            child: _buildGameCard(game),
                          ))
                              .toList(),
                        ),

                      const SizedBox(height: 100),
                      Divider(
                        color: AppColors.textPrimary.withOpacity(0.1),
                        thickness: 2,
                      ),
                      const SizedBox(height: 40),
                      const AppFooter(),
                      const SizedBox(height: 40),
                    ],
                  ),
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

  Widget _buildCategoryFilters() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 12,
      children: categories.map((cat) {
        bool isActive = selectedCategory == cat["label"];
        return GestureDetector(
          onTap: () => setState(() => selectedCategory = cat["label"]),
          child: _filterChip(cat["label"], cat["icon"], isActive: isActive),
        );
      }).toList(),
    );
  }

  Widget _filterChip(String label, IconData icon,
      {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color:
            isActive ? AppColors.primary : const Color(0xFF0A2E2A)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 18, color: isActive ? Colors.black : Colors.white),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  color: isActive ? Colors.black : Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0F0D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF0A2E2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF09271D),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: SvgPicture.asset(
                  "assets/trophy.svg",
                  width: 28,
                  height: 28,
                  color: Color(0xFFFDB700),
                ),
              ),
              const SizedBox(width: 10),
              Text(game['title'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ],
          ),

          const SizedBox(height: 20),
          Text(game['amount'],
              style: const TextStyle(
                  color: AppColors.accent,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text(
            "NEXT DRAW",
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _timerBox("00", "Days"),
              const SizedBox(width: 10),
              _timerBox("00", "Hrs"),
              const SizedBox(width:10),
              _timerBox("00", "Min"),
              const SizedBox(width: 10),
              _timerBox("00", "Sec"),


            ],
          ),

          const SizedBox(height: 15),
          Divider(color: Color(0x50FFFFFF)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/users.svg",
                    height: 16,
                    width: 16,
                    color: Color(0xFF8EA8A1),
                  ),
                  const SizedBox(width: 10),
                  Text("${game['players']} players",
                      style: const TextStyle(
                          color: Colors.white,
                        fontWeight: FontWeight.bold
                      )),
                ],
              ),
              
              // const SizedBox(width: 20),
              Text("Odds: ${game['odds']}",
                  style: const TextStyle(
                      color: AppColors.primary,
                    fontWeight: FontWeight.bold
                  )),
            ],
          ),

          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (!authProvider.isLoggedIn) {
                  showLoginRequiredDialog(context);
                  // Navigator.pushNamed(context, "/loginDialogue");
                } else {

                  Navigator.pushNamed(
                    context,
                    "/",
                    // arguments: {
                    //   "game": game,
                    //   "userId": authProvider.userid,
                    // },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00FDA2),
                foregroundColor: Colors.black,
              ),
              child: Text("Play - ${game['price']} "),
            ),
          )
        ],
      ),
    );
  }
}


Widget _timerBox(String count,String title){
  return
  Column(
    children: [
  Container(
  padding: EdgeInsets.all(15),
  decoration: BoxDecoration(
  color: Color(0xFF0A0F0D),
  borderRadius: BorderRadius.circular(15),
  border: Border.all(
  color: Color(0xFF083A28)
  )
  ),
  child: Text(
  count,
  style: TextStyle(
  color: Color(0xFF00FDA2),
    fontWeight: FontWeight.bold,
    fontSize: 18
  ),
  ),
  ),

      const SizedBox(height: 6),
      Text(
        title,
        style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
            fontSize: 13
        ),
      )
    ],
  );


}