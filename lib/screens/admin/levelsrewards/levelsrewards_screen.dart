import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/draws/widgets/details_card.dart';
import 'package:lottery_app/screens/admin/levelsrewards/widgets/active_level.dart';
import 'package:lottery_app/screens/admin/levelsrewards/widgets/points_configuration.dart';
import 'package:lottery_app/services/api_services.dart';
import '../drawer/admin_drawer.dart';
import '../drawer/drawer_menu.dart';

class LevelsRewardsScreen extends StatefulWidget {
  const LevelsRewardsScreen({super.key});

  @override
  State<LevelsRewardsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsRewardsScreen> {
  Map<String,dynamic> stats={};
  bool isMenuOpen = false;
  bool isCreatingGame = false;

  List<dynamic> games = [];

  String? selectedGameId;

  final TextEditingController gameNameController = TextEditingController();
  final TextEditingController entryFeeController = TextEditingController();

  final TextEditingController levelController = TextEditingController(text: "1");
  final TextEditingController requiredUsersController = TextEditingController(text: "4");
  final TextEditingController entryFeePoolController = TextEditingController(text: "100");

  @override
  void initState(){
    super.initState();
    fetchStats();
    fetchGames();
  }


  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  Future<void> fetchGames() async {
    try {
      final res = await ApiServices.getRequest("/admin/level-games");
      setState(() {
        games = res;
      });
    } catch (e) {
      debugPrint("Games fetch error: $e");
    }
  }

  Future<void> fetchStats() async{
    try{
      final response = await ApiServices.getRequest("/admin/level-games/stats");
      setState(() {
        stats= response;
      });

    }catch(e){
      debugPrint("Error: $e");
    }
  }

  Future<void> createGame() async {
    final name = gameNameController.text.trim();
    final feeText = entryFeeController.text.trim();

    if (name.isEmpty || feeText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    final fee = double.tryParse(feeText);
    if (fee == null || fee <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid amount")),
      );
      return;
    }

    try {
      setState(() => isCreatingGame = true);

      final response = await ApiServices.postRequest(
        "/admin/level-games",
        {
          "name": name,
          "entryFee": fee,
        },
      );

      if (response["success"] == true) {
        Navigator.pop(context);

        gameNameController.clear();
        entryFeeController.clear();

        fetchStats(); // 🔥 refresh like React

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Game created successfully")),
        );
      }
    } catch (e) {
      debugPrint("Create Game Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to create game")),
      );
    } finally {
      setState(() => isCreatingGame = false);
    }
  }



  Future<void> createPool() async {
    try {
      final response = await ApiServices.postRequest(
        "/admin/levels",
        {
          "gameTypeId": selectedGameId,
          "level": int.parse(levelController.text),
          "requiredCount": int.parse(requiredUsersController.text),
          "levelEntryFee": double.parse(entryFeePoolController.text),
        },
      );

      if (response["success"] == true) {
        Navigator.pop(context);
        fetchStats();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Level created successfully")),
        );
      }
    } catch (e) {
      debugPrint("Create pool error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFFFFFFF),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      AdminDrawer(onMenuPressed: toggleMenu,),

                      const SizedBox(height: 20),
                      Column(

                        children: [
                          Text(
                            "Levels & Rewards",
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 26,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "Manage user levels and rewards",
                            style: TextStyle(
                                color: Color(0x50000000),
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(

                                  onPressed: (){
                                    _showAddPoolBottomSheet(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(18),
                                    shadowColor: Color(0xFFF34A00),
                                    backgroundColor: Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusGeometry.circular(15),

                                    )
                                  ),
                                  child: Text(
                                    "+ Add Level Pool",
                                    style: TextStyle(
                                      color: Color(0xFFF34A00)
                                    ),
                                  )
                              ),

                              const SizedBox(width: 30),

                              ElevatedButton(
                                  onPressed: (){
                                    _showCreateGameBottomSheet(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(18),
                                    backgroundColor: Color(0xFFF34A00),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusGeometry.circular(15),

                                      )
                                  ),
                                  child: Text(
                                    "+ Create Game",
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF)
                                    ),
                                  )
                              )
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 40),

                      Row(
                        children: [
                          Expanded(child: DetailsCard(svgIcon: "🏅", value: "${stats["totalGames"]}", title: "Total Levels", textColor: Color(0xFF0890B1)),),

                          const SizedBox(width: 10),

                          Expanded(child: DetailsCard(svgIcon: "👑", value: "${stats["activePools"]}", title: "VIP Members", textColor: Color(0xFFD77606)),)
                        ],
                      ),


                      Row(
                        children: [
                          Expanded(child: DetailsCard(svgIcon: "💰", value: "${stats["totalUsers"]}", title: "Rewards Paid", textColor: Color(0xFF16A24A)),),

                          const SizedBox(width: 10),

                          Expanded(child: DetailsCard(svgIcon: "📊", value: "₹${stats["totalPayouts"]}", title: "Avg Level Progress", textColor: Color(0xFF7B3AEB)),),
                        ],
                      ),
                      const SizedBox(height: 40),

                      ActiveLevel(),

                      const SizedBox(height: 40),
                      PointsConfiguration(),



                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isMenuOpen)
            GestureDetector(
              onTap: toggleMenu,
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),


          if (isMenuOpen)
            DrawerMenu(
              onClose: toggleMenu,
            ),
        ],
      ),
    );
  }



  void _showCreateGameBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Center(
                      child: Text(
                        "Create New Level Game",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF000000)
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(),

                    const SizedBox(height: 10),

                    const Text(
                      "GAME NAME",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: gameNameController,
                      style: TextStyle(
                        color: Color(0xFF0000000)
                      ),
                      decoration: InputDecoration(

                        hintText: "e.g. Super Mega Game",
                        hintStyle: TextStyle(color: Color(0xFF818181)),
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "INITIAL ENTRY FEE (₹)",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: entryFeeController,
                      style: TextStyle(
                        color: Color(0xFF000000)
                      ),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "1000",
                        hintStyle: TextStyle(color: Color(0xFF818181)),
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                                "Cancel",
                              style: TextStyle(
                                color: Color(0xFF707070),
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: isCreatingGame ? null : createGame,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF34A00),
                            ),
                            child: isCreatingGame
                                ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : const Text(
                                "Create Game",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddPoolBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Center(
                      child: Text(
                        "Add Level Pool",
                        style: TextStyle(color: Color(0xFF000000),fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(height: 10),
                    const Divider(),

                    const SizedBox(height: 10),

                    /// GAME DROPDOWN
                    const Text("TARGET GAME",style: TextStyle(color: Color(0xFF000000)),),
                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      style: TextStyle(color: Color(0xff000000)),
                      value: selectedGameId,
                      items: games.map<DropdownMenuItem<String>>((game) {
                        return DropdownMenuItem(
                          
                          value: game["id"].toString(),
                          child: Text("${game["name"]} (₹${game["entryFee"]})"),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setModalState(() {
                          selectedGameId = val;

                          final game = games.firstWhere((g) => g["id"].toString() == val);
                          entryFeePoolController.text = game["entryFee"].toString();
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        hintStyle:TextStyle(color: Color(0xff000000)) ,
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,

                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// LEVEL + USERS
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Color(0xff000000)),
                            controller: levelController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Level #",
                              labelStyle: TextStyle(color: Color(0xff000000)),
                              filled: true,
                              fillColor: Color(0xFFF5F5F5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (val) {
                              final lvl = int.tryParse(val) ?? 1;
                              setModalState(() {
                                requiredUsersController.text = (lvl * 4).toString();
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Color(0xff000000)),
                            controller: requiredUsersController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Users",
                              labelStyle: TextStyle(color: Color(0xff000000)),
                              filled: true,
                              fillColor: Color(0xFFF5F5F5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    /// ENTRY FEE
                    TextField(
                      style: TextStyle(color: Color(0xFF000000)),
                      controller: entryFeePoolController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Entry Fee",
                        labelStyle: TextStyle(color: Color(0xff000000)),
                        filled: true,
                        fillColor: Color(0xFFF5F5F5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// REWARD (AUTO)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "Reward: ₹${(double.tryParse(entryFeePoolController.text) ?? 0) * 2}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// BUTTONS
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: createPool,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF34A00),
                            ),
                            child: const Text("Initialize"),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

}