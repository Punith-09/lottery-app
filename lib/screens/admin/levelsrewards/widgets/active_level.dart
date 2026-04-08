import 'package:flutter/material.dart';

class ActiveLevel extends StatelessWidget{
  const ActiveLevel({super.key});
  @override
  Widget build(BuildContext context) {
    return
      
      Column(
        children: [
      Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
        border: Border.all(
        color: Color(0xFF000000)
          ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
    ),
    child: Text(
    "Active Level Pools",
    style: TextStyle(
    color: Color(0xFF000000),
    fontWeight: FontWeight.bold,
      fontSize: 20
    ),
    ),
    ),
          Container(
            height: 100,
            width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF000000)
            ),

           borderRadius: BorderRadius.only(
             bottomLeft: Radius.circular(10),
             bottomRight: Radius.circular(10)
           )

          ),
          child: Text("No active pools found")
          )
        ],
      );
      
   
  }
}