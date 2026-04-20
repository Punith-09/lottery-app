import 'package:flutter/material.dart';

class WithdrawDetails extends StatefulWidget{
  const WithdrawDetails({super.key});

  @override
  State<WithdrawDetails> createState()=> _WithdrawDetailsState();
}

class _WithdrawDetailsState extends State<WithdrawDetails>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFF101828)
      ),
      child: Row(
        
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Available",
                style: TextStyle(
                  color: Color(0x85FFFFFF),
                  fontSize: 14
                ),
              ),
              Text(
                "₹0",
                style: TextStyle(
                  color: Color(0xFF05DD71),
                  fontSize: 18
                ),
              )
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Locked",
                style: TextStyle(
                  color: Color(0x85FFFFFF)
                ),
              ),
              Text(
                "₹0",
                style: TextStyle(
                  color: Color(0xFFAFAFAF),
                  fontSize: 18
                ),
              )
            ],
          ),
          const SizedBox(width: 20),
          ElevatedButton(
              onPressed: (){},
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEEB000),
                foregroundColor: Color(0xFF000000),

                padding: EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  left: 30,
                  right: 30
                ),
              ),
              child: Text(
                "Withdraw "
              )
          )
        ],
      ),
    );
  }
}