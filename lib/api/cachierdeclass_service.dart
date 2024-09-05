import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth_service.dart';

class CahierClasseService {
  final String baseUrl;

  CahierClasseService({required this.baseUrl});

  Future<List<dynamic>> getCahierClasses() async {
    print('Fetching Cahier de Classe data...');
    
    // Retrieve token from SharedPreferences
    String? token = await AuthService.getToken();
    
    if (token == null) {
      throw Exception('No token found');
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/cahierClasse'), // Ensure endpoint is correct
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Data received: $data'); // Log the data
        return data;
      } else {
        print('Error: Failed to fetch data. Status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error occurred: $e');
      return [];
    }
  }
}
