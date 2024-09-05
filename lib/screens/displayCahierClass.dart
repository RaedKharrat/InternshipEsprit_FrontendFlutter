import 'package:flutter/material.dart';
import '../api/cachierdeclass_service.dart';
import '../screens/DetailsCahierClass.dart'; // Import the EvaluationsChart
import '../screens/CahierdeclassForm.dart'; // Import the EvaluationsChart

class DisplayCahierClass extends StatefulWidget {
  const DisplayCahierClass({Key? key}) : super(key: key);

  @override
  State<DisplayCahierClass> createState() => _DisplayCahierClassState();
}

class _DisplayCahierClassState extends State<DisplayCahierClass> {
  late CahierClasseService _service;
  late Future<List<dynamic>> _futureCahierClasses;

  @override
  void initState() {
    super.initState();
    _service = CahierClasseService(baseUrl: 'http://localhost:5000');
    _futureCahierClasses = _service.getCahierClasses();
  }

  void _navigateToDetailsCahierClass(Map<String, dynamic> record) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsCahierClass(record: record),
      ),
    );
  }

  void _navigateToCahierdeclassForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CahierdeclassForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cahier de Classe'),
        backgroundColor: Colors.red, // Red color for the AppBar
        iconTheme: const IconThemeData(color: Colors.white), // White color for the back button
        titleTextStyle: const TextStyle(color: Colors.white), // White color for the title
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white), // "+" icon
            onPressed: _navigateToCahierdeclassForm,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.png'), // Make sure bg1.png is in the assets directory
            fit: BoxFit.cover, // Fit the image to cover the screen
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: _futureCahierClasses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Cahier de Classe found.'));
            } else {
              final cahierClasses = snapshot.data!;
              return ListView.builder(
                itemCount: cahierClasses.length,
                itemBuilder: (context, index) {
                  final cahier = cahierClasses[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    elevation: 5,
                    color: Colors.white.withOpacity(0.9), // Slightly transparent white background
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(16.0),
                          title: Text(
                            cahier['titre_seance'] ?? 'No Title',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87, // Darker text color for better readability
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                'Date: ${cahier['date']?.toString().substring(0, 10) ?? 'No Date'}', // Displaying only date part
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Horaire: ${cahier['horaire_seance'] ?? 'No Time'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Contenu: ${cahier['contenu'] ?? 'No Content'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Remarque: ${cahier['remarque'] ?? 'No Remarks'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Semestre: ${cahier['semestre'] ?? 'No Semester'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            onPressed: () => _navigateToDetailsCahierClass(cahier),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'Show Details',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
