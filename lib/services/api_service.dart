// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // static const String baseUrl = 'http://localhost:3000'; // URL du backend
  static const String baseUrl = 'https://medical-api.onrender.com'; // URL de Render


  // Méthode pour s'inscrire
  static Future<http.Response> register({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required DateTime dateOfBirth,
    required String gender,
    required String profilePhoto,
    required String role,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'password': password,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'gender': gender,
        'profilePhoto': profilePhoto,
        'role': role,
      }),
    );
    return response;
  }

  // Méthode pour se connecter
  static Future<http.Response> login({
    required String emailOrPhone,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'emailOrPhone': emailOrPhone,
        'password': password,
      }),
    );
    return response;
  }
}
// 


// // lib/services/api_service.dart
// static Future<http.Response> getUsers() async {
//   final response = await http.get(
//     Uri.parse('$baseUrl/admin/users'),
//     headers: {'Authorization': 'Bearer $yourToken'},
//   );
//   return response;
// }

// static Future<http.Response> deleteUser(String userId) async {
//   final response = await http.delete(
//     Uri.parse('$baseUrl/admin/users/$userId'),
//     headers: {'Authorization': 'Bearer $yourToken'},
//   );
//   return response;
// }

