import 'package:flutter/material.dart';
class ExistingCategoriesWidget extends StatefulWidget {
  const ExistingCategoriesWidget({super.key});

  @override
  State<ExistingCategoriesWidget> createState() => _ExistingCategoriesWidgetState();
}

class _ExistingCategoriesWidgetState extends State<ExistingCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color:Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Padding(padding: EdgeInsetsGeometry.only(left:5)),
                    const Text("Existing Categories",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    Chip(
                      backgroundColor: const Color(0xFFEFF6FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // optional
                        side: const BorderSide(
                          color: Colors.white, // ✅ white border
                          width: 1,
                        ),
                      ),
                      label: const Text(
                        "Total: 0",
                        style: TextStyle(
                          color: Color(0xFF1D4ED8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    ,
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    Padding(padding: EdgeInsets.only(left: 10)),
                    SizedBox(width: 100, child: Text("ICON",style: TextStyle(color: Colors.black38),)),
                    SizedBox(width: 120, child: Text("NAME",style: TextStyle(color: Colors.black38),)),
                    SizedBox(width: 150, child: Text("DESCRIPTION",style: TextStyle(color: Colors.black38),)),
                    SizedBox(width: 120, child: Text("STATUS",style: TextStyle(color: Colors.black38),)),
                    SizedBox(width: 150, child: Text("DATE CREATED",style: TextStyle(color: Colors.black38),)),
                  ],
                ),
              ),

              const Divider(height: 30,),
              const Center(
                child: Text("No categories found. Start by adding one."),
              ),
            ],
          ),
        );
  }
}
