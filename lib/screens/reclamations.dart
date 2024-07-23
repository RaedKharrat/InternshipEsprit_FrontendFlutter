import 'package:flutter/material.dart';

class ReclamationsScreen extends StatelessWidget {
  const ReclamationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reclamations',
          style: TextStyle(color: Colors.white), // Set the title color to white
        ),
        backgroundColor: Colors.red[900], // Dark red color for the AppBar
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg1.png'), // Update the path if necessary
                fit: BoxFit.cover, // Adjust as needed
              ),
            ),
          ),
          // Table content
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.7)),
                dataRowColor: MaterialStateColor.resolveWith((states) => Colors.black.withOpacity(0.4)),
                columns: const [
                  DataColumn(label: Text('Year', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('ID', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Full name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Class', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Type', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('State', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Teacher', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Module code', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Module', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Claim date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Claim text', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Response', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Actions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                ],
                rows: List.generate(10, (index) {
                  return DataRow(
                    cells: List.generate(13, (colIndex) {
                      return DataCell(Text('Data ${index + 1}-${colIndex + 1}', style: const TextStyle(color: Colors.white)));
                    }),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

