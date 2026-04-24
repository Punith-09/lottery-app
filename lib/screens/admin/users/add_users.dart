import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/draws/widgets/details_card.dart';
import 'package:lottery_app/screens/admin/users/widgets/user_filterbar.dart';
import 'package:lottery_app/screens/admin/users/widgets/users_list.dart';
import 'package:lottery_app/services/api_services.dart';
import '../drawer/admin_drawer.dart';
import '../drawer/drawer_menu.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {

  bool isMenuOpen = false;


  // @override
  // void initState() {
  //   super.initState();
  //
  // }


  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController referralController = TextEditingController();

  bool loading = false;
  String error = "";
  String success = "";

  Future<void> Create() async {
    setState(() {
      loading = true;
      error = "";
      success = "";
    });

    try {
      final data = await ApiServices.postRequest(
        "/auth/register",
        {
          "name": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "phone": phoneController.text,
          "referralCode": referralController.text,
          "level_id": 1,
          "country_id": 1,
        },
      );


      if (data["success"] == true) {
        setState(() {
          success = "Account created successfully";
        });

        await Future.delayed(const Duration(seconds: 2));

        Navigator.pushReplacementNamed(context, "/users");
      } else {
        setState(() {
          error = data["message"] ?? "Creating user failed";
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString().replaceAll("Exception:", "");
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Widget inputField(TextEditingController controller, String hint,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xFFFFFFFF),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
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
                            "Create Users",
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 26,
                                fontWeight: FontWeight.bold
                            ),
                          ),


                          const SizedBox(height: 15),
                          inputField(usernameController, "Username"),
                          const SizedBox(height: 10),


                          inputField(emailController, "Email"),
                          const SizedBox(height: 10),

                          inputField(phoneController, "Phone"),
                          const SizedBox(height: 10),

                          inputField(passwordController, "Password",
                              isPassword: true),
                          const SizedBox(height: 10),

                          inputField(
                              referralController, "Referral Code (Optional)"),

                          const SizedBox(height: 15),


                          SizedBox(
                            width: double.infinity,
                            height: 60 ,
                            child: ElevatedButton(
                              onPressed: loading ? null : Create,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF3C418),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                loading ? "Creating..." : "Create User",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),


                      const SizedBox(height: 260),

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