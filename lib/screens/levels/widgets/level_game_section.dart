import 'package:flutter/material.dart';
import 'package:lottery_app/services/api_services.dart';

import '../../wallet/wallet_screen.dart';

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

      debugPrint("RESPONSE: $response");

      List data = [];


      if (response is List) {
        data = response;
      } else if (response is Map && response['data'] is List) {
        data = response['data'];
      }

      setState(() {
        games = data;
        activeGameId =
        games.isNotEmpty ? games[0]['id'].toString() : null;
      });

      if (activeGameId != null) {
        await fetchLevels();
      }
    } catch (e) {
      debugPrint("Error fetching games: $e");
    }

    setState(() => loading = false);
  }



  Future<void> fetchLevels() async {
    if (activeGameId == null) return;

    setState(() => loading = true);

    try {
      final levelsRes = await ApiServices.getRequest(
        "/levels?levelGameId=$activeGameId",
      );

      debugPrint("Levels RESPONSE: $levelsRes");


      if (levelsRes is List) {
        gameLevels = levelsRes;
      } else if (levelsRes is Map && levelsRes['data'] is List) {
        gameLevels = levelsRes['data'];
      } else {
        gameLevels = [];
      }

    } catch (e) {
      debugPrint("Error fetching levels: $e");
      gameLevels = [];
    }


    try {
      final walletRes = await ApiServices.getRequest("/wallet");

      if (walletRes is Map && walletRes['data'] != null) {
        wallet = walletRes['data'];
      }
    } catch (e) {
      debugPrint("Wallet failed (ignored): $e");
    }

    setState(() => loading = false);
  }




  /* ================= LOGIC ================= */

  bool isLevelUnlocked(int levelNum, dynamic currentPool) {

    if (levelNum == 1) return true;
    return currentPool != null;
  }

  Map<String, dynamic>? getPool(int level) {
    try {
      for (var p in gameLevels) {
        debugPrint("Checking UI level $level against API level ${p['level']}");
      }

      final pool = gameLevels.firstWhere(
            (p) => int.parse(p['level'].toString()) == level,
      );

      debugPrint(" MATCH FOUND for level $level -> ${pool['level']}");
      return pool;
    } catch (e) {
      debugPrint(" NO MATCH for level $level");
      return null;
    }
  }

  /* ================= UI ================= */

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFF0B1220),
              borderRadius: BorderRadius.circular(14),
            ),
            child: SizedBox(
              height: 45,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: games.length,
                separatorBuilder: (_, __) =>
                const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final game = games[index];
                  final isActive =
                      activeGameId == game['id'].toString();

                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        activeGameId =
                            game['id'].toString();
                      });

                      await fetchLevels();
                    },
                    child: AnimatedContainer(
                      duration:
                      const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.amber
                            : const Color(0xFF111827),
                        borderRadius:
                        BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          game['name'],
                          style: TextStyle(
                            color: isActive
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 10),


          loading
              ? const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ))
              : GridView.builder(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(12),
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
                  pool?['requiredUsers'] ??
                      (lvlNum * 4);

              final entryFee = 100;
              final reward = entryFee * 2;

              return LevelCard(
                level: lvlNum,
                unlocked: unlocked,
                currentUsers: currentUsers,
                requiredUsers: requiredUsers,
                reward: reward,
                pool: pool,
                gameId: activeGameId,
              );
            },
          ),
        ],
      ),
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
  final Map<String, dynamic>? pool;
  final String? gameId;

  const LevelCard({
    super.key,
    required this.level,
    required this.unlocked,
    required this.currentUsers,
    required this.requiredUsers,
    required this.reward,
    this.pool,
    this.gameId
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: unlocked
                ? const Color(0xFF111827)
                : Colors.black26,
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
                      style: const TextStyle(
                          color: Colors.grey)),
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
              Text(
                "PROGRESS",
                style: TextStyle(
                  color: Color(0x85FFFFFF),
                  fontSize:8,
                  fontWeight: FontWeight.bold
                ),
              ),

              Text(
                "$currentUsers/$requiredUsers",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              LinearProgressIndicator(
                value: requiredUsers == 0
                    ? 0
                    : currentUsers / requiredUsers,
                color: Colors.amber,
                backgroundColor:
                Colors.grey.shade800,
              ),
              const SizedBox(height: 10),
              const Text("Reward",
                  style: TextStyle(color: Colors.grey)),
              Text("₹$reward",
                  style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold)),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: unlocked
                        ? () {
                      final entryFee = 100;

                      final joinId = pool != null
                          ? pool!['id']
                          : "placeholder-$gameId-$level";

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WalletScreen(
                            amount: entryFee,
                            poolId: joinId,
                            from: "level-game",
                          ),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFDFDFD),
                      padding: EdgeInsets.all(10 )
                    ),
                    child:
                    Text(unlocked ? "JOIN   >" : "LOCKED",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  )
                ],
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
                child: Icon(Icons.lock,
                    color: Colors.white54),
              ),
            ),
          )
      ],
    );
  }
}