import 'package:flutter/material.dart';

class ActiveLevel extends StatelessWidget {
  final List<dynamic> levelGames;
  final bool isLoading;

  const ActiveLevel({
    super.key,
    required this.levelGames,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🔹 HEADER
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            border: Border.all(color: Colors.black),
          ),
          child: Text(
            "Active Level Pools",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // 🔹 CONTENT (NO SCROLL HERE)
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius:
            BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
          child: isLoading
              ? Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          )
              : levelGames.isEmpty
              ? Padding(
            padding: EdgeInsets.all(20),
            child: Text("No active pools found"),
          )
              : Column(
            children: [
              _buildHeaderRow(),

              ...levelGames.map((game) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 6),
                  child: _buildDataRow(game),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  // 🔹 HEADER ROW
  Widget _buildHeaderRow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          _headerCell("LEVEL"),
          _headerCell("GAME"),
          _headerCell("PROGRESS"),
          _headerCell("REWARD"),
          _headerCell("STATUS"),
          _headerCell("ACTIONS"),
        ],
      ),
    );
  }

  Widget _headerCell(String text) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  // 🔹 ROW
  Widget _buildDataRow(dynamic game) {
    int current = 1;
    int total = 4;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(child: Text("Level 1")),
          Expanded(child: Text(game["name"])),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: current / total,
                  ),
                ),
                SizedBox(width: 6),
                Text("$current/$total"),
              ],
            ),
          ),

          Expanded(
            child: Text(
              "₹${game["entryFee"]}",
              style: TextStyle(color: Colors.green),
            ),
          ),

          Expanded(
            child: Text(
              game["isActive"] ? "FILLING" : "COMPLETED",
              style: TextStyle(
                color: game["isActive"]
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ),

          Expanded(
            child: Text(
              "Force Complete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
