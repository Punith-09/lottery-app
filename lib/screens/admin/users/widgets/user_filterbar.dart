import 'package:flutter/material.dart';

class UserFilterBar extends StatelessWidget {
  const UserFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          TextField(
            style: TextStyle(
              color: Color(0xFF000000),
            ),
            decoration: InputDecoration(
              hintText: "Search by name or email...",
              prefixIcon: Icon(Icons.search,color: Color(0xFF000000)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
                
              ),
            ),
          ),

          const SizedBox(height: 10),


          Row(
            children: [
              Expanded(
                child: _buildDropdown("All"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildDropdown("All Levels"),
              ),
            ],
          ),

          const SizedBox(height: 10),


          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.download),
                  label: Text("Export CSV",style: TextStyle(color: Color(0xFF000000)),),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  label: Text("Add User"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildDropdown(String hint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: hint,
          isExpanded: true,
          items: [hint].map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: Color(0xFF000000)
                ),
              )
            );
          }).toList(),
          onChanged: (value) {},
        ),
      ),
    );
  }
}