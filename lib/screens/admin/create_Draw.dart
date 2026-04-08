import 'package:flutter/material.dart';
import 'package:lottery_app/services/api_services.dart';

class CreateDrawScreen extends StatefulWidget {
  const CreateDrawScreen({super.key});

  @override
  State<CreateDrawScreen> createState() => _CreateDrawScreenState();
}

class _CreateDrawScreenState extends State<CreateDrawScreen> {
  final _formKey = GlobalKey<FormState>();

  String _status = 'Draft';
  bool _isGuaranteed = false;

  // ✅ Controllers
  final gameTypeIdController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final prizePoolController = TextEditingController();
  final ticketPriceController = TextEditingController();
  final maxEntriesController = TextEditingController();
  final minEntriesController = TextEditingController();
  final rngController = TextEditingController();

  // ✅ DATE CONTROLLERS
  final drawDateController = TextEditingController();
  final drawStartController = TextEditingController();
  final drawEndController = TextEditingController();

  // ✅ API CALL
  Future<void> createDraw() async {
    try {
      final body = {
        "game_type_id": int.tryParse(gameTypeIdController.text) ?? 0,
        "created_by": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        "name": nameController.text,
        "description": descriptionController.text,
        "prize_pool": int.tryParse(prizePoolController.text) ?? 0,
        "ticket_price": int.tryParse(ticketPriceController.text) ?? 0,
        "max_entries": int.tryParse(maxEntriesController.text) ?? 0,
        "min_entries": int.tryParse(minEntriesController.text) ?? 0,
        "status": _status,
        "draw_date": drawDateController.text,
        "draw_start_date": drawStartController.text,
        "draw_end_date": drawEndController.text,
        "rng_seed_hash": rngController.text,
        "is_guaranteed": _isGuaranteed,
      };

      print("📤 REQUEST BODY: $body");

      final response =
      await ApiServices.postRequest("/create-draw", body);

      print("✅ RESPONSE: $response");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Draw Created Successfully ✅")),
      );
    } catch (e) {
      print("❌ ERROR: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Builder( // ✅ FIX for Snackbar context
        builder: (context) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create Draw',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  _buildTextField("Game Type ID", gameTypeIdController, isNumber: true),
                  _buildTextField("Draw Name", nameController),
                  _buildTextField("Prize Pool", prizePoolController, isNumber: true),
                  _buildTextField("Ticket Price", ticketPriceController, isNumber: true),
                  _buildTextField("Max Entries", maxEntriesController, isNumber: true),
                  _buildTextField("Min Entries", minEntriesController, isNumber: true),
                  _buildTextField("RNG Seed Hash", rngController),

                  const SizedBox(height: 16),

                  // ✅ DATE PICKERS
                  _buildDateField("Draw Date", drawDateController),
                  _buildDateField("Start Date", drawStartController),
                  _buildDateField("End Date", drawEndController),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: descriptionController,
                    maxLines: 4,
                    decoration: _inputDecoration("Description"),
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _status,
                    decoration: _inputDecoration("Status"),
                    items: ['Draft', 'Active', 'Closed']
                        .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        _status = val!;
                      });
                    },
                  ),

                  CheckboxListTile(
                    value: _isGuaranteed,
                    title: const Text("Guaranteed Draw"),
                    onChanged: (val) {
                      setState(() {
                        _isGuaranteed = val!;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print("🔥 BUTTON CLICKED");

                        if (_formKey.currentState!.validate()) {
                          createDraw();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        foregroundColor: Colors.black,
                        padding:
                        const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text("Create Draw"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ✅ TEXT FIELD
  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType:
        isNumber ? TextInputType.number : TextInputType.text,
        decoration: _inputDecoration(label),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          }
          return null;
        },
      ),
    );
  }

  // ✅ DATE PICKER FIELD
  Widget _buildDateField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: _inputDecoration(label).copyWith(
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            controller.text = pickedDate.toIso8601String();
          }
        },
      ),
    );
  }

  // ✅ INPUT DECORATION
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
