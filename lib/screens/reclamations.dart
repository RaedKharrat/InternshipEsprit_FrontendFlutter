import 'package:flutter/material.dart';

class ReclamationsScreen extends StatefulWidget {
  const ReclamationsScreen({Key? key}) : super(key: key);

  @override
  _ReclamationsScreenState createState() => _ReclamationsScreenState();
}

class _ReclamationsScreenState extends State<ReclamationsScreen> {
  List<Map<String, String>> _data = List.generate(
    10,
    (index) => {
      'year': '2024',
      'id': '${index + 1}',
      'fullName': 'Student ${index + 1}',
      'class': 'Class ${index + 1}',
      'type': 'Type ${index + 1}',
      'state': 'Non traité',
      'teacher': 'Teacher ${index + 1}',
      'moduleCode': 'M${index + 1}',
      'module': 'Module ${index + 1}',
      'claimDate': '2024-07-${index + 1}',
      'claimText': 'Claim text ${index + 1}',
      'response': '',
    },
  );

  Future<void> _showResponseDialog(int index) async {
    String? response = _data[index]['response'];
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Response'),
          content: TextField(
            onChanged: (value) {
              response = value;
            },
            decoration: const InputDecoration(hintText: "Response"),
            controller: TextEditingController(text: _data[index]['response']),
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
                Navigator.of(context).pop(response);
              },
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        _data[index]['response'] = result;
        _data[index]['state'] = 'Traité'; // Update the state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reclamations',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[900],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.black.withOpacity(0.7),
                ),
                dataRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.black.withOpacity(0.4),
                ),
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
                rows: List.generate(_data.length, (index) {
                  return DataRow(
                    cells: [
                      DataCell(Text(_data[index]['year']!, style: const TextStyle(color: Colors.white))),
                      DataCell(Text(_data[index]['id']!, style: const TextStyle(color: Colors.white))),
                      DataCell(Text(_data[index]['fullName']!, style: const TextStyle(color: Colors.white))),
                      DataCell(Text(_data[index]['class']!, style: const TextStyle(color: Colors.white))),
                      DataCell(Text(_data[index]['type']!, style: const TextStyle(color: Colors.white))),
                      DataCell(Text(_data[index]['state']!, style: const TextStyle(color: Colors.white))),
                      DataCell(Text(_data[index]['teacher']!, style: const TextStyle(color: Colors.white))),
                      DataCell(Text(_data[index]['moduleCode']!, style: const TextStyle(color: Colors.white))),
                      DataCell(Text(_data[index]['module']!, style: const TextStyle(color: Colors.white))),
                      DataCell(Text(_data[index]['claimDate']!, style: const TextStyle(color: Colors.white))),
                      DataCell(Text(_data[index]['claimText']!, style: const TextStyle(color: Colors.white))),
                      DataCell(
                        GestureDetector(
                          onTap: () => _showResponseDialog(index),
                          child: Text(
                            _data[index]['response']!.isEmpty ? 'Tap to add' : _data[index]['response']!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () => _showResponseDialog(index),
                        ),
                      ),
                    ],
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
