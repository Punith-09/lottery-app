import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class UserwalletDetails extends StatelessWidget{
  const UserwalletDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: Color(0xFF0D1915),
            borderRadius: BorderRadiusGeometry.circular(15),
            border: Border.all(
              color: Color(0xFF1F3D32)
            )
          ),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/wallet.svg",
                    width: 16,
                    height: 16,
                    color: Color(0xFF069B6C),

                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 16
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "\$1,480.00",
                style: TextStyle(
                  color: Color(0xFFFBC600),
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),


              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00BB7C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(15)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          const SizedBox(width: 26),
                          Text(
                            "Add\nFunds",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1C2B26),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(20)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/credit-card.svg",
                            width: 16,
                            height: 16,
                            color: Color(0xFFFFFFFF),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Withdraw",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 26),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Color(0xFF0D1915),
              borderRadius: BorderRadiusGeometry.circular(15),
              border: Border.all(
                  color: Color(0xFF1F3D32)
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/trending-up.svg",
                    width: 16,
                    height: 16,
                    color: Color(0xFF00D391),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Total won",
                    style: TextStyle(
                      color: Color(0xFF00D391),
                      fontSize: 16
                    ),
                  )
                ],
              ),
              Text(
                "\$2,500.00",
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 26),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Color(0xFF0D1915),
              borderRadius: BorderRadiusGeometry.circular(15),
              border: Border.all(
                  color: Color(0xFF1F3D32)
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/credit-card.svg",
                    width: 16,
                    height: 16,
                    color: Color(0xFFFBC600),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Credits Used",
                    style: TextStyle(
                        color: Color(0xFFFBC600),
                        fontSize: 16
                    ),
                  )
                ],
              ),
              Text(
                "3,450",
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

