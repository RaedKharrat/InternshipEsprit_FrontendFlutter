import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsCahierClass extends StatefulWidget {
  final Map<String, dynamic> record;

  const DetailsCahierClass({Key? key, required this.record}) : super(key: key);

  @override
  _DetailsCahierClassState createState() => _DetailsCahierClassState();
}

class _DetailsCahierClassState extends State<DetailsCahierClass> {
  late bool toggleValue;
  late String choice1;
  late DateTime dateFrom;
  late DateTime dateTo;
  late String choice2;
  late String textField;
  late String areaField1;
  late String areaField2;

  @override
  void initState() {
    super.initState();
    toggleValue = widget.record['toggleValue'];
    choice1 = widget.record['choice1'];
    dateFrom = widget.record['dateFrom'];
    dateTo = widget.record['dateTo'];
    choice2 = widget.record['choice2'];
    textField = widget.record['textField'];
    areaField1 = widget.record['areaField1'];
    areaField2 = widget.record['areaField2'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Cahier de Classe', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg1.png'), // Ensure the path is correct
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildToggle(),
                  const SizedBox(height: 10),
                  _buildDropdown('Classe', ['Option 1', 'Option 2'], choice1, (String? newValue) {
                    setState(() {
                      choice1 = newValue!;
                    });
                  }),
                  const SizedBox(height: 10),
                  _buildDateRangePicker(),
                  const SizedBox(height: 10),
                  _buildDropdown('Module', ['Option 1', 'Option 2'], choice2, (String? newValue) {
                    setState(() {
                      choice2 = newValue!;
                    });
                  }),
                  const SizedBox(height: 10),
                  _buildTextField('Titre de la Séance', textField, (String? newValue) {
                    setState(() {
                      textField = newValue!;
                    });
                  }),
                  const SizedBox(height: 10),
                  _buildTextField('Contenu Traité', areaField1, (String? newValue) {
                    setState(() {
                      areaField1 = newValue!;
                    });
                  }),
                  const SizedBox(height: 10),
                  _buildTextField('Remarque', areaField2, (String? newValue) {
                    setState(() {
                      areaField2 = newValue!;
                    });
                  }),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Implement the save action here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // Button color
                            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(double.infinity, 48), // Full width button
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Or',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // Cancel action
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red, // Button color
                            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(double.infinity, 48), // Full width button
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return Row(
      children: [
        const Text(
          'Semestre:',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Switch(
          value: toggleValue,
          onChanged: (bool newValue) {
            setState(() {
              toggleValue = newValue;
            });
          },
        ),
        Text(
          toggleValue ? 'Semestre 1' : 'Semestre 2',
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, List<String> options, String selectedValue, ValueChanged<String?> onChanged) {
    return Row(
      children: [
        Text(
          '$label:',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        DropdownButton<String>(
          value: selectedValue,
          dropdownColor: Colors.black,
          iconEnabledColor: Colors.white,
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDateRangePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Horaire de travail:',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  DateTimeRange? picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    initialDateRange: DateTimeRange(start: dateFrom, end: dateTo),
                  );
                  if (picked != null && picked.start != dateFrom && picked.end != dateTo) {
                    setState(() {
                      dateFrom = picked.start;
                      dateTo = picked.end;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${DateFormat.yMd().format(dateFrom)} - ${DateFormat.yMd().format(dateTo)}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String value, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          initialValue: value,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
