import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'cahierdeclassForm.dart';
import 'detailsCahierClass.dart';

class DisplayCahierClass extends StatelessWidget {
  // Sample records data
  final List<Map<String, dynamic>> records = [
    {
      'toggleValue': true,
      'choice1': 'Option 1',
      'dateFrom': DateTime.now().subtract(Duration(days: 1)),
      'dateTo': DateTime.now(),
      'choice2': 'Option 2',
      'textField': 'Session Title 1',
      'areaField1': 'Content treated in this session...',
      'areaField2': 'Remarks about the session...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display Cahier de Classe', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red[900],
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CahierdeclassForm(),
                ),
              );
            },
          ),
        ],
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
                children: records.map((record) {
                  return Card(
                    color: Colors.black.withOpacity(0.5),
                    margin: const EdgeInsets.only(bottom: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRecordDetail('Semestre', record['toggleValue'] ? 'Semestre 1' : 'Semestre 2'),
                          const SizedBox(height: 10),
                          _buildRecordDetail('Classe', record['choice1']),
                          const SizedBox(height: 10),
                          _buildRecordDetail(
                            'Horaire de travail',
                            '${DateFormat.yMd().format(record['dateFrom'])} - ${DateFormat.yMd().format(record['dateTo'])}',
                          ),
                          const SizedBox(height: 10),
                          _buildRecordDetail('Module', record['choice2']),
                          const SizedBox(height: 10),
                          _buildRecordDetail('Titre de la Séance', record['textField']),
                          const SizedBox(height: 10),
                          _buildRecordDetail('Contenu Traité', record['areaField1']),
                          const SizedBox(height: 10),
                          _buildRecordDetail('Remarque', record['areaField2']),
                          const SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsCahierClass(record: record),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red[900], // Button color
                                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Show',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordDetail(String label, String? detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            detail ?? 'N/A',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
