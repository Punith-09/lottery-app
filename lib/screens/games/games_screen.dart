import 'package:flutter/material.dart';
import 'package:lottery_app/core/constants/app_constants.dart';
import 'package:lottery_app/screens/drawer/app_footer.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import '../drawer/app_menu.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  bool isMenuOpen = false;
  String selectedCategory = "All";

  // 1. Full Games List
  final List<Map<String, dynamic>> allGames = [
    {
      "title": "Mega Millions",
      "amount": "\$1,00,000",
      "category": "Jackpot",
      "players": "12,450",
      "odds": "1:1.2M",
      "badge": "Featured",
    },
    {
      "title": "Super Jackpot",
      "amount": "\$2,000,000",
      "category": "Jackpot",
      "players": "25,100",
      "odds": "1:25M",
      "badge": "Featured",
    },
    {
      "title": "Power Ball",
      "amount": "\$500,000",
      "category": "Jackpot",
      "players": "45,000",
      "odds": "1:11M",
      "badge": "jackpot",
    },
    {
      "title": "Lucky 7",
      "amount": "\$75,000",
      "category": "Daily",
      "players": "18,700",
      "odds": "1:2M",
      "badge": "daily",
    },
    {
      "title": "Daily Draw",
      "amount": "\$10,000",
      "category": "Daily",
      "players": "89,000",
      "odds": "1:100K",
      "badge": "daily",
    },
    {
      "title": "Diamond Rush",
      "amount": "\$5,000,000",
      "category": "Premium",
      "players": "15,200",
      "odds": "1:50M",
      "badge": "Featured",
    },
    {
      "title": "Golden Wheel",
      "amount": "\$150,000",
      "category": "Special",
      "players": "18,700",
      "odds": "1:2M",
      "badge": "special",
    },
    {
      "title": "Flash Lottery",
      "amount": "\$5,000",
      "category": "Instant",
      "players": "5,400",
      "odds": "1:500",
      "badge": "instant",
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {"label": "All", "icon": Icons.auto_awesome},
    {"label": "Jackpot", "icon": Icons.emoji_events_outlined},
    {"label": "Daily", "icon": Icons.calendar_month_outlined},
    {"label": "Premium", "icon": Icons.workspace_premium_outlined},
    {"label": "Special", "icon": Icons.star_border_outlined},
    {"label": "Instant", "icon": Icons.bolt_outlined},
  ];

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Logic: If 'All', show Featured games. Otherwise filter by category.
    List<Map<String, dynamic>> displayedGames = selectedCategory == "All"
        ? allGames.where((game) => game['badge'] == "Featured").toList()
        : allGames.where((game) => game['category'] == selectedCategory).toList();

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
                            Text("All Games", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(height: 10),
                            Text("Choose from 8 exciting lottery games", textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 18)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                      _buildCategoryFilters(),
                      const SizedBox(height: 50),

                      // DYNAMIC SECTION HEADER
                      Row(
                        children: [
                          Icon(
                              selectedCategory == "All" ? Icons.stars : Icons.auto_awesome,
                              color: AppColors.accent,
                              size: 28
                          ),
                          const SizedBox(width: 10),
                          Text(
                            selectedCategory == "All" ? "Featured Games" : "$selectedCategory Games",
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),

                      // DYNAMIC SUBTEXT (Only displays for "All")
                      if (selectedCategory == "All")
                        const Text(
                          "Our most popular lottery games with massive jackpots",
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                        ),

                      const SizedBox(height: 30),

                      // 3. Dynamic Game Cards
                      ...displayedGames.map((game) => Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: _buildGameCard(game),
                      )),

                      const SizedBox(height: 80),
                    //  _buildFinalCTA(), // Restored the CTA section
                      const SizedBox(height: 40),
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

  Widget _filterChip(String label, IconData icon, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isActive ? AppColors.primary : const Color(0xFF0A2E2A)),
        boxShadow: isActive ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 10)] : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: isActive ? Colors.black : Colors.white),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF051C1A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF0A2E2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0XFF072421), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.emoji_events_outlined, color: AppColors.accent),
                  ),
                  const SizedBox(width: 15),
                  Text(game['title'], style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              _buildBadge(game['badge']),
            ],
          ),
          const SizedBox(height: 30),
          Text(game['amount'], style: const TextStyle(color: AppColors.accent, fontSize: 40, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          const Text("NEXT DRAW", style: TextStyle(color: Colors.white70, letterSpacing: 1.2, fontSize: 12)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _timeBox("00", "Days"),
              _timeBox("00", "Hrs"),
              _timeBox("00", "Min"),
              _timeBox("00", "Sec"),
            ],
          ),
          const SizedBox(height: 25),
          const Divider(color: Colors.white10),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.people_outline, color: Colors.white54, size: 18),
                  const SizedBox(width: 5),
                  Text("${game['players']} players", style: const TextStyle(color: Colors.white54)),
                ],
              ),
              Text("Odds: ${game['odds']}", style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("Play Now", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          )
        ],
      ),
    );
  }

  Widget _timeBox(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF072421),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          ),
          child: Text(value, style: const TextStyle(color: AppColors.primary, fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }

  Widget _buildBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.star, color: AppColors.primary, size: 14),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}