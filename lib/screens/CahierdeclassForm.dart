import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class CahierdeclassForm extends StatefulWidget {
  const CahierdeclassForm({Key? key}) : super(key: key);

  @override
  _CahierdeclassFormState createState() => _CahierdeclassFormState();
}

class _CahierdeclassFormState extends State<CahierdeclassForm> {
  bool _toggleValue = false;
  String? _choice1;
  String? _choice2;
  String? _choice3;
  String? _choice4;
  DateTime? _selectedDateFrom;
  DateTime? _selectedDateTo;
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _areaField1Controller = TextEditingController();
  final TextEditingController _areaField2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cahier de Classe Form', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg1.png'), // Update the path if necessary
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          _buildToggle(),
                          const SizedBox(height: 20),
                          _buildChoiceType('Classe', _choice1, (value) {
                            setState(() {
                              _choice1 = value;
                            });
                          }),
                          const SizedBox(height: 20),
                          _buildDatePickers(),
                          const SizedBox(height: 20),
                          _buildChoiceType('Module', _choice2, (value) {
                            setState(() {
                              _choice2 = value;
                            });
                          }),
                          const SizedBox(height: 20),
                          _buildTextField(),
                          const SizedBox(height: 20),
                          _buildAreaField('Contenu Traité', _areaField1Controller),
                          const SizedBox(height: 20),
                          _buildAreaField('Remarque', _areaField2Controller),
                          const SizedBox(height: 20),
                          _buildSubmitButton(),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Semestre:',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            const Text(
              'Semestre 1',
              style: TextStyle(color: Colors.white),
            ),
            Switch(
              value: _toggleValue,
              onChanged: (value) {
                setState(() {
                  _toggleValue = value;
                });
              },
              activeColor: Colors.green,
              inactiveThumbColor: Colors.red,
            ),
            const Text(
              'Semestre 2',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChoiceType(String label, String? choice, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: choice,
          items: ['Option 1', 'Option 2', 'Option 3'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          dropdownColor: Colors.black,
          style: const TextStyle(color: Colors.white),
          isExpanded: true,
        ),
      ],
    );
  }

  Widget _buildDatePickers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Horaire de travail:',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildDatePicker('De', _selectedDateFrom, (pickedDate) {
                setState(() {
                  _selectedDateFrom = pickedDate;
                });
              }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDatePicker('À', _selectedDateTo, (pickedDate) {
                setState(() {
                  _selectedDateTo = pickedDate;
                });
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label, DateTime? selectedDate, ValueChanged<DateTime?> onDateChanged) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          onDateChanged(pickedDate);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          selectedDate == null ? label : DateFormat.yMd().format(selectedDate),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Titre de la Séance:',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _textFieldController,
          decoration: InputDecoration(
            labelText: 'Titre de la Séance',
            labelStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.black.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildAreaField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _showSubmitAnimation();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.orange, // Button color
              padding: const EdgeInsets.symmetric(vertical: 15.0), // Button padding
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0), // Button border radius
              ),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _showSubmitAnimation() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return FadeTransition(
          opacity: animation1,
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animation1,
              curve: Curves.elasticOut,
              reverseCurve: Curves.easeOutCubic,
            ),
            child: _buildAnimatedDialog(),
          ),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }

  Widget _buildAnimatedDialog() {
    return Center(
      child: Container(
        width: 300,
        height: 300,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "Your form was successfully added",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Back to Home',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
