import 'package:flutter/material.dart';
import 'package:lottery_app/services/api_services.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController referralController = TextEditingController();

  bool loading = false;
  String error = "";
  String success = "";

  Future<void> signup() async {
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

        Navigator.pushReplacementNamed(context, "/login");
      } else {
        setState(() {
          error = data["message"] ?? "Signup failed";
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
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xFF27272A),
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
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFF18181B),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),


                if (success.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      success,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),


                if (error.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

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
                    onPressed: loading ? null : signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00C850),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      loading ? "Creating..." : "Create Account",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}