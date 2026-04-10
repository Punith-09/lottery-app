import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/categories/widgets/exisiting_categorey.dart';
import 'package:lottery_app/screens/admin/categories/widgets/new_category.dart';
import 'package:lottery_app/screens/admin/drawer/admin_drawer.dart';
import 'package:lottery_app/screens/admin/drawer/drawer_menu.dart';
import 'package:lottery_app/services/api_services.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool isMenuOpen = false;
  List categories = [];
  bool isLoading = true;

  void toggleMenu() => setState(() => isMenuOpen = !isMenuOpen);

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await ApiServices.getRequest("/categories");

      // Debug: This will print the actual type and content to your console
      debugPrint("Type of response: ${response.runtimeType}");
      debugPrint("Response Content: $response");

      if (!mounted) return;

      setState(() {
        if (response != null && response['data'] != null) {
          // If it follows your JSON: { "data": [...] }
          categories = response['data'];
        } else if (response is List) {
          // If it's a direct list: [...]
          categories = response;
        } else {
          categories = [];
        }
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Fetch Error: $e");
      if (!mounted) return;
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  AdminDrawer(onMenuPressed: toggleMenu),
                  const SizedBox(height: 20),
                  const Text(
                    "Game Categories",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Manage lottery game types and their metadata.",
                    style: TextStyle(color: Colors.black54, fontSize: 14,),
                  ),
                  const SizedBox(height: 20),

                  const NewCategory(),
                  const SizedBox(height: 20),

                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ExistingCategoriesWidget(categories: categories),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          if (isMenuOpen) ...[
            GestureDetector(
              onTap: toggleMenu,
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),
            DrawerMenu(onClose: toggleMenu),
          ]
        ],
      ),
    );
  }
}