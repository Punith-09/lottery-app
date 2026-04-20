import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottery_app/providers/login_provider.dart';
import '../../services/api_services.dart';
import '../drawer/app_footer.dart';
import '../drawer/app_menu.dart';
import '../drawer/custom_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isMenuOpen = false;
  bool isEditing = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String roleValue = "";

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  void initState() {
    super.initState();


    Future.delayed(Duration.zero, () {
      final auth = Provider.of<AuthProvider>(context, listen: false);

      usernameController.text = auth.username;
      emailController.text = auth.email;
      roleValue = auth.role;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> updateProfile() async {
    try {
      final response = await ApiServices.putRequest(
        "/auth/update",
        {
          "username": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "role": roleValue,
        },
      );

      if (response['success'] == true) {

        final auth = Provider.of<AuthProvider>(context, listen: false);

        auth.login(
          username: usernameController.text,
          email: emailController.text,
          role: roleValue,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );

        setState(() {
          isEditing = false;
          passwordController.clear();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Update failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
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

                      const SizedBox(height: 30),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Profile",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Manage your account information",
                                style: TextStyle(color: Colors.white54),
                              ),
                            ],
                          ),


                          // Row(
                          //   children: [
                          //     if (!isEditing)
                          //       ElevatedButton(
                          //         onPressed: () {
                          //           setState(() => isEditing = true);
                          //         },
                          //         style: ElevatedButton.styleFrom(
                          //           backgroundColor: Colors.blue,
                          //         ),
                          //         child: const Text("Edit"),
                          //       ),
                          //   ],
                          // ),
                        ],
                      ),

                      const SizedBox(height: 30),


                      buildField(
                        label: "Username",
                        controller: usernameController,
                        enabled: isEditing,
                      ),

                      const SizedBox(height: 20),


                      buildField(
                        label: "Email",
                        controller: emailController,
                        enabled: isEditing,
                      ),

                      const SizedBox(height: 20),


                      buildField(
                        label: "Role",
                        controller: TextEditingController(text: roleValue),
                        enabled: false,
                      ),

                      const SizedBox(height: 20),


                      buildField(
                        label: "Password",
                        controller: passwordController,
                        enabled: isEditing,
                        hint: "Enter new password",
                        obscure: true,
                      ),

                      const SizedBox(height: 20),

                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (!isEditing)
                            ElevatedButton(

                              onPressed: () {
                                setState(() => isEditing = true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text("Edit"),
                            ),
                        ],
                      ),

                      if (isEditing) ...[
                        ElevatedButton(
                          onPressed: updateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text("Update"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => isEditing = false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                          ),
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 10),
                      ],

                      const SizedBox(height: 80),

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


  Widget buildField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
    String? hint,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: enabled,
          obscureText: obscure,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF1A1F1D),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
