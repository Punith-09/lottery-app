// import 'package:flutter/material.dart';
//
// class DatesCard extends StatelessWidget{
//   const DatesCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(
//           color: Color(0xFF878787)
//         )
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Column(
//                 children: [
//                   Text(
//                     "From Date",
//                     style: TextStyle(
//                       color: Color(0xFF000000),
//
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   InputDatePickerFormField(firstDate:, lastDate: lastDate)
//                 ],
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

class DatesCard extends StatelessWidget {
  const DatesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(

      color: Color(0xFFFFFFFF),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Wrap(
          spacing: 16,
          runSpacing: 12,

          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildDateField("From Date", "18-02-2026"),
                _buildDateField("To Date", "25-02-2026"),
              ],
            ),
           Row(
             children: [
               _buildDropdown("Type", ["All", "Type 1", "Type 2"]),
               _buildDropdown("Status", ["All", "Active", "Inactive"]),
             ],
           ),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download),
              label: const Text("Export CSV"),
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(String label, String value) {
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, 
              style: const TextStyle(
                  fontSize: 12,
                color:Color(0xFF000000)
              )),
          const SizedBox(height: 6),
          TextFormField(
            style: TextStyle(
              color: Color(0xFF000000),

            ),

            initialValue: value,
            readOnly: false,
            decoration: InputDecoration(

              suffixIcon: const Icon(Icons.calendar_today, size: 18),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onTap: () {
              // TODO: showDatePicker
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12,color: Color(0xFF000000))),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            style: TextStyle(
              color: Color(0xFF000000)
            ),
            value: items.first,
            items: items
                .map((e) => DropdownMenuItem(
              
              value: e,
              child: Text(e,style: TextStyle(color: Color(0xFF000000)),),
            ))
                .toList(),
            onChanged: (value) {},
            decoration: InputDecoration(
              
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}