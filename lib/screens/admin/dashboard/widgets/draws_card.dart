// import 'package:flutter/material.dart';
// import 'package:lottery_app/services/api_services.dart';
//
// class DrawsCard extends StatefulWidget {
//   const DrawsCard({super.key});
//
//   @override
//   State<DrawsCard> createState() => _DrawsCardState();
// }
//
// class _DrawsCardState extends State<DrawsCard> {
//   Map<String, dynamic>? liveDraw;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchLiveDraw();
//   }
//
//   Future<void> fetchLiveDraw() async {
//     try {
//       final response = await ApiServices.getRequest("/draws");
//
//       if (response['success']) {
//         List data = response['data'];
//
//         // 🔥 Find LIVE draw (or fallback first)
//         final draw = data.firstWhere(
//               (d) => d['isLive'] == true,
//           orElse: () => data.isNotEmpty ? data[0] : null,
//         );
//
//         if (draw != null) {
//           setState(() {
//             liveDraw = {
//               "title": draw['name'],
//               "amount": draw['prizePool'],
//               "entries": draw['currentEntries'],
//               "maxEntries": draw['maxEntries'],
//             };
//             isLoading = false;
//           });
//         }
//       }
//     } catch (e) {
//       debugPrint("Error: $e");
//       setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (liveDraw == null) {
//       return const Text("No Active Draw");
//     }
//
//     return Container(
//       padding: const EdgeInsets.all(20),
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade300),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 🔴 LIVE + TIMER
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFCE0E0),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: Color(0xFFFAA4A4)
//                   )
//                 ),
//                 child: const Text(
//                   "● LIVE",
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const Text(
//                 "00:00:00", // you can replace with timer later
//                 style: TextStyle(color: Color(0xFF000000)),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 15),
//
//           // 🎯 TITLE
//           Text(
//             liveDraw!['title'],
//             style: const TextStyle(
//               color: Color(0xFF000000),
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//
//           const SizedBox(height: 10),
//
//           // 💰 AMOUNT
//           Text(
//             "₹${liveDraw!['amount']}",
//             style: const TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: Colors.orange,
//             ),
//           ),
//
//           const SizedBox(height: 15),
//
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // 🟢 ENTRIES
//               Container(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFDAFAE5),
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: Color(0xFF85EDAB)
//                   )
//                 ),
//                 child: Text(
//                   "${liveDraw!['entries']} entries",
//                   style: const TextStyle(
//                     color: Color(0xFF16A24A),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//
//               // const SizedBox(height: 10),
//
//               // 📊 MAX ENTRIES
//               Text(
//                 "Max: ${liveDraw!['maxEntries']}",
//                 style: const TextStyle(
//                   color: Color(0xFF000000),
//                 ),
//               ),
//             ],
//           ),
//
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:lottery_app/services/api_services.dart';

class DrawsCard extends StatefulWidget {
  const DrawsCard({super.key});

  @override
  State<DrawsCard> createState() => _DrawsCardState();
}

class _DrawsCardState extends State<DrawsCard> {
  List<Map<String, dynamic>> draws = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDraws();
  }

  Future<void> fetchDraws() async {
    try {
      final response = await ApiServices.getRequest("/draws");

      if (response['success']) {
        List data = response['data'];

        setState(() {
          draws = data.map<Map<String, dynamic>>((draw) {
            return {
              "title": draw['name'],
              "amount": draw['prizePool'],
              "entries": draw['currentEntries'],
              "maxEntries": draw['maxEntries'],
              "isLive": draw['isLive'] ?? false,
            };
          }).toList();

          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (draws.isEmpty) {
      return const Text("No Draws Found");
    }

    return Column(
      children: draws.map((draw) => _buildCard(draw)).toList(),
    );
  }

  Widget _buildCard(Map<String, dynamic> draw) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔴 LIVE badge (only if live)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // if (draw['isLive'])
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xFFFAA4A4)
                    )
                  ),
                  child: const Text(
                    "● LIVE",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              // else
              //   const SizedBox(),

              const Text(
                "00:00:00",
                style: TextStyle(color: Color(0xFF000000)),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            draw['title'],
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold,color: Color(0xFF000000)),
          ),

          const SizedBox(height: 10),

          Text(
            "₹${draw['amount']}",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),

          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFDAFAE5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFF85EDAB)
                  )
                ),
                child: Text(
                  "${draw['entries']} entries",
                  style: const TextStyle(color: Colors.green),
                ),
              ),

              // const SizedBox(height: 10),

              Text(
                "Max: ${draw['maxEntries']}",
                style: const TextStyle(color: Color(0xFF000000)),
              ),
            ],
          ),

        ],
      ),
    );
  }
}