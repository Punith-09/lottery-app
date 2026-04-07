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

  // 🔹 Date Controllers
  final drawDateController = TextEditingController();
  final drawStartDateController = TextEditingController();
  final drawEndDateController = TextEditingController();

  String _status = 'Draft';
  bool _isGuaranteed = false;
  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() => isMenuOpen = !isMenuOpen);
  }

  // 🔥 API CALL
  Future<void> createDraw() async {
    final body = {
      "game_type_id": int.parse(gameTypeIdController.text),
      "created_by": "7c536fc6-eab5-4773-a65e-8c9d8f31e5f7",
      "name": drawNameController.text,
      "description": descriptionController.text,
      "prize_pool": int.parse(prizePoolController.text),
      "ticket_price": int.parse(ticketPriceController.text),
      "max_entries": int.parse(maxEntriesController.text),
      "min_entries": int.parse(minEntriesController.text),
      "status": _status.toLowerCase(),
      "draw_date": drawDateController.text,
      "draw_start_date": drawStartDateController.text,
      "draw_end_date": drawEndDateController.text,
      "rng_seed_hash": rngSeedController.text,
      "is_guaranteed": _isGuaranteed,
    };

    try {
      final response = await ApiServices.postRequest("/create-draw", body);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Draw created successfully")),
      );
      Navigator.pushNamed(context, '/draws');
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
    drawDateController.dispose();
    drawStartDateController.dispose();
    drawEndDateController.dispose();
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
                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
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
                                  return constraints.maxWidth < 600
                                      ? _buildSmallScreenLayout()
                                      : _buildLargeScreenLayout();
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

                              const SizedBox(height: 20),

                              SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      createDraw();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFD67506),
                                    foregroundColor: Colors.black,
                                  ),
                                  child: const Text(
                                      'Create Draw',
                                    style: TextStyle(
                                      fontSize: 20
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
                ),
              ),
            ),
          ),

          if (isMenuOpen)
            GestureDetector(
              onTap: toggleMenu,
              child: Container(color: Colors.black.withOpacity(0.4)),
            ),

          if (isMenuOpen)
            DrawerMenu(onClose: toggleMenu),
        ],
      ),
    );
  }


  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelStyle: const TextStyle(color: Colors.black87),
      hintStyle: const TextStyle(color: Colors.black54),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.black87),
      ),
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

  Widget _buildTextFieldGroup(
      String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.black87),
          decoration: _inputDecoration(),
          validator: (value) =>
          value == null || value.isEmpty ? "Required" : null,
        ),
      ],
    );
  }

  Widget _buildDatePickerGroup(
      String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          style: const TextStyle(color: Colors.black87),
          decoration: _inputDecoration().copyWith(
            hintText: 'dd-mm-yyyy',
            suffixIcon: const Icon(Icons.calendar_today, size: 18),
          ),
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              controller.text = picked.toIso8601String();
            }
          },
        ),
      ],
    );
  }

  Widget _buildLargeScreenLayout() {
    return Column(
      children: [
        Row(children: [
          Expanded(child: _buildTextFieldGroup('Game Type ID', gameTypeIdController)),
          const SizedBox(width: 24),
          Expanded(child: _buildTextFieldGroup('Draw Name', drawNameController)),
        ]),
        const SizedBox(height: 16),

        Row(children: [
          Expanded(child: _buildTextFieldGroup('Prize Pool', prizePoolController)),
          const SizedBox(width: 24),
          Expanded(child: _buildTextFieldGroup('Ticket Price', ticketPriceController)),
        ]),
        const SizedBox(height: 16),

        Row(children: [
          Expanded(child: _buildTextFieldGroup('Max Entries', maxEntriesController)),
          const SizedBox(width: 24),
          Expanded(child: _buildTextFieldGroup('Min Entries', minEntriesController)),
        ]),
        const SizedBox(height: 16),

        Row(children: [
          Expanded(child: _buildDatePickerGroup('Draw Date', drawDateController)),
          const SizedBox(width: 24),
          Expanded(child: _buildDatePickerGroup('Draw Start Date', drawStartDateController)),
        ]),
        const SizedBox(height: 16),

        Row(children: [
          Expanded(child: _buildDatePickerGroup('Draw End Date', drawEndDateController)),
          const SizedBox(width: 24),
          Expanded(child: _buildTextFieldGroup('RNG Seed Hash', rngSeedController)),
        ]),
        const SizedBox(height: 16),

        Row(children: [
          Expanded(child: _buildStatusDropdownGroup()),
          const SizedBox(width: 24),
          Expanded(
            child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Guaranteed Draw"),
              value: _isGuaranteed,
              onChanged: (val) {
                setState(() => _isGuaranteed = val ?? false);
              },
            ),
          ),
        ]),
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
        _buildDatePickerGroup('Draw Date', drawDateController),
        _buildDatePickerGroup('Draw Start Date', drawStartDateController),
        _buildDatePickerGroup('Draw End Date', drawEndDateController),
        _buildTextFieldGroup('RNG Seed Hash', rngSeedController),
        _buildStatusDropdownGroup(),
        CheckboxListTile(
          title: const Text("Guaranteed Draw"),
          value: _isGuaranteed,
          onChanged: (val) {
            setState(() => _isGuaranteed = val ?? false);
          },
        ),
      ],
    );
  }

  Widget _buildStatusDropdownGroup() {
    return DropdownButtonFormField<String>(
      value: _status,
      style: const TextStyle(color: Colors.black87),
      dropdownColor: Colors.white,
      decoration: _inputDecoration(),
      items: ['Draft', 'Active', 'Closed']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (val) => setState(() => _status = val!),
    );
  }
}