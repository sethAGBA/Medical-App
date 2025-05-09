// // // // lib/services/api_service.dart
// // // import 'dart:convert';
// // // import 'package:http/http.dart' as http;

// // // class ApiService {
// // //   // static const String baseUrl = 'http://localhost:3000'; // URL du backend
// // //   static const String baseUrl = 'https://medical-api.onrender.com'; // URL de Render


// // //   // Méthode pour s'inscrire
// // //   static Future<http.Response> register({
// // //     required String fullName,
// // //     required String email,
// // //     required String phoneNumber,
// // //     required String password,
// // //     required DateTime dateOfBirth,
// // //     required String gender,
// // //     required String profilePhoto,
// // //     required String role,
// // //   }) async {
// // //     final response = await http.post(
// // //       Uri.parse('$baseUrl/auth/register'),
// // //       headers: {'Content-Type': 'application/json'},
// // //       body: json.encode({
// // //         'fullName': fullName,
// // //         'email': email,
// // //         'phoneNumber': phoneNumber,
// // //         'password': password,
// // //         'dateOfBirth': dateOfBirth.toIso8601String(),
// // //         'gender': gender,
// // //         'profilePhoto': profilePhoto,
// // //         'role': role,
// // //       }),
// // //     );
// // //     return response;
// // //   }

// // //   // Méthode pour se connecter
// // //   static Future<http.Response> login({
// // //     required String emailOrPhone,
// // //     required String password,
// // //   }) async {
// // //     final response = await http.post(
// // //       Uri.parse('$baseUrl/auth/login'),
// // //       headers: {'Content-Type': 'application/json'},
// // //       body: json.encode({
// // //         'emailOrPhone': emailOrPhone,
// // //         'password': password,
// // //       }),
// // //     );
// // //     return response;
// // //   }
// // // }
// // // // 




// // // lib/services/api_service.dart
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';

// // class ApiService {
// //   static const String baseUrl = 'https://medical-api.onrender.com';

// //   static Future<http.Response> register({
// //     required String fullName,
// //     required String email,
// //     required String phoneNumber,
// //     required String password,
// //     required DateTime dateOfBirth,
// //     required String gender,
// //     required String profilePhoto,
// //     required String role,
// //   }) async {
// //     final response = await http.post(
// //       Uri.parse('$baseUrl/api/v1/auth/register'),
// //       headers: {'Content-Type': 'application/json'},
// //       body: json.encode({
// //         'fullName': fullName,
// //         'email': email,
// //         'phoneNumber': phoneNumber,
// //         'password': password,
// //         'dateOfBirth': dateOfBirth.toIso8601String(),
// //         'gender': gender,
// //         'profilePhoto': profilePhoto,
// //         'role': role,
// //       }),
// //     );
// //     return response;
// //   }

// //   static Future<http.Response> login({
// //     required String emailOrPhone,
// //     required String password,
// //   }) async {
// //     final response = await http.post(
// //       Uri.parse('$baseUrl/api/v1/auth/login'),
// //       headers: {'Content-Type': 'application/json'},
// //       body: json.encode({
// //         'emailOrPhone': emailOrPhone,
// //         'password': password,
// //       }),
// //     );
// //     return response;
// //   }

// //   static Future<Map<String, dynamic>> getUserProfile() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final token = prefs.getString('access_token');
// //     if (token == null) {
// //       throw Exception('No token found');
// //     }
// //     final response = await http.get(
// //       Uri.parse('$baseUrl/api/v1/users/me'),
// //       headers: {
// //         'Content-Type': 'application/json',
// //         'Authorization': 'Bearer $token',
// //       },
// //     );
// //     if (response.statusCode == 200) {
// //       return jsonDecode(response.body);
// //     }
// //     throw Exception('Failed to load user profile: ${response.statusCode} - ${response.body}');
// //   }
// // }


// // // lib/services/api_service.dart
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:medical/config.dart';
// // import 'auth_service.dart';

// // class ApiService {
// //   static Future<Map<String, dynamic>> getUserProfile() async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     final response = await http.get(
// //       Uri.parse('${Config.usersUrl}/me'),
// //       headers: {
// //         'Content-Type': 'application/json',
// //         'Authorization': 'Bearer $token',
// //       },
// //     ).timeout(const Duration(seconds: 10));

// //     print('GetUserProfile Response Status: ${response.statusCode}');
// //     print('GetUserProfile Response Body: ${response.body}');

// //     if (response.statusCode == 200) {
// //       final data = jsonDecode(response.body);
// //       print('GetUserProfile User ID: ${data['id']}');
// //       return data;
// //     } else {
// //       throw Exception('Échec de la récupération du profil: ${response.statusCode}');
// //     }
// //   }

// //   static Future<void> updateUserProfile(Map<String, dynamic> data) async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     print('UpdateUserProfile Request Body: ${jsonEncode(data)}');

// //     final response = await http.patch(
// //       Uri.parse('${Config.usersUrl}/me'),
// //       headers: {
// //         'Content-Type': 'application/json',
// //         'Authorization': 'Bearer $token',
// //       },
// //       body: jsonEncode(data),
// //     ).timeout(const Duration(seconds: 10));

// //     print('UpdateUserProfile Response Status: ${response.statusCode}');
// //     print('UpdateUserProfile Response Body: ${response.body}');

// //     if (response.statusCode != 200) {
// //       final errorData = jsonDecode(response.body);
// //       throw Exception(errorData['magazine'] ?? 'Échec de la mise à jour: ${response.statusCode}');
// //     }
// //   }
// // }


// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:medical/config.dart';
// // import 'auth_service.dart';

// // class ApiService {
// //   static Future<Map<String, dynamic>> getUserProfile() async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     try {
// //       final response = await http.get(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //       ).timeout(const Duration(seconds: 10));

// //       print('GetUserProfile Response Status: ${response.statusCode}');
// //       print('GetUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         if (data['id'] == null || data['id'].toString().isEmpty) {
// //           throw Exception('ID utilisateur manquant dans la réponse');
// //         }
// //         print('GetUserProfile User ID: ${data['id']}');
// //         return data;
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de la récupération du profil: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //   static Future<void> updateUserProfile(Map<String, dynamic> data) async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     print('UpdateUserProfile Request Body: ${jsonEncode(data)}');

// //     try {
// //       final response = await http.patch(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //         body: jsonEncode(data),
// //       ).timeout(const Duration(seconds: 10));

// //       print('UpdateUserProfile Response Status: ${response.statusCode}');
// //       print('UpdateUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         return;
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         final errorData = jsonDecode(response.body);
// //         throw Exception(errorData['message'] ?? 'Échec de la mise à jour: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }
// // }





// // import 'dart:io';

// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:medical/config.dart';
// // import 'auth_service.dart';

// // class ApiService {
// //   static Future<Map<String, dynamic>> getUserProfile() async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     try {
// //       final response = await http.get(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //       ).timeout(const Duration(seconds: 10));

// //       print('GetUserProfile Response Status: ${response.statusCode}');
// //       print('GetUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         if (data['id'] == null || data['id'].toString().isEmpty) {
// //           throw Exception('ID utilisateur manquant dans la réponse');
// //         }
// //         print('GetUserProfile User ID: ${data['id']}');
// //         return data;
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de la récupération du profil: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //   static Future<void> updateUserProfile(Map<String, dynamic> data) async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     print('UpdateUserProfile Request Body: ${jsonEncode(data)}');

// //     try {
// //       final response = await http.patch(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //         body: jsonEncode(data),
// //       ).timeout(const Duration(seconds: 10));

// //       print('UpdateUserProfile Response Status: ${response.statusCode}');
// //       print('UpdateUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         return;
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         final errorData = jsonDecode(response.body);
// //         throw Exception(errorData['message'] ?? 'Échec de la mise à jour: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //  static Future<String?> uploadProfilePhoto(File image) async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     try {
// //       final request = http.MultipartRequest(
// //         'POST',
// //         Uri.parse('${Config.usersUrl}/upload-photo'),
// //       );
// //       request.headers['Authorization'] = 'Bearer $token';
// //       request.files.add(await http.MultipartFile.fromPath('photo', image.path));

// //       print('Sending request to: ${request.url}');
// //       print('Headers: ${request.headers}');

// //       final response = await request.send().timeout(const Duration(seconds: 10));
// //       final responseBody = await response.stream.bytesToString();

// //       print('UploadProfilePhoto Response Status: ${response.statusCode}');
// //       print('UploadProfilePhoto Response Body: $responseBody');

// //       if (response.statusCode == 201) {
// //         final data = jsonDecode(responseBody);
// //         return data['url']?.toString();
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de l\'upload: ${response.statusCode} - $responseBody');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }
// // }




// // import 'dart:io';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:medical/config.dart';
// // import 'auth_service.dart';

// // class ApiService {
// //   static Future<Map<String, dynamic>> getUserProfile() async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     try {
// //       final response = await http.get(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //       ).timeout(const Duration(seconds: 10));

// //       print('GetUserProfile Response Status: ${response.statusCode}');
// //       print('GetUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         if (data['id'] == null || data['id'].toString().isEmpty) {
// //           throw Exception('ID utilisateur manquant dans la réponse');
// //         }
// //         print('GetUserProfile User ID: ${data['id']}');
// //         return data;
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de la récupération du profil: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //   static Future<void> updateUserProfile(Map<String, dynamic> data) async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     print('UpdateUserProfile Request Body: ${jsonEncode(data)}');

// //     try {
// //       final response = await http.patch(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //         body: jsonEncode(data),
// //       ).timeout(const Duration(seconds: 10));

// //       print('UpdateUserProfile Response Status: ${response.statusCode}');
// //       print('UpdateUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         return;
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         final errorData = jsonDecode(response.body);
// //         throw Exception(errorData['message'] ?? 'Échec de la mise à jour: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //   static Future<String?> uploadProfilePhoto(File imageFile) async {
// //     try {
// //       final token = await AuthService.getToken();
// //       if (token == null) {
// //         throw Exception('Aucun token trouvé');
// //       }

// //       final uri = Uri.parse('${Config.usersUrl}/profile-photo');
// //       final request = http.MultipartRequest('POST', uri)
// //         ..headers.addAll({
// //           'Authorization': 'Bearer $token',
// //         })
// //         ..files.add(await http.MultipartFile.fromPath(
// //           'photo',
// //           imageFile.path,
// //         ));

// //       final streamedResponse = await request.send().timeout(const Duration(seconds: 10));
// //       final response = await http.Response.fromStream(streamedResponse);

// //       print('UploadProfilePhoto Response Status: ${response.statusCode}');
// //       print('UploadProfilePhoto Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         return data['photoUrl']?.toString();
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de l\'upload: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       print('Erreur lors de l\'upload de la photo: $e');
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }
// // }



// // import 'dart:io';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:medical/config.dart';
// // import 'auth_service.dart';

// // class ApiService {
// //   static Future<Map<String, dynamic>> getUserProfile() async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     try {
// //       final response = await http.get(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //       ).timeout(const Duration(seconds: 10));

// //       print('GetUserProfile Response Status: ${response.statusCode}');
// //       print('GetUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         if (data['id'] == null || data['id'].toString().isEmpty) {
// //           throw Exception('ID utilisateur manquant dans la réponse');
// //         }
// //         print('GetUserProfile User ID: ${data['id']}');
// //         return data;
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de la récupération du profil: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //   static Future<void> updateUserProfile(Map<String, dynamic> data) async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     print('UpdateUserProfile Request Body: ${jsonEncode(data)}');

// //     try {
// //       final response = await http.patch(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //         body: jsonEncode(data),
// //       ).timeout(const Duration(seconds: 10));

// //       print('UpdateUserProfile Response Status: ${response.statusCode}');
// //       print('UpdateUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         return;
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         final errorData = jsonDecode(response.body);
// //         throw Exception(errorData['message'] ?? 'Échec de la mise à jour: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //   static Future<String?> uploadProfilePhoto(File imageFile) async {
// //     try {
// //       final token = await AuthService.getToken();
// //       if (token == null) {
// //         throw Exception('Aucun token trouvé');
// //       }

// //       final uri = Uri.parse('${Config.usersUrl}/profile-photo');
// //       final request = http.MultipartRequest('POST', uri)
// //         ..headers.addAll({
// //           'Authorization': 'Bearer $token',
// //         })
// //         ..files.add(await http.MultipartFile.fromPath(
// //           'photo',
// //           imageFile.path,
// //           filename: 'profile_photo.jpg',
// //         ));

// //       print('UploadProfilePhoto URL: $uri');
// //       print('UploadProfilePhoto Token: $token');

// //       final streamedResponse = await request.send().timeout(const Duration(seconds: 10));
// //       final response = await http.Response.fromStream(streamedResponse);

// //       print('UploadProfilePhoto Response Status: ${response.statusCode}');
// //       print('UploadProfilePhoto Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         return data['photoUrl']?.toString();
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de l\'upload: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       print('Erreur lors de l\'upload de la photo: $e');
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }
// // }


// // // lib/services/api_service.dart

// // import 'dart:io';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:medical/config.dart';
// // import 'auth_service.dart';

// // class ApiService {
// //   static Future<Map<String, dynamic>> getUserProfile() async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     try {
// //       final response = await http.get(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //       ).timeout(const Duration(seconds: 10));

// //       print('GetUserProfile Response Status: ${response.statusCode}');
// //       print('GetUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         if (data['id'] == null || data['id'].toString().isEmpty) {
// //           throw Exception('ID utilisateur manquant dans la réponse');
// //         }
// //         print('GetUserProfile User ID: ${data['id']}');
// //         return data;
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de la récupération du profil: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //   static Future<void> updateUserProfile(Map<String, dynamic> data) async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     print('UpdateUserProfile Request Body: ${jsonEncode(data)}');

// //     try {
// //       final response = await http.patch(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $token',
// //         },
// //         body: jsonEncode(data),
// //       ).timeout(const Duration(seconds: 10));

// //       print('UpdateUserProfile Response Status: ${response.statusCode}');
// //       print('UpdateUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         return;
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         final errorData = jsonDecode(response.body);
// //         throw Exception(errorData['message'] ?? 'Échec de la mise à jour: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //   static Future<String?> uploadProfilePhoto(File imageFile) async {
// //     try {
// //       final token = await AuthService.getToken();
// //       if (token == null) {
// //         throw Exception('Aucun token trouvé');
// //       }

// //       final uri = Uri.parse('${Config.usersUrl}/profile-photo');
// //       final request = http.MultipartRequest('POST', uri)
// //         ..headers.addAll({
// //           'Authorization': 'Bearer $token',
// //         })
// //         ..files.add(await http.MultipartFile.fromPath(
// //           'photo',
// //           imageFile.path,
// //           filename: 'profile_photo.jpg',
// //         ));

// //       print('UploadProfilePhoto URL: $uri');
// //       print('UploadProfilePhoto Token: $token');

// //       final streamedResponse = await request.send().timeout(const Duration(seconds: 10));
// //       final response = await http.Response.fromStream(streamedResponse);

// //       print('UploadProfilePhoto Response Status: ${response.statusCode}');
// //       print('UploadProfilePhoto Response Body: ${response.body}');

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         final data = jsonDecode(response.body);
// //         return data['photoUrl']?.toString();
// //       } else if (response.statusCode == 401) {
// //         await AuthService.logout();
// //         throw Exception('Session expirée, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de l\'upload: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       print('Erreur lors de l\'upload de la photo: $e');
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }
// // }

// // // lib/services/api_service.dart


// // import 'dart:io';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'package:medical/config.dart';
// // import 'auth_service.dart';

// // class ApiService {
// //   static Future<Map<String, dynamic>> getUserProfile() async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     try {
// //       final response = await http.get(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: await Config.authHeaders,
// //       ).timeout(Config.timeoutDuration);

// //       print('GetUserProfile Response Status: ${response.statusCode}');
// //       print('GetUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         if (data['id'] == null || data['id'].toString().isEmpty) {
// //           throw Exception('ID utilisateur manquant dans la réponse');
// //         }
// //         print('GetUserProfile User ID: ${data['id']}');
// //         return data;
// //       } else if (response.statusCode == 401) {
// //         throw Exception('Session invalide, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de la récupération du profil: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //   static Future<void> updateUserProfile(Map<String, dynamic> data) async {
// //     final token = await AuthService.getToken();
// //     if (token == null) {
// //       throw Exception('Aucun token trouvé');
// //     }

// //     print('UpdateUserProfile Request Body: ${jsonEncode(data)}');

// //     try {
// //       final response = await http.patch(
// //         Uri.parse('${Config.usersUrl}/me'),
// //         headers: await Config.authHeaders,
// //         body: jsonEncode(data),
// //       ).timeout(Config.timeoutDuration);

// //       print('UpdateUserProfile Response Status: ${response.statusCode}');
// //       print('UpdateUserProfile Response Body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         return;
// //       } else if (response.statusCode == 401) {
// //         throw Exception('Session invalide, veuillez vous reconnecter');
// //       } else {
// //         final errorData = jsonDecode(response.body);
// //         throw Exception(errorData['message'] ?? 'Échec de la mise à jour: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }

// //   static Future<String?> uploadProfilePhoto(File imageFile) async {
// //     try {
// //       final token = await AuthService.getToken();
// //       if (token == null) {
// //         throw Exception('Aucun token trouvé');
// //       }

// //       final uri = Uri.parse('${Config.usersUrl}/profile-photo');
// //       final request = http.MultipartRequest('POST', uri)
// //         ..headers.addAll({
// //           'Authorization': 'Bearer $token',
// //         })
// //         ..files.add(await http.MultipartFile.fromPath(
// //           'photo',
// //           imageFile.path,
// //           filename: 'profile_photo.jpg',
// //         ));

// //       print('UploadProfilePhoto URL: $uri');
// //       print('UploadProfilePhoto Token: $token');

// //       final streamedResponse = await request.send().timeout(Config.timeoutDuration);
// //       final response = await http.Response.fromStream(streamedResponse);

// //       print('UploadProfilePhoto Response Status: ${response.statusCode}');
// //       print('UploadProfilePhoto Response Body: ${response.body}');

// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         final data = jsonDecode(response.body);
// //         return data['photoUrl']?.toString();
// //       } else if (response.statusCode == 401) {
// //         throw Exception('Session invalide, veuillez vous reconnecter');
// //       } else {
// //         throw Exception('Échec de l\'upload: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       print('Erreur lors de l\'upload de la photo: $e');
// //       throw Exception('Erreur réseau ou serveur: $e');
// //     }
// //   }
// // }



// import 'dart:io';
//      import 'package:http/http.dart' as http;
//      import 'dart:convert';
//      import 'package:medical/config.dart';
//      import 'auth_service.dart';

//      class ApiService {
//        static Future<Map<String, dynamic>> getUserProfile() async {
//          final token = await AuthService.getToken();
//          if (token == null) {
//            throw Exception('Aucun token trouvé');
//          }

//          try {
//            final response = await http.get(
//              Uri.parse('${Config.usersUrl}/me'),
//              headers: await Config.authHeaders,
//            ).timeout(Config.timeoutDuration);

//            print('GetUserProfile Response Status: ${response.statusCode}');
//            print('GetUserProfile Response Body: ${response.body}');

//            if (response.statusCode == 200) {
//              final data = jsonDecode(response.body);
//              if (data['id'] == null || data['id'].toString().isEmpty) {
//                throw Exception('ID utilisateur manquant dans la réponse');
//              }
//              print('GetUserProfile User ID: ${data['id']}');
//              return data;
//            } else if (response.statusCode == 401) {
//              throw Exception('Session invalide, veuillez vous reconnecter');
//            } else {
//              throw Exception('Échec de la récupération du profil: ${response.statusCode}');
//            }
//          } catch (e) {
//            throw Exception('Erreur réseau ou serveur: $e');
//          }
//        }

//        static Future<void> updateUserProfile(Map<String, dynamic> data) async {
//          final token = await AuthService.getToken();
//          if (token == null) {
//            throw Exception('Aucun token trouvé');
//          }

//          print('UpdateUserProfile Request Body: ${jsonEncode(data)}');

//          try {
//            final response = await http.patch(
//              Uri.parse('${Config.usersUrl}/me'),
//              headers: await Config.authHeaders,
//              body: jsonEncode(data),
//            ).timeout(Config.timeoutDuration);

//            print('UpdateUserProfile Response Status: ${response.statusCode}');
//            print('UpdateUserProfile Response Body: ${response.body}');

//            if (response.statusCode == 200) {
//              return;
//            } else if (response.statusCode == 401) {
//              throw Exception('Session invalide, veuillez vous reconnecter');
//            } else {
//              final errorData = jsonDecode(response.body);
//              throw Exception(errorData['message'] ?? 'Échec de la mise à jour: ${response.statusCode}');
//            }
//          } catch (e) {
//            throw Exception('Erreur réseau ou serveur: $e');
//          }
//        }

//        static Future<String?> uploadProfilePhoto(File imageFile) async {
//          try {
//            final token = await AuthService.getToken();
//            if (token == null) {
//              throw Exception('Aucun token trouvé');
//            }

//            final uri = Uri.parse('${Config.usersUrl}/profile-photo');
//            final request = http.MultipartRequest('POST', uri)
//              ..headers.addAll({
//                'Authorization': 'Bearer $token',
//              })
//              ..files.add(await http.MultipartFile.fromPath(
//                'photo',
//                imageFile.path,
//                filename: 'profile_photo.jpg',
//              ));

//            print('UploadProfilePhoto URL: $uri');
//            print('UploadProfilePhoto Token: $token');

//            final streamedResponse = await request.send().timeout(Config.timeoutDuration);
//            final response = await http.Response.fromStream(streamedResponse);

//            print('UploadProfilePhoto Response Status: ${response.statusCode}');
//            print('UploadProfilePhoto Response Body: ${response.body}');

//            if (response.statusCode == 200 || response.statusCode == 201) {
//              final data = jsonDecode(response.body);
//              return data['photoUrl']?.toString();
//            } else if (response.statusCode == 401) {
//              throw Exception('Session invalide, veuillez vous reconnecter');
//            } else {
//              throw Exception('Échec de l\'upload: ${response.statusCode}');
//            }
//          } catch (e) {
//            print('Erreur lors de l\'upload de la photo: $e');
//            throw Exception('Erreur réseau ou serveur: $e');
//          }
//        }
//  static Future<void> updateProfessionalProfile(String userId, Map<String, dynamic> data) async {
//     try {
//       final token = await AuthService.getToken();
//       if (token == null) throw Exception('Utilisateur non authentifié');

//       final response = await http.put(
//         Uri.parse('${Config.usersUrl}/$userId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(data),
//       ).timeout(Config.timeoutDuration);

//       if (response.statusCode != 200) {
//         throw Exception('Erreur ${response.statusCode}: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Erreur lors de la mise à jour du profil: $e');
//     }
//   }

//        static Future<Map<String, dynamic>?> getProfessionalByUser() async {
//          final token = await AuthService.getToken();
//          if (token == null) {
//            throw Exception('Aucun token trouvé');
//          }

//          try {
//            final response = await http.get(
//              Uri.parse('${Config.baseUrl}/api/v1/professionals/me'),
//              headers: await Config.authHeaders,
//            ).timeout(Config.timeoutDuration);

//            print('GetProfessionalByUser Response Status: ${response.statusCode}');
//            print('GetProfessionalByUser Response Body: ${response.body}');

//            if (response.statusCode == 200) {
//              final data = jsonDecode(response.body);
//              return data;
//            } else if (response.statusCode == 404) {
//              return null; // Aucun professionnel associé
//            } else if (response.statusCode == 401) {
//              throw Exception('Session invalide, veuillez vous reconnecter');
//            } else {
//              throw Exception('Échec de la récupération du professionnel: ${response.statusCode}');
//            }
//          } catch (e) {
//            throw Exception('Erreur réseau ou serveur: $e');
//          }
//        }
//      }





// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:medical/config.dart';
// import 'package:medical/models/professional_model.dart';
// import 'package:medical/models/user_model.dart';
// import 'auth_service.dart';

// class ApiService {
//   static Future<UserModel> getUserProfile() async {
//     final token = await AuthService.getToken();
//     if (token == null) {
//       throw Exception('Aucun token trouvé');
//     }

//     try {
//       final response = await http.get(
//         Uri.parse('${Config.usersUrl}/me'),
//         headers: await Config.authHeaders,
//       ).timeout(Config.timeoutDuration);

//       print('GetUserProfile Response Status: ${response.statusCode}');
//       print('GetUserProfile Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['id'] == null || data['id'].toString().isEmpty) {
//           throw Exception('ID utilisateur manquant dans la réponse');
//         }
//         print('GetUserProfile User ID: ${data['id']}');
//         // If the user is a professional, return a ProfessionalModel
//         if (data['role'] == 'professional') {
//           return ProfessionalModel.fromMap(data);
//         }
//         return UserModel.fromMap(data);
//       } else if (response.statusCode == 401) {
//         throw Exception('Session invalide, veuillez vous reconnecter');
//       } else {
//         throw Exception('Échec de la récupération du profil: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Erreur réseau ou serveur: $e');
//     }
//   }

//   static Future<void> updateUserProfile(Map<String, dynamic> data) async {
//     final token = await AuthService.getToken();
//     if (token == null) {
//       throw Exception('Aucun token trouvé');
//     }

//     print('UpdateUserProfile Request Body: ${jsonEncode(data)}');

//     try {
//       final response = await http.patch(
//         Uri.parse('${Config.usersUrl}/me'),
//         headers: await Config.authHeaders,
//         body: jsonEncode(data),
//       ).timeout(Config.timeoutDuration);

//       print('UpdateUserProfile Response Status: ${response.statusCode}');
//       print('UpdateUserProfile Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         return;
//       } else if (response.statusCode == 401) {
//         throw Exception('Session invalide, veuillez vous reconnecter');
//       } else {
//         final errorData = jsonDecode(response.body);
//         throw Exception(errorData['message'] ?? 'Échec de la mise à jour: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Erreur réseau ou serveur: $e');
//     }
//   }

//   static Future<String?> uploadProfilePhoto(File imageFile) async {
//     try {
//       final token = await AuthService.getToken();
//       if (token == null) {
//         throw Exception('Aucun token trouvé');
//       }

//       final uri = Uri.parse('${Config.usersUrl}/profile-photo');
//       final request = http.MultipartRequest('POST', uri)
//         ..headers.addAll({
//           'Authorization': 'Bearer $token',
//         })
//         ..files.add(await http.MultipartFile.fromPath(
//           'photo',
//           imageFile.path,
//           filename: 'profile_photo.jpg',
//         ));

//       print('UploadProfilePhoto URL: $uri');
//       print('UploadProfilePhoto Token: $token');

//       final streamedResponse = await request.send().timeout(Config.timeoutDuration);
//       final response = await http.Response.fromStream(streamedResponse);

//       print('UploadProfilePhoto Response Status: ${response.statusCode}');
//       print('UploadProfilePhoto Response Body: ${response.body}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         return data['photoUrl']?.toString();
//       } else if (response.statusCode == 401) {
//         throw Exception('Session invalide, veuillez vous reconnecter');
//       } else {
//         throw Exception('Échec de l\'upload: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Erreur lors de l\'upload de la photo: $e');
//       throw Exception('Erreur réseau ou serveur: $e');
//     }
//   }

//   static Future<void> updateProfessionalProfile(String userId, Map<String, dynamic> data) async {
//     try {
//       final token = await AuthService.getToken();
//       if (token == null) throw Exception('Utilisateur non authentifié');

//       print('UpdateProfessionalProfile Request Body: ${jsonEncode(data)}');

//       final response = await http.put(
//         Uri.parse('${Config.usersUrl}/$userId'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(data),
//       ).timeout(Config.timeoutDuration);

//       print('UpdateProfessionalProfile Response Status: ${response.statusCode}');
//       print('UpdateProfessionalProfile Response Body: ${response.body}');

//       if (response.statusCode != 200) {
//         throw Exception('Erreur ${response.statusCode}: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Erreur lors de la mise à jour du profil: $e');
//     }
//   }

//   static Future<ProfessionalModel?> getProfessionalByUser() async {
//     final token = await AuthService.getToken();
//     if (token == null) {
//       throw Exception('Aucun token trouvé');
//     }

//     try {
//       final response = await http.get(
//         Uri.parse('${Config.baseUrl}/api/v1/professionals/me'),
//         headers: await Config.authHeaders,
//       ).timeout(Config.timeoutDuration);

//       print('GetProfessionalByUser Response Status: ${response.statusCode}');
//       print('GetProfessionalByUser Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         return ProfessionalModel.fromMap(data);
//       } else if (response.statusCode == 404) {
//         return null; // Aucun professionnel associé
//       } else if (response.statusCode == 401) {
//         throw Exception('Session invalide, veuillez vous reconnecter');
//       } else {
//         throw Exception('Échec de la récupération du professionnel: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Erreur réseau ou serveur: $e');
//     }
//   }
// }







import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medical/config.dart';
import 'package:medical/models/professional_model.dart';
import 'package:medical/models/user_model.dart';
import 'auth_service.dart';

class ApiService {
  static Future<UserModel> getUserProfile() async {
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('Aucun token trouvé');
    }

    try {
      final response = await http.get(
        Uri.parse('${Config.usersUrl}/me'),
        headers: await Config.authHeaders,
      ).timeout(Config.timeoutDuration);

      print('GetUserProfile Response Status: ${response.statusCode}');
      print('GetUserProfile Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['id'] == null || data['id'].toString().isEmpty) {
          throw Exception('ID utilisateur manquant dans la réponse');
        }
        print('GetUserProfile User ID: ${data['id']}');
        if (data['role'] == 'professional') {
          return ProfessionalModel.fromMap(data);
        }
        return UserModel.fromMap(data);
      } else if (response.statusCode == 401) {
        throw Exception('Session invalide, veuillez vous reconnecter');
      } else {
        throw Exception('Échec de la récupération du profil: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur réseau ou serveur: $e');
    }
  }

  static Future<void> updateUserProfile(Map<String, dynamic> data) async {
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('Aucun token trouvé');
    }

    print('UpdateUserProfile Request Body: ${jsonEncode(data)}');

    try {
      final response = await http.patch(
        Uri.parse('${Config.usersUrl}/me'),
        headers: await Config.authHeaders,
        body: jsonEncode(data),
      ).timeout(Config.timeoutDuration);

      print('UpdateUserProfile Response Status: ${response.statusCode}');
      print('UpdateUserProfile Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 401) {
        throw Exception('Session invalide, veuillez vous reconnecter');
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Échec de la mise à jour: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur réseau ou serveur: $e');
    }
  }

  static Future<String?> uploadProfilePhoto(File imageFile) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception('Aucun token trouvé');
      }

      final uri = Uri.parse('${Config.usersUrl}/profile-photo');
      final request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'Authorization': 'Bearer $token',
        })
        ..files.add(await http.MultipartFile.fromPath(
          'photo',
          imageFile.path,
          filename: 'profile_photo.jpg',
        ));

      print('UploadProfilePhoto URL: $uri');
      print('UploadProfilePhoto Token: $token');

      final streamedResponse = await request.send().timeout(Config.timeoutDuration);
      final response = await http.Response.fromStream(streamedResponse);

      print('UploadProfilePhoto Response Status: ${response.statusCode}');
      print('UploadProfilePhoto Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['photoUrl']?.toString();
      } else if (response.statusCode == 401) {
        throw Exception('Session invalide, veuillez vous reconnecter');
      } else {
        throw Exception('Échec de l\'upload: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de l\'upload de la photo: $e');
      throw Exception('Erreur réseau ou serveur: $e');
    }
  }

  static Future<ProfessionalModel> updateProfessionalProfile(String userId, Map<String, dynamic> data) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception('Utilisateur non authentifié');
      }

      print('UpdateProfessionalProfile Request Body: ${jsonEncode(data)}');

      final response = await http.put(
        Uri.parse('${Config.usersUrl}/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      ).timeout(Config.timeoutDuration);

      print('UpdateProfessionalProfile Response Status: ${response.statusCode}');
      print('UpdateProfessionalProfile Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return ProfessionalModel.fromMap(responseData);
      } else if (response.statusCode == 401) {
        throw Exception('Session invalide, veuillez vous reconnecter');
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour du profil: $e');
    }
  }

  static Future<ProfessionalModel?> getProfessionalByUser() async {
    final token = await AuthService.getToken();
    if (token == null) {
      throw Exception('Aucun token trouvé');
    }

    try {
      final response = await http.get(
        Uri.parse('${Config.baseUrl}/api/v1/professionals/me'),
        headers: await Config.authHeaders,
      ).timeout(Config.timeoutDuration);

      print('GetProfessionalByUser Response Status: ${response.statusCode}');
      print('GetProfessionalByUser Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ProfessionalModel.fromMap(data);
      } else if (response.statusCode == 404) {
        return null; // Aucun professionnel associé
      } else if (response.statusCode == 401) {
        throw Exception('Session invalide, veuillez vous reconnecter');
      } else {
        throw Exception('Échec de la récupération du professionnel: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur réseau ou serveur: $e');
    }
  }
}