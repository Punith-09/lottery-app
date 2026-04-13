import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:lottery_app/core/constants/app_constants.dart';
import 'package:lottery_app/screens/drawer/app_footer.dart';
import 'package:lottery_app/screens/drawer/custom_drawer.dart';
import '../drawer/app_menu.dart';
import 'package:lottery_app/services/api_services.dart';
import 'package:lottery_app/screens/results/draw_result_model.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool isMenuOpen = false;
  String searchQuery = "";
  String selectedFilter = "All Draws";

  // API State Variables
  List<DrawResult> allResults = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchDrawResults();
  }

  Future<void> fetchDrawResults() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final response = await ApiServices.getRequest("/draw-results");

      if (response['success'] == true) {
        final List dataList = response['data'];
        setState(() {
          allResults = dataList.map((json) => DrawResult.fromJson(json)).toList();
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Full API Error: $e");
      setState(() {
        errorMessage = "Failed to load results. Please try again.";
        isLoading = false;
      });
    }
  }

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Computed list based on search and filter
    final filteredResults = allResults.where((game) {
      final titleMatch = game.drawName.toLowerCase().contains(searchQuery.toLowerCase());
      final filterMatch = selectedFilter == "All Draws" || game.gameTypeName == selectedFilter;
      return titleMatch && filterMatch;
    }).toList();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Color(0xFF0A0F0D)),
            child: SafeArea(
              child: RefreshIndicator(
                onRefresh: fetchDrawResults,
                color: AppColors.primary,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: CustomDrawer(onMenuPressed: toggleMenu),
                      ),

                      // Header Section
                      _buildHeader(),

                      const SizedBox(height: 24),

                      // Search Bar
                      _buildSearchBar(),

                      const SizedBox(height: 16),

                      // Filter Buttons
                      _buildFilterRow(),

                      const SizedBox(height: 28),

                      // API Content Logic
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _buildMainContent(filteredResults),
                      ),

                      const SizedBox(height: 40),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: AppFooter(),
                      ),
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

  Widget _buildMainContent(List<DrawResult> filteredResults) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(errorMessage!, style: const TextStyle(color: Colors.redAccent)),
        ),
      );
    }

    if (filteredResults.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text("No games found", style: TextStyle(color: Color(0xFF5A6B65), fontSize: 15)),
        ),
      );
    }

    return Column(
      children: filteredResults.map((data) => _buildResultCard(data)).toList(),
    );
  }

  Widget _buildResultCard(DrawResult data) {
    final formattedDate = DateFormat('dd MMM yyyy').format(data.drawDate);
    final prizeAmount = "₹${NumberFormat('#,##,###').format(double.parse(data.prizePool))}";
    final paidAmount = "₹${NumberFormat('#,##,###').format(double.parse(data.totalPrizePaid))}";

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1A2420), width: 1),
        color: const Color(0xFF0F1612),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2420),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(child: Icon(Icons.emoji_events_outlined, color: AppColors.primary, size: 22)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.drawName.toUpperCase(),
                      style: const TextStyle(color: Color(0xFFB8C5C0), fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: 0.8),
                    ),
                    const SizedBox(height: 10),
                    Text(data.drawName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, color: Color(0xFF5A6B65), size: 13),
                        const SizedBox(width: 6),
                        Text(formattedDate, style: const TextStyle(color: Color(0xFF5A6B65), fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text("Result ID: ${data.id.substring(0, 8)}...", style: const TextStyle(color: Color(0xFF3A4844), fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12, runSpacing: 12,
            children: [
              ...data.winningNumbers.map((n) => _buildNumberBall(n.toString(), false)),
              _buildNumberBall(data.specialNumber.toString(), true),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Winners", style: TextStyle(color: Color(0xFF5A6B65), fontSize: 12)),
                  Text(data.winnersCount.toString(), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  const Text("Paid", style: TextStyle(color: Color(0xFF5A6B65), fontSize: 12)),
                  Text(paidAmount, style: const TextStyle(color: AppColors.accent, fontSize: 14, fontWeight: FontWeight.w700)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("JACKPOT", style: TextStyle(color: Color(0xFF5A6B65), fontSize: 11, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(prizeAmount, style: const TextStyle(color: AppColors.accent, fontSize: 24, fontWeight: FontWeight.w700)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberBall(String number, bool isSpecial) {
    return Container(
      width: 50, height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: isSpecial ? AppColors.accent : AppColors.primary, width: 2),
        color: isSpecial ? const Color(0xFF2D2410) : const Color(0xFF0A2E2A),
      ),
      child: Center(
        child: Text(number, style: TextStyle(color: isSpecial ? AppColors.accent : AppColors.primary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // UI Helpers (Extracted for cleanliness)
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 20, height: 20, decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary), child: const Icon(Icons.check, size: 12)),
              const SizedBox(width: 10),
              const Text("Latest Draw Results", style: TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 16),
          const Text("Celebrate the Winners", style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        onChanged: (v) => setState(() => searchQuery = v),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search by draw name...",
          hintStyle: const TextStyle(color: Color(0xFF5A6B65)),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF5A6B65)),
          filled: true, fillColor: const Color(0xFF0F1612),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: ["All Draws", "Mega Millions", "Super Jackpot"].map((filter) {
          final isSelected = selectedFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => selectedFilter = filter),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? AppColors.primary : const Color(0xFF1A2420)),
              ),
              child: Text(filter, style: TextStyle(color: isSelected ? Colors.black : Colors.white70, fontSize: 12)),
            ),
          );
        }).toList(),
      ),
    );
  }
}