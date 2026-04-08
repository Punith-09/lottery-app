import 'package:flutter/material.dart';
import 'package:lottery_app/services/api_services.dart';
import 'package:lottery_app/services/api_services.dart';


class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  bool isLoading = false;

  Future<void> loginAdmin() async{
    setState(() {
      isLoading=true;
    });
    try{
      final response = await ApiServices.postRequest("/admin/admin-login", {
        "email":emailController.text.trim(),
        "password":passwordController.text.trim(),
      },);
      print("Login Success:$response");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Successful")),
      );
      Navigator.pushNamed(context, '/dashboard');
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed: $e")),);
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      body: Center(
        child: Container(
          width: 360,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 18,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Title
              const Text(
                "Admin Login",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000000)
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Sign in to access dashboard",
                style: TextStyle(color: Color(0x85000000)),
              ),

              const SizedBox(height: 22),

              /// Email
              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                    "Email",
                  style: TextStyle(
                    color: Color(0xFF000000)
                  ),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "user@gmail.com",

                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: const Text(
                    "Password",
                  style: TextStyle(
                    color: Color(0xFF011001)
                  ),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: passwordController,
                style: const TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  filled: true,
                  fillColor: const Color(0xFFFFFFFF),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: isLoading? null :loginAdmin,
                  child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),

                  )
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}