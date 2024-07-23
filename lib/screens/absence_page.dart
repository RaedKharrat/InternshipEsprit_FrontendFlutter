import 'dart:ui';
import 'package:flutter/material.dart';

class AbsencePage extends StatefulWidget {
  const AbsencePage({Key? key}) : super(key: key);

  @override
  _AbsencePageState createState() => _AbsencePageState();
}

class _AbsencePageState extends State<AbsencePage> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  List<String> observations = List.generate(10, (index) => ""); // To store observations
  List<bool> isPresent = List.generate(10, (index) => true); // To store presence status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Absence Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[900],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg1.png'), // Update with your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(30),
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Center(
                                    child: Text(
                                      'Absence Form',
                                      style: Theme.of(context).textTheme.headline5?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Classe',
                                      labelStyle: TextStyle(color: Colors.white70),
                                      filled: true,
                                      fillColor: Colors.black54,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Module',
                                      labelStyle: TextStyle(color: Colors.white70),
                                      filled: true,
                                      fillColor: Colors.black54,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Séance',
                                      labelStyle: TextStyle(color: Colors.white70),
                                      filled: true,
                                      fillColor: Colors.black54,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Date',
                                      labelStyle: TextStyle(color: Colors.white70),
                                      filled: true,
                                      fillColor: Colors.black54,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text: _selectedDate != null
                                          ? '${_selectedDate!.toLocal()}'.split(' ')[0]
                                          : '',
                                    ),
                                    onTap: () async {
                                      final DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101),
                                      );
                                      if (pickedDate != null && pickedDate != _selectedDate) {
                                        setState(() {
                                          _selectedDate = pickedDate;
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 20.0),
                                  Center(
                                    child: SizedBox(
                                      width: double.infinity,
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            // Process data
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red[900], // Button color
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30.0), // Space between form and table
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black.withOpacity(0.7)),
                        dataRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black.withOpacity(0.4)),
                        columns: const [
                          DataColumn(label: Text('Index', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('ID Etudiant', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Absence', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Presence', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                          DataColumn(label: Text('Observation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                        ],
                        rows: List.generate(10, (index) {
                          return DataRow(
                            cells: [
                              DataCell(Text('${index + 1}', style: const TextStyle(color: Colors.white))),
                              DataCell(Text('ID ${index + 1}', style: const TextStyle(color: Colors.white))),
                              DataCell(
                                RadioListTile<bool>(
                                  value: false,
                                  groupValue: isPresent[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isPresent[index] = value!;
                                    });
                                  },
                                  title: const Text('', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              DataCell(
                                RadioListTile<bool>(
                                  value: true,
                                  groupValue: isPresent[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isPresent[index] = value!;
                                    });
                                  },
                                  title: const Text('', style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              DataCell(
                                GestureDetector(
                                  onTap: () async {
                                    final observation = await _showObservationDialog(index);
                                    if (observation != null) {
                                      setState(() {
                                        observations[index] = observation;
                                      });
                                    }
                                  },
                                  child: Text(observations[index].isEmpty ? 'Tap to add' : observations[index], style: const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> _showObservationDialog(int index) async {
    String? observation;
    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Observation for your student'),
          content: TextField(
            onChanged: (value) {
              observation = value;
            },
            decoration: const InputDecoration(hintText: "Observation"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(observation);
              },
            ),
          ],
        );
      },
    );
  }
}
