import 'package:flutter/material.dart';
import 'package:lottery_app/core/constants/app_constants.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import 'package:lottery_app/screens/levels/widgets/levels_overview.dart';
import '../drawer/app_menu.dart';
import 'package:lottery_app/screens/drawer/app_footer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  Color(0xFF0A0F0D),
                  Color(0xFF0A0F0D),
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
                      const SizedBox(height: 15),
                      CustomDrawer(onMenuPressed: toggleMenu),
                      const SizedBox(height: 2),
                      _buildBannerCard(),
                      const SizedBox(height: 25),
                      _buildLiveStatus(),
                      const SizedBox(height: 55),
                      _buildBadge(),
                      const SizedBox(height: 15),
                      _buildHeroText(),
                      const SizedBox(height: 20),
                      Text(
                        AppStrings.description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // HERO ACTION BUTTONS (CENTERED)
                      _buildHeroButtons(),

                      const SizedBox(height: 50),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset("assets/banner-3.jpeg", height: 250, width: double.infinity, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        "Featured Games",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Choose from our exciting lottery games",
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      ),

                      const SizedBox(height: 150),
                      _buildSpecialOffersSection(),

                      const SizedBox(height: 60),
                      const LevelsOverview(),

                      const SizedBox(height: 90),
                      _buildRecentWinnersSection(),

                      const SizedBox(height: 80),
                      _buildHowItWorksSection(),

                      const SizedBox(height: 80),
                      _buildCenteredHeader("Platform Statistics", "Join a thriving community of lottery enthusiasts"),
                      const SizedBox(height: 40),
                      _buildStatsGrid(),

                      const SizedBox(height: 80),
                      _buildCenteredHeader("What Our Players Say", "Trusted by thousands of satisfied players worldwide"),
                      const SizedBox(height: 40),
                      _buildTestimonialCard("Alex Thompson", "Regular Player", "Best lottery platform I've used! The interface is smooth and payouts are instant."),
                      const SizedBox(height: 20),
                      _buildTestimonialCard("Emily Chen", "Winner", "Won \$10,000 last month! The whole process was transparent and secure."),

                      const SizedBox(height: 80),
                      _buildFinalCTA(),
                      const SizedBox(height: 100),
                      Divider(
                        color: AppColors.textPrimary.withOpacity(0.1),
                        thickness: 2,
                      ),
                      const SizedBox(height: 40),

                      const AppFooter(),
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

  // --- UI HELPER METHODS ---

  Widget _buildHeroText() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2),
        children: [
          TextSpan(text: "win"),
          TextSpan(text: " Big", style: TextStyle(color: AppColors.accent)),
          TextSpan(text: " with\nLottery Network"),
        ],
      ),
    );
  }

  Widget _buildHeroButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Get Started", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 18),
            ],
          ),
        ),
        const SizedBox(width: 12),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            side: const BorderSide(color: Color(0xFF0A2E2A), width: 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text("Learn More", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ],

    );

  }

  Widget _buildSpecialOffersSection() {
    return Column(
      children: [
        const Center(
          child: Column(
            children: [
              Text("Special offers", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Text("Don't miss out on exclusive promotions", style: TextStyle(color: AppColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(height: 30),
        _buildOfferCard(
          icon: Icons.card_giftcard,
          title: "New User Bonus",
          description: "Get 100% bonus on your first deposit up to \$100",
          actionText: "Claim Now",
          onTap: () {},
        ),
        const SizedBox(height: 20),
        _buildOfferCard(
          icon: Icons.group_outlined,
          title: "Referral Rewards",
          description: "Earn \$20 for every friend you refer",
          actionText: "Invite Friends",
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildRecentWinnersSection() {
    return Column(
      children: [
        const Center(
          child: Column(
            children: [
              Text("RECENT WINNERS", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 14)),
              SizedBox(height: 10),
              Text("Celebrating Our Lucky\nWinners", textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2)),
              SizedBox(height: 15),
              Text("Join thousands of winners who've changed their lives", textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 15)),
            ],
          ),
        ),
        const SizedBox(height: 30),
        _buildWinnerCard("Sarah M.", "\$50,000", "Feb 15, 2026", "SM"),
        const SizedBox(height: 20),
        _buildWinnerCard("James K.", "\$25,000", "Feb 12, 2026", "JK"),
        const SizedBox(height: 20),
        _buildWinnerCard("Maria L.", "\$100,000", "Feb 10, 2026", "ML"),
      ],
    );
  }

  Widget _buildHowItWorksSection() {
    return Column(
      children: [
        const Center(
          child: Column(
            children: [
              Text("How It Works", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 10),
              Text("Get started in three simple steps", style: TextStyle(color: AppColors.textSecondary, fontSize: 18)),
            ],
          ),
        ),
        const SizedBox(height: 50),
        _buildStepItem(stepNumber: "01", icon: Icons.confirmation_number_outlined, title: "Purchase Tickets", description: "Choose your lottery game and buy tickets securely"),
        const SizedBox(height: 60),
        _buildStepItem(stepNumber: "02", icon: Icons.tag, title: "Select Numbers", description: "Pick your lucky numbers or use quick pick"),
        const SizedBox(height: 60),
        _buildStepItem(stepNumber: "03", icon: Icons.emoji_events_outlined, title: "Win & claim", description: "Check results and claim your prizes instantly"),
        const SizedBox(height: 60),
        Center(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF0A2E2A)),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Learn More", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  // --- COMPONENT BUILDERS ---

  Widget _buildBannerCard() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(image: AssetImage("assets/banner-2.jpeg"), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withOpacity(0.9), Colors.transparent]),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.chevron_left, color: AppColors.accent, size: 28),
                  Icon(Icons.chevron_right, color: AppColors.accent, size: 28),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Weekly Draws Every Friday", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                const Text("Never miss a chance to win with our exciting weekly lottery draws.", style: TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 12),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [_dot(false), const SizedBox(width: 5), _dot(true), const SizedBox(width: 5), _dot(false)]),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStepItem({required String stepNumber, required IconData icon, required String title, required String description}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: const Color(0xFF072421), borderRadius: BorderRadius.circular(20)),
              child: Icon(icon, color: AppColors.primary, size: 40),
            ),
            Container(
              transform: Matrix4.translationValues(8, -8, 0),
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
              child: Text(stepNumber, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
            )
          ],
        ),
        const SizedBox(height: 25),
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(description, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.5)),
        ),
      ],
    );
  }

  Widget _buildCenteredHeader(String title, String subtitle) {
    return Center(
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 1.1,
      children: [
        _buildStatCard(Icons.people_outline, "50,000+", "Active Players"),
        _buildStatCard(Icons.emoji_events_outlined, "12,500+", "Total Winners"),
        _buildStatCard(Icons.attach_money, "\$5M+", "Jackpots Won"),
        _buildStatCard(Icons.trending_up, "25%", "Win Rate"),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF051C1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF0A2E2A)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.accent, size: 28),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(color: AppColors.accent, fontSize: 22, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String name, String role, String text) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF051C1A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF0A2E2A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: List.generate(5, (i) => const Icon(Icons.star, color: AppColors.accent, size: 20))),
          const SizedBox(height: 20),
          Text('"$text"', style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5)),
          const SizedBox(height: 25),
          Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          Text(role, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildFinalCTA() {
    return Center(
      child: Column(
        children: [
          const Text("Ready to Change Your Life?", textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2)),
          const SizedBox(height: 15),
          const Text("Join our community today and start playing for your chance to win life-changing prizes.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 17, height: 1.5)),
          const SizedBox(height: 40),
          _buildHeroButtons(),
        ],
      ),
    );
  }

  Widget _buildOfferCard({required IconData icon, required String title, required String description, required String actionText, required VoidCallback onTap}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFF0F2D29), width: 1.5)),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 35),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.5)),
          const SizedBox(height: 25),
          GestureDetector(onTap: onTap, child: Text(actionText, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildWinnerCard(String name, String amount, String date, String initials) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), border: Border.all(color: const Color(0xFF0F2D29), width: 1.5)),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: const Color(0xFF0A1F1D),
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white.withOpacity(1.0), width: 1)),
              child: Center(child: Text(initials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
            ),
          ),
          const SizedBox(height: 15),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(amount, style: const TextStyle(color: AppColors.accent, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildLiveStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(color: const Color(0xFF051C1A), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF0A2E2A))),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.accent.withOpacity(0.4))),
            child: const Icon(Icons.emoji_events_outlined, color: AppColors.accent, size: 20),
          ),
          const SizedBox(width: 15),
          const Text("LIVE", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFF08241E), borderRadius: BorderRadius.circular(30), border: Border.all(color: AppColors.primary.withOpacity(0.2))),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, color: AppColors.primary, size: 18),
          SizedBox(width: 6),
          Text("Trusted Platform", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _dot(bool active) {
    return Container(
      height: 6,
      width: active ? 22 : 6,
      decoration: BoxDecoration(
        color: active ? AppColors.primary : Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}