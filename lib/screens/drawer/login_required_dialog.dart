import 'package:flutter/material.dart';

void showLoginRequiredDialog(BuildContext context){
  showDialog(
      context: context,
      builder: (context){
    return Dialog(
      backgroundColor: const Color(0xFF0D1915),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: ()=>Navigator.pop(context),
                child: const Icon(Icons.close,color: Colors.grey,),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF00D391).withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.lock,
                color: Color(0xFF00D391),
                size: 40,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Wallet Access Restricted",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Please sign in to your account to add funds,withdraw, or participate in premium levels. ",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D391),
                  minimumSize: const Size(double.infinity,50),
                ),
                child: const Text(
              "Sign In Now",
                  style: TextStyle(color: Colors.black),
            ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(onPressed: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/signup");
            },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Create Free Account",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(

              onPressed: ()=>Navigator.pop(context),
              child: const Text(
                "Maybe later",
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  });
}