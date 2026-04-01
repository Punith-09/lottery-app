// import 'package:flutter/material.dart';
// import 'package:lottery_app/screens/admin/drawer/admin_drawer.dart';
// import 'package:lottery_app/screens/admin/drawer/drawer_menu.dart';
//
//
// class CreateDraws extends StatefulWidget {
//   const CreateDraws({super.key});
//
//   @override
//   State<CreateDraws> createState() => _CreateDrawsState();
// }
//
// class _CreateDrawsState extends State<CreateDraws> {
//   final _formKey = GlobalKey<FormState>();
//   String _status = 'Draft';
//   bool _isGuaranteed = false;
//   bool isMenuOpen = false;
//
//   void toggleMenu() {
//     setState(() {
//       isMenuOpen = !isMenuOpen;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//
//
//           Container(
//             decoration: const BoxDecoration(
//               gradient: RadialGradient(
//                 center: Alignment.topCenter,
//                 radius: 1.2,
//                 colors: [
//                   Color(0xFFFFFFFF),
//                   Color(0xFFFFFFFF),
//                 ],
//               ),
//             ),
//             child: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 20),
//
//                       AdminDrawer(onMenuPressed: toggleMenu,),
//
//                       const SizedBox(height: 20),
//
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//
//                           const Text(
//                             'Draws',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           const Text(
//                             'Manage all lottery draws',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.black54,
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//
//
//
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: Colors.black12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.02),
//                                   blurRadius: 10,
//                                   spreadRadius: 2,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             padding: const EdgeInsets.all(24.0),
//                             child: Form(
//                               key: _formKey,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Create Draw',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 24),
//
//                                   LayoutBuilder(
//                                     builder: (context, constraints) {
//                                       bool isSmallScreen = constraints.maxWidth < 600;
//
//                                       if (isSmallScreen) {
//                                         return _buildSmallScreenLayout();
//                                       } else {
//                                         return _buildLargeScreenLayout();
//                                       }
//                                     },
//                                   ),
//
//                                   const SizedBox(height: 24),
//
//
//                                   _buildLabel('Description'),
//                                   const SizedBox(height: 8),
//                                   TextFormField(
//                                     maxLines: 5,
//                                     style: const TextStyle(color: Colors.black87),
//                                     decoration: _inputDecoration(),
//                                   ),
//
//                                   const SizedBox(height: 14),
//
//
//                                   SizedBox(
//                                     width: double.infinity,
//                                     height: 50,
//                                     child: ElevatedButton(
//                                       onPressed: () {
//                                         if (_formKey.currentState!.validate()) {
//
//                                         }
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: const Color(0xFFFFFFFF), // Yellow Color
//                                         foregroundColor: Colors.black,
//                                         elevation: 0,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(6),
//                                         ),
//                                       ),
//                                       child: const Text(
//                                         'Create Draw',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           if (isMenuOpen)
//             GestureDetector(
//               onTap: toggleMenu,
//               child: Container(
//                 color: Colors.black.withOpacity(0.4),
//               ),
//             ),
//
//
//           if (isMenuOpen)
//             DrawerMenu(
//               onClose: toggleMenu,
//             ),
//         ],
//       ),
//     );
//   }
//   Widget _buildLargeScreenLayout() {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(child: _buildTextFieldGroup('Game Type ID')),
//             const SizedBox(width: 24),
//             Expanded(child: _buildTextFieldGroup('Draw Name')),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(child: _buildTextFieldGroup('Prize Pool')),
//             const SizedBox(width: 24),
//             Expanded(child: _buildTextFieldGroup('Ticket Price')),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(child: _buildTextFieldGroup('Max Entries')),
//             const SizedBox(width: 24),
//             Expanded(child: _buildTextFieldGroup('Min Entries')),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(child: _buildDatePickerGroup('Draw Date')),
//             const SizedBox(width: 24),
//             Expanded(child: _buildDatePickerGroup('Draw Start Date')),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(child: _buildDatePickerGroup('Draw End Date')),
//             const SizedBox(width: 24),
//             Expanded(child: _buildTextFieldGroup('RNG Seed Hash')),
//           ],
//         ),
//         const SizedBox(height: 16),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(child: _buildStatusDropdownGroup()),
//             const SizedBox(width: 24),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 24.0),
//                 child: CheckboxListTile(
//                   contentPadding: EdgeInsets.zero,
//                   controlAffinity: ListTileControlAffinity.leading,
//                   title: const Text(
//                     'Guaranteed Draw',
//                     style: TextStyle(fontSize: 14, color: Colors.black87),
//                   ),
//                   value: _isGuaranteed,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       _isGuaranteed = value ?? false;
//                     });
//                   },
//                   activeColor: const Color(0xFF2196F3), // Checkbox blue color
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSmallScreenLayout() {
//     return Column(
//       children: [
//         _buildTextFieldGroup('Game Type ID'),
//         const SizedBox(height: 16),
//         _buildTextFieldGroup('Draw Name'),
//         const SizedBox(height: 16),
//         _buildTextFieldGroup('Prize Pool'),
//         const SizedBox(height: 16),
//         _buildTextFieldGroup('Ticket Price'),
//         const SizedBox(height: 16),
//         _buildTextFieldGroup('Max Entries'),
//         const SizedBox(height: 16),
//         _buildTextFieldGroup('Min Entries'),
//         const SizedBox(height: 16),
//         _buildDatePickerGroup('Draw Date'),
//         const SizedBox(height: 16),
//         _buildDatePickerGroup('Draw Start Date'),
//         const SizedBox(height: 16),
//         _buildDatePickerGroup('Draw End Date'),
//         const SizedBox(height: 16),
//         _buildTextFieldGroup('RNG Seed Hash'),
//         const SizedBox(height: 16),
//         _buildStatusDropdownGroup(),
//         const SizedBox(height: 8),
//         CheckboxListTile(
//           contentPadding: EdgeInsets.zero,
//           controlAffinity: ListTileControlAffinity.leading,
//           title: const Text(
//             'Guaranteed Draw',
//             style: TextStyle(fontSize: 14, color: Colors.black87),
//           ),
//           value: _isGuaranteed,
//           onChanged: (bool? value) {
//             setState(() {
//               _isGuaranteed = value ?? false;
//             });
//           },
//           activeColor: const Color(0xFF2196F3),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLabel(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         fontSize: 13,
//         fontWeight: FontWeight.w500,
//         color: Colors.black87,
//       ),
//     );
//   }
//
//   InputDecoration _inputDecoration({Widget? suffixIcon, String? hintText}) {
//     return InputDecoration(
//       hintText: hintText,
//       hintStyle: const TextStyle(color: Colors.black54, fontSize: 14),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(6),
//         borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
//       ),
//       enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(6),
//       borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
//     ),
//     focusedBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(6),
//     borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
//     ),
//     suffixIcon: suffixIcon,
//     isDense: true,
//     fillColor: Colors.white,
//     filled: true,
//     );
//   }
//
//   Widget _buildTextFieldGroup(String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildLabel(label),
//         const SizedBox(height: 8),
//         TextFormField(
//           style: const TextStyle(color: Colors.black87),
//           decoration: _inputDecoration(),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDatePickerGroup(String label) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildLabel(label),
//         const SizedBox(height: 8),
//         TextFormField(
//           readOnly: true,
//           style: const TextStyle(color: Colors.black87),
//           decoration: _inputDecoration(
//             hintText: 'dd-mm-yyyy --:--',
//             suffixIcon: const Icon(
//               Icons.calendar_today_outlined,
//               color: Colors.black87,
//               size: 20,
//             ),
//           ),
//           onTap: () async {
//             // Future implementation for DatePicker
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStatusDropdownGroup() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildLabel('Status'),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: _status,
//           dropdownColor: Colors.white,
//           icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black87),
//           style: const TextStyle(color: Colors.black87, fontSize: 14),
//           decoration: _inputDecoration(),
//           items: ['Draft', 'Active', 'Closed']
//               .map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           })
//               .toList(),
//           onChanged: (String? newValue) {
//             setState(() {
//               _status = newValue!;
//             });
//           },
//         ),
//       ],
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:lottery_app/screens/admin/drawer/admin_drawer.dart';
import 'package:lottery_app/screens/admin/drawer/drawer_menu.dart';
import 'package:lottery_app/services/api_services.dart';

class CreateDraws extends StatefulWidget {
  const CreateDraws({super.key});

  @override
  State<CreateDraws> createState() => _CreateDrawsState();
}

class _CreateDrawsState extends State<CreateDraws> {
  final _formKey = GlobalKey<FormState>();

  // 🔹 Controllers
  final gameTypeIdController = TextEditingController();
  final drawNameController = TextEditingController();
  final prizePoolController = TextEditingController();
  final ticketPriceController = TextEditingController();
  final maxEntriesController = TextEditingController();
  final minEntriesController = TextEditingController();
  final rngSeedController = TextEditingController();
  final descriptionController = TextEditingController();

  String _status = 'Draft';
  bool _isGuaranteed = false;
  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }


  Future<void> createDraw() async {
    final body = {
      "game_type_id": int.parse(gameTypeIdController.text),
      "created_by": "7c536fc6-eab5-4773-a65e-8c9d8f31e5f7", // ⚠️ MUST EXIST IN DB
      "name": drawNameController.text,
      "description": descriptionController.text,
      "prize_pool": int.parse(prizePoolController.text),
      "ticket_price": int.parse(ticketPriceController.text),
      "max_entries": int.parse(maxEntriesController.text),
      "min_entries": int.parse(minEntriesController.text),
      "status": _status.toLowerCase(),
      "draw_date": DateTime.now().toIso8601String(),
      "draw_start_date": DateTime.now().toIso8601String(),
      "draw_end_date": DateTime.now().toIso8601String(),
      "rng_seed_hash": rngSeedController.text,
      "is_guaranteed": _isGuaranteed,
    };

    try {
      final response = await ApiServices.postRequest("/create-draw", body);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Draw created successfully")),
      );

      print(response);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Error: $e")),
      );
    }
  }

  @override
  void dispose() {
    gameTypeIdController.dispose();
    drawNameController.dispose();
    prizePoolController.dispose();
    ticketPriceController.dispose();
    maxEntriesController.dispose();
    minEntriesController.dispose();
    rngSeedController.dispose();
    descriptionController.dispose();
    super.dispose();
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      AdminDrawer(onMenuPressed: toggleMenu),

                      const SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Draws',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Manage all lottery draws',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 24),

                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(24.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Create Draw',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 24),

                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      bool isSmallScreen =
                                          constraints.maxWidth < 600;

                                      if (isSmallScreen) {
                                        return _buildSmallScreenLayout();
                                      } else {
                                        return _buildLargeScreenLayout();
                                      }
                                    },
                                  ),

                                  const SizedBox(height: 24),

                                  _buildLabel('Description'),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: descriptionController,
                                    maxLines: 5,
                                    style: const TextStyle(color: Colors.black87),
                                    decoration: _inputDecoration(),
                                  ),

                                  const SizedBox(height: 14),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          createDraw(); // ✅ API CALL
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        const Color(0xFFFFFFFF),
                                        foregroundColor: Colors.black,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(6),
                                        ),
                                      ),
                                      child: const Text(
                                        'Create Draw',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

  // 🔹 UPDATED: attach controllers
  Widget _buildTextFieldGroup(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.black87),
          decoration: _inputDecoration(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Required";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildLargeScreenLayout() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTextFieldGroup('Game Type ID', gameTypeIdController)),
            const SizedBox(width: 24),
            Expanded(child: _buildTextFieldGroup('Draw Name', drawNameController)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextFieldGroup('Prize Pool', prizePoolController)),
            const SizedBox(width: 24),
            Expanded(child: _buildTextFieldGroup('Ticket Price', ticketPriceController)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextFieldGroup('Max Entries', maxEntriesController)),
            const SizedBox(width: 24),
            Expanded(child: _buildTextFieldGroup('Min Entries', minEntriesController)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextFieldGroup('RNG Seed Hash', rngSeedController)),
            const SizedBox(width: 24),
            Expanded(child: _buildStatusDropdownGroup()),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallScreenLayout() {
    return Column(
      children: [
        _buildTextFieldGroup('Game Type ID', gameTypeIdController),
        _buildTextFieldGroup('Draw Name', drawNameController),
        _buildTextFieldGroup('Prize Pool', prizePoolController),
        _buildTextFieldGroup('Ticket Price', ticketPriceController),
        _buildTextFieldGroup('Max Entries', maxEntriesController),
        _buildTextFieldGroup('Min Entries', minEntriesController),
        _buildTextFieldGroup('RNG Seed Hash', rngSeedController),
        _buildStatusDropdownGroup(),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  Widget _buildStatusDropdownGroup() {
    return DropdownButtonFormField<String>(
      value: _status,
      items: ['Draft', 'Active', 'Closed']
          .map((value) => DropdownMenuItem(
        value: value,
        child: Text(value),
      ))
          .toList(),
      onChanged: (val) {
        setState(() => _status = val!);
      },
    );
  }
}