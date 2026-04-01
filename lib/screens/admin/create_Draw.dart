import 'package:flutter/material.dart';
class CreateDrawScreen extends StatefulWidget {
  const CreateDrawScreen({super.key});

  @override
  State<CreateDrawScreen> createState() => _CreateDrawScreenState();
}

class _CreateDrawScreenState extends State<CreateDrawScreen> {
  final _formKey = GlobalKey<FormState>();
  String _status = 'Draft';
  bool _isGuaranteed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child:Padding(padding: const EdgeInsets.all(24.0),
          child: Column(
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
              const SizedBox(height: 4,),
              const Text(
                'Manage all lottery draws',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 24),
              //Form container
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
                  ]
                ),
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'create Draw',
                        style: TextStyle(
                          fontSize:20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24,),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isSmallScreen = constraints.maxWidth < 600;

                          if (isSmallScreen) {
                            return _buildSmallScreenLayout();
                          } else {
                            return _buildLargeScreenLayout();
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      //Description field
                      _buildLabel('Description'),
                      const SizedBox(height: 8),
                      TextFormField(
                        maxLines: 5,
                        style: const TextStyle(color: Colors.black87),
                        decoration: _inputDecoration(),
                      ),
                      const SizedBox(height: 24),
                      //submit button
                  // submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // perform save action
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16), // ✅ FIX
                        minimumSize: const Size(double.infinity, 50), // ✅ BETTER UI
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
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


                ]
                ),
              )
              )],
          ),
        )
      ),
    );
  }
  Widget _buildLargeScreenLayout(){
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTextFieldGroup('Game Type ID')),
            const SizedBox(width: 24),
            Expanded(child: _buildTextFieldGroup('Draw Name'))
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildTextFieldGroup('Max Entries')),
            const SizedBox(width: 24),
            Expanded(child: _buildTextFieldGroup('Min Entries')),
          ],
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildDatePickerGroup('Draw Date')),
            const SizedBox(width: 24),
            Expanded(child: _buildDatePickerGroup('Draw Start Date')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildDatePickerGroup('Draw End Date')),
            const SizedBox(width: 24),
            Expanded(child: _buildTextFieldGroup('RNG Seed Hash')),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildStatusDropdownGroup()),
            const SizedBox(width: 24),
            Expanded(child: Padding(padding: const EdgeInsets.only(top:24.0),
              child: CheckboxListTile(contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  'Guaranteed Draw',
                  style: TextStyle(fontSize: 14,color:Colors.black87),
                ),
                value: _isGuaranteed,
                onChanged: (bool? value){
                    setState(() {
                      _isGuaranteed = value ?? false;
                    });
                },
                activeColor: const Color(0xFF2196F3),
              ),
            ))
          ],
        )
      ],
    );
  }
  Widget _buildSmallScreenLayout(){
    return Column(
      children: [
        _buildTextFieldGroup('Game Type ID'),
        const SizedBox(height: 16),
        _buildTextFieldGroup('Draw Name'),
        const SizedBox(height: 16),
        _buildTextFieldGroup('Prize Pool'),
        const SizedBox(height: 16),
        _buildTextFieldGroup('Ticket Price'),
        const SizedBox(height: 16),
        _buildTextFieldGroup('Max Entries'),
        const SizedBox(height: 16),
        _buildTextFieldGroup('Min Entries'),
        const SizedBox(height: 16),
        _buildDatePickerGroup('Draw Date'),
        const SizedBox(height: 16),
        _buildDatePickerGroup('Draw Start Date'),
        const SizedBox(height: 16),
        _buildDatePickerGroup('Draw End Date'),
        const SizedBox(height: 16),
        _buildTextFieldGroup('RNG Seed Hash'),
        const SizedBox(height: 16),
        _buildStatusDropdownGroup(),
        const SizedBox(height: 8),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: const Text(
            'Guaranted Draw',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          value: _isGuaranteed,
          onChanged: (bool? Value){
            setState(() {
              _isGuaranteed = Value ?? false;
            });
          },
          activeColor: const Color(0xFF2196F3),
        )
      ],
    );
  }
  Widget _buildLabel(String text){
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }
  InputDecoration _inputDecoration({Widget? suffixIcon, String? hintText}){
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black54,fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      suffixIcon: suffixIcon,
      isDense: true,
      fillColor: Colors.white,
      filled:true,
    );
  }
  Widget _buildTextFieldGroup(String label){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8),
        TextFormField(
          style: const TextStyle(color: Colors.black87),
          decoration: _inputDecoration(),
        ),
      ],
    );
  }
  Widget _buildDatePickerGroup(String label){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 8,),
        TextFormField(
          readOnly: true,
          style: const TextStyle(color:Colors.black87),
          decoration: _inputDecoration(
            hintText: 'dd-mm-yyyy --:--',
            suffixIcon:const Icon(
              Icons.calendar_today_outlined,
              color: Colors.black87,
              size: 20,
            )
          ),
          onTap: () async{
            //Future implementations for Datepicker
          },
        )
      ],
    );
  }
  Widget _buildStatusDropdownGroup() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel('Status'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _status,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black87),
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          decoration: _inputDecoration(),
          items: ['Draft', 'Active', 'Closed']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
              .toList(),
          onChanged: (String? newValue) {
            setState(() {
              _status = newValue!;
            });
          },
        ),
      ],
    );
  }
}

