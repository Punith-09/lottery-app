// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class LevelGameSection extends StatefulWidget {
//   const LevelGameSection({super.key});
//
//   @override
//   State<LevelGameSection> createState() => _LevelGameSectionState();
// }
//
// class _LevelGameSectionState extends State<LevelGameSection> {
//   final String BASE_URL = "http://localhost:10000";
//
//   List<dynamic> games = [];
//   String? activeGameId;
//
//   List<dynamic> gameLevels = [];
//   Map<String, dynamic> wallet = {
//     "available": 0,
//     "locked": 0,
//   };
//
//   bool loading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchGames();
//   }
//
//   /* ================= FETCH ================= */
//
//   Future<void> fetchGames() async {
//     try {
//       final res = await http.get(Uri.parse("$BASE_URL/api/level-games"));
//       final data = jsonDecode(res.body);
//
//       setState(() {
//         games = data;
//         if (games.isNotEmpty) {
//           activeGameId = games[0]['id'];
//         }
//       });
//
//       fetchLevels();
//     } catch (e) {
//       print("Error fetching games: $e");
//     }
//   }
//
//   Future<void> fetchLevels() async {
//     if (activeGameId == null) return;
//
//     setState(() => loading = true);
//
//     try {
//       final levelsRes = await http.get(
//         Uri.parse("$BASE_URL/api/levels?levelGameId=$activeGameId"),
//       );
//
//       final walletRes =
//       await http.get(Uri.parse("$BASE_URL/api/wallet"));
//
//       setState(() {
//         gameLevels = jsonDecode(levelsRes.body);
//         wallet = jsonDecode(walletRes.body);
//       });
//     } catch (e) {
//       print("Error fetching levels: $e");
//     }
//
//     setState(() => loading = false);
//   }
//
//   /* ================= LOGIC ================= */
//
//   bool isLevelUnlocked(int levelNum, dynamic currentPool) {
//     if (levelNum <= 2) return true;
//
//     final prevPool = gameLevels.cast<Map<String, dynamic>?>().firstWhere(
//           (p) => p?['level'] == levelNum - 2,
//       orElse: () => null,
//     );
//
//     if (prevPool != null && prevPool['status'] == 'completed') {
//       return true;
//     }
//
//     if (currentPool != null && prevPool == null) {
//       return true;
//     }
//
//     return false;
//   }
//
//   /* ================= UI ================= */
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// HEADER
//         // Row(
//         //   children: const [
//         //     Icon(Icons.sports_esports,
//         //         color: Colors.amber, size: 32),
//         //     SizedBox(width: 10),
//         //     Column(
//         //       crossAxisAlignment: CrossAxisAlignment.start,
//         //       children: [
//         //         Text(
//         //           "Level Game",
//         //           style: TextStyle(
//         //               fontSize: 24,
//         //               color: Colors.white,
//         //               fontWeight: FontWeight.bold),
//         //         ),
//         //         Text(
//         //           "Join pools and earn rewards",
//         //           style: TextStyle(color: Colors.grey),
//         //         ),
//         //       ],
//         //     )
//         //   ],
//         // ),
//
//         // const SizedBox(height: 20),
//
//         /// WALLET
//         // Container(
//         //   padding: const EdgeInsets.all(12),
//         //   decoration: BoxDecoration(
//         //     color: const Color(0xFF111827),
//         //     borderRadius: BorderRadius.circular(12),
//         //   ),
//         //   child: Row(
//         //     mainAxisAlignment:
//         //     MainAxisAlignment.spaceBetween,
//         //     children: [
//         //       Column(
//         //         crossAxisAlignment:
//         //         CrossAxisAlignment.start,
//         //         children: [
//         //           const Text("Available",
//         //               style:
//         //               TextStyle(color: Colors.grey, fontSize: 12)),
//         //           Text("₹${wallet['available']}",
//         //               style: const TextStyle(
//         //                   color: Colors.green,
//         //                   fontWeight: FontWeight.bold)),
//         //         ],
//         //       ),
//         //       Column(
//         //         crossAxisAlignment:
//         //         CrossAxisAlignment.start,
//         //         children: [
//         //           const Text("Locked",
//         //               style:
//         //               TextStyle(color: Colors.grey, fontSize: 12)),
//         //           Text("₹${wallet['locked']}",
//         //               style: const TextStyle(
//         //                   color: Colors.grey,
//         //                   fontWeight: FontWeight.bold)),
//         //         ],
//         //       ),
//         //       ElevatedButton(
//         //         onPressed: () {},
//         //         style: ElevatedButton.styleFrom(
//         //             backgroundColor: Colors.amber),
//         //         child: const Text("Withdraw",
//         //             style: TextStyle(color: Colors.black)),
//         //       )
//         //     ],
//         //   ),
//         // ),
//
//         const SizedBox(height: 20),
//
//         /// DROPDOWN
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: const Color(0xFF111827),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//               dropdownColor: const Color(0xFF111827),
//               value: activeGameId,
//               hint: const Text("Select Game",
//                   style: TextStyle(color: Colors.white)),
//               icon: const Icon(Icons.arrow_drop_down,
//                   color: Colors.white),
//               items: games.map((game) {
//                 return DropdownMenuItem<String>(
//                   value: game['id'],
//                   child: Text(
//                     game['name'],
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   activeGameId = value;
//                 });
//                 fetchLevels();
//               },
//             ),
//           ),
//         ),
//
//         const SizedBox(height: 20),
//
//         /// GRID
//         loading
//             ? const Center(child: CircularProgressIndicator())
//             : GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: 10,
//           gridDelegate:
//           const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//             childAspectRatio: 0.75,
//           ),
//           itemBuilder: (context, index) {
//             final lvlNum = index + 1;
//
//             final pool = gameLevels
//                 .cast<Map<String, dynamic>?>()
//                 .firstWhere(
//                   (p) => p?['level'] == lvlNum,
//               orElse: () => null,
//             );
//
//             final unlocked =
//             isLevelUnlocked(lvlNum, pool);
//
//             final currentUsers =
//                 pool?['currentUsers'] ?? 0;
//             final requiredUsers =
//                 pool?['requiredUsers'] ?? (lvlNum * 4);
//
//             final entryFee = 100;
//             final reward = entryFee * 2;
//
//             return LevelCard(
//               level: lvlNum,
//               unlocked: unlocked,
//               currentUsers: currentUsers,
//               requiredUsers: requiredUsers,
//               reward: reward,
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
//
// /* ================= CARD ================= */
//
// class LevelCard extends StatelessWidget {
//   final int level;
//   final bool unlocked;
//   final int currentUsers;
//   final int requiredUsers;
//   final int reward;
//
//   const LevelCard({
//     super.key,
//     required this.level,
//     required this.unlocked,
//     required this.currentUsers,
//     required this.requiredUsers,
//     required this.reward,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             color: unlocked
//                 ? const Color(0xFF111827)
//                 : Colors.black26,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Column(
//             crossAxisAlignment:
//             CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Level $level",
//                       style:
//                       const TextStyle(color: Colors.grey)),
//                   Icon(
//                     unlocked
//                         ? Icons.lock_open
//                         : Icons.lock,
//                     size: 16,
//                     color: unlocked
//                         ? Colors.green
//                         : Colors.red,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               Text("$currentUsers/$requiredUsers",
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold)),
//               const SizedBox(height: 5),
//               LinearProgressIndicator(
//                 value: currentUsers / requiredUsers,
//                 color: Colors.amber,
//                 backgroundColor: Colors.grey.shade800,
//               ),
//               const SizedBox(height: 10),
//               const Text("Reward",
//                   style: TextStyle(color: Colors.grey)),
//               Text("₹$reward",
//                   style: const TextStyle(
//                       color: Colors.amber,
//                       fontWeight: FontWeight.bold)),
//               const Spacer(),
//               ElevatedButton(
//                 onPressed: unlocked ? () {} : null,
//                 child: Text(unlocked ? "JOIN" : "LOCKED"),
//               )
//             ],
//           ),
//         ),
//         if (!unlocked)
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.6),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: const Icon(Icons.lock, color: Colors.white54),
//             ),
//           )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:lottery_app/services/api_services.dart';

class LevelGameSection extends StatefulWidget {
  const LevelGameSection({super.key});

  @override
  State<LevelGameSection> createState() => _LevelGameSectionState();
}

class _LevelGameSectionState extends State<LevelGameSection> {
  List<dynamic> games = [];
  String? activeGameId;

  List<dynamic> gameLevels = [];
  Map<String, dynamic> wallet = {
    "available": 0,
    "locked": 0,
  };

  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  /* ================= FETCH ================= */

  Future<void> fetchGames() async {
    try {
      final response = await ApiServices.getRequest("/level-games");

      debugPrint("LEVEL GAMES RESPONSE: $response");

      if (response) {
        List data = response['data'];

        setState(() {
          games = data;
          if (games.isNotEmpty) {
            activeGameId = games[0]['id'].toString();
          }
        });





        await fetchLevels();
      } else {
        setState(() => loading = false);
      }
    } catch (e) {
      debugPrint("Error fetching games: $e");
      setState(() => loading = false);
    }
  }

  Future<void> fetchLevels() async {
    if (activeGameId == null) return;

    setState(() => loading = true);

    try {
      final levelsRes = await ApiServices.getRequest(
        "/levels?levelGameId=$activeGameId",
      );

      final walletRes = await ApiServices.getRequest("/wallet");

      debugPrint("LEVELS RESPONSE: $levelsRes");

      if (levelsRes['success'] && walletRes['success']) {
        setState(() {
          gameLevels = levelsRes['data'] ?? [];
          wallet = walletRes['data'] ??
              {
                "available": 0,
                "locked": 0,
              };
        });
      }
    } catch (e) {
      debugPrint("Error fetching levels: $e");
    }

    setState(() => loading = false);
  }

  /* ================= LOGIC ================= */

  bool isLevelUnlocked(int levelNum, dynamic currentPool) {
    if (levelNum <= 2) return true;

    Map<String, dynamic>? prevPool;

    try {
      prevPool = gameLevels.firstWhere(
            (p) => p['level'] == levelNum - 2,
      );
    } catch (e) {
      prevPool = null;
    }

    if (prevPool != null && prevPool['status'] == 'completed') {
      return true;
    }

    if (currentPool != null && prevPool == null) {
      return true;
    }

    return false;
  }

  Map<String, dynamic>? getPool(int level) {
    try {
      return gameLevels.firstWhere((p) => p['level'] == level);
    } catch (e) {
      return null;
    }
  }

  /* ================= UI ================= */

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// HEADER
        // Row(
        //   children: const [
        //     Icon(Icons.sports_esports, color: Colors.amber, size: 32),
        //     SizedBox(width: 10),
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           "Level Game",
        //           style: TextStyle(
        //               fontSize: 24,
        //               color: Colors.white,
        //               fontWeight: FontWeight.bold),
        //         ),
        //         Text(
        //           "Join pools and earn rewards",
        //           style: TextStyle(color: Colors.grey),
        //         ),
        //       ],
        //     )
        //   ],
        // ),
        //
        // const SizedBox(height: 20),
        //
        // /// WALLET
        // Container(
        //   padding: const EdgeInsets.all(12),
        //   decoration: BoxDecoration(
        //     color: const Color(0xFF111827),
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const Text("Available",
        //               style: TextStyle(color: Colors.grey, fontSize: 12)),
        //           Text("₹${wallet['available']}",
        //               style: const TextStyle(
        //                   color: Colors.green,
        //                   fontWeight: FontWeight.bold)),
        //         ],
        //       ),
        //       Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           const Text("Locked",
        //               style: TextStyle(color: Colors.grey, fontSize: 12)),
        //           Text("₹${wallet['locked']}",
        //               style: const TextStyle(
        //                   color: Colors.grey,
        //                   fontWeight: FontWeight.bold)),
        //         ],
        //       ),
        //       ElevatedButton(
        //         onPressed: () {},
        //         style:
        //         ElevatedButton.styleFrom(backgroundColor: Colors.amber),
        //         child: const Text("Withdraw",
        //             style: TextStyle(color: Colors.black)),
        //       )
        //     ],
        //   ),
        // ),
        //
        // const SizedBox(height: 20),

        /// DROPDOWN
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              dropdownColor: const Color(0xFF111827),
              value: activeGameId,
              hint: const Text("Select Game",
                  style: TextStyle(color: Colors.white)),
              icon:
              const Icon(Icons.arrow_drop_down, color: Colors.white),
              items: games.map((game) {
                return DropdownMenuItem<String>(
                  value: game['id'].toString(),
                  child: Text(
                    game['name'],
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) async {
                setState(() {
                  activeGameId = value;
                });
                await fetchLevels();
              },
            ),
          ),
        ),

        const SizedBox(height: 20),

        /// LEVEL GRID
        loading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final lvlNum = index + 1;

            final pool = getPool(lvlNum);
            final unlocked =
            isLevelUnlocked(lvlNum, pool);

            final currentUsers =
                pool?['currentUsers'] ?? 0;
            final requiredUsers =
                pool?['requiredUsers'] ?? (lvlNum * 4);

            final entryFee = 100;
            final reward = entryFee * 2;

            return LevelCard(
              level: lvlNum,
              unlocked: unlocked,
              currentUsers: currentUsers,
              requiredUsers: requiredUsers,
              reward: reward,
            );
          },
        ),
      ],
    );
  }
}

/* ================= LEVEL CARD ================= */

class LevelCard extends StatelessWidget {
  final int level;
  final bool unlocked;
  final int currentUsers;
  final int requiredUsers;
  final int reward;

  const LevelCard({
    super.key,
    required this.level,
    required this.unlocked,
    required this.currentUsers,
    required this.requiredUsers,
    required this.reward,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color:
            unlocked ? const Color(0xFF111827) : Colors.black26,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text("Level $level",
                      style:
                      const TextStyle(color: Colors.grey)),
                  Icon(
                    unlocked
                        ? Icons.lock_open
                        : Icons.lock,
                    size: 16,
                    color: unlocked
                        ? Colors.green
                        : Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("$currentUsers/$requiredUsers",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              LinearProgressIndicator(
                value: currentUsers / requiredUsers,
                color: Colors.amber,
                backgroundColor: Colors.grey.shade800,
              ),
              const SizedBox(height: 10),
              const Text("Reward",
                  style: TextStyle(color: Colors.grey)),
              Text("₹$reward",
                  style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              ElevatedButton(
                onPressed: unlocked ? () {} : null,
                child: Text(unlocked ? "JOIN" : "LOCKED"),
              )
            ],
          ),
        ),
        if (!unlocked)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child:
                Icon(Icons.lock, color: Colors.white54),
              ),
            ),
          )
      ],
    );
  }
}