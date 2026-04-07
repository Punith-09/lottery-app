import 'package:flutter/material.dart';
class NewCategory extends StatefulWidget {
  const NewCategory({super.key});

  @override
  State<NewCategory> createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Create New Category",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),
              ),
              const SizedBox(height: 20,),
              const Text("Name *",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  hintText: "e.g Mega Millions",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              const Text("Description",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Brief description of the game type",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),

                  )
                ),
              ),
              const SizedBox(height: 15),
              const Text("Icon(Emoji)",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                height: 60,
                width: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Text("🎮", style: TextStyle(fontSize: 24)),
              ),
              //const Spacer(),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                  ),
                    onPressed: (){},
                    child: const Text("+Add Category",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,)),
              )


              )],
          ),
        );
  }
}
