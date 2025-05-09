// // // lib/services/auth_service.dart
// // import 'package:shared_preferences/shared_preferences.dart';
// // import '../models/user_model.dart';
// // import 'dart:convert';

// // class AuthService {
// //   static const String _userKey = 'current_user';
// //   static const String _tokenKey = 'access_token';
// //   static UserModel? _currentUser;

// //   static Future<UserModel?> getCurrentUser() async {
// //     if (_currentUser != null) {
// //       print('Current user from cache: ${_currentUser!.id}');
// //       return _currentUser;
// //     }

// //     final prefs = await SharedPreferences.getInstance();
// //     final userStr = prefs.getString(_userKey);
// //     if (userStr != null) {
// //       final userData = json.decode(userStr);
// //       _currentUser = UserModel.fromMap(userData);
// //       print('Current user from SharedPreferences: ${_currentUser!.id}');
// //       return _currentUser;
// //     }
// //     return null;
// //   }

// //   static Future<void> saveUser(UserModel user) async {
// //     print('Saving user: ${user.id}');
// //     _currentUser = user;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString(_userKey, json.encode(user.toJson()));
// //   }

// //   static Future<void> saveToken(String token) async {
// //     print('Saving token');
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString(_tokenKey, token);
// //   }

// //   static Future<String?> getToken() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     return prefs.getString(_tokenKey);
// //   }

// //   static Future<void> logout() async {
// //     print('Logging out user: ${_currentUser?.id}');
// //     _currentUser = null;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.remove(_userKey);
// //     await prefs.remove(_tokenKey);
// //   }
// // }



// // // lib/services/auth_service.dart

// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/user_model.dart';
// import 'dart:convert';

// class AuthService {
//   static const String _userKey = 'current_user';
//   static const String _tokenKey = 'access_token';
//   static UserModel? _currentUser;

//   static Future<UserModel?> getCurrentUser({bool forceRefresh = false}) async {
//     if (_currentUser != null && !forceRefresh) {
//       print('Current user from cache: ${_currentUser!.id}');
//       return _currentUser;
//     }

//     final prefs = await SharedPreferences.getInstance();
//     final userStr = prefs.getString(_userKey);
//     if (userStr != null) {
//       final userData = json.decode(userStr);
//       _currentUser = UserModel.fromMap(userData);
//       print('Current user from SharedPreferences: ${_currentUser!.id}');
//       return _currentUser;
//     }
//     return null;
//   }

//   static Future<void> saveUser(UserModel user) async {
//     if (user.id.isEmpty) {
//       print('Error: Attempted to save user with empty ID');
//       return;
//     }
//     print('Saving user: ${user.id}');
//     _currentUser = user;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_userKey, json.encode(user.toJson()));
//   }

//   static Future<void> saveToken(String token) async {
//     print('Saving token');
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_tokenKey, token);
//   }

//   static Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_tokenKey);
//   }

//   static Future<void> logout() async {
//     print('Logging out user: ${_currentUser?.id}');
//     _currentUser = null;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_userKey);
//     await prefs.remove(_tokenKey);
//   }
// }

import 'package:medical/models/professional_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../models/user_model.dart';
import 'api_service.dart';
import 'dart:convert';

class AuthService {
  static const String _userKey = 'current_user';
  static const String _tokenKey = 'access_token';

  static Future<UserModel?> getCurrentUser({bool forceRefresh = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userStr = prefs.getString(_userKey);
      final token = prefs.getString(_tokenKey);

      if (userStr == null || token == null) {
        await prefs.remove(_userKey);
        await prefs.remove(_tokenKey);
        print('No user or token found');
        return null;
      }

      if (forceRefresh) {
        try {
          final user = await ApiService.getUserProfile();
          await prefs.setString(_userKey, json.encode(user.toJson()));
          print('Refreshed user: ${user.id}');
          return user;
        } catch (e) {
          print('Refresh failed, using local data: $e');
          try {
            final userData = json.decode(userStr);
            return userData['role'] == 'professional'
                ? ProfessionalModel.fromMap(userData)
                : UserModel.fromMap(userData);
          } catch (e) {
            print('Error parsing local data: $e');
            await prefs.remove(_userKey);
            await prefs.remove(_tokenKey);
            return null;
          }
        }
      }

      try {
        final userData = json.decode(userStr);
        final user = userData['role'] == 'professional'
            ? ProfessionalModel.fromMap(userData)
            : UserModel.fromMap(userData);
        print('Retrieved user: ${user.id}');
        return user;
      } catch (e) {
        print('Error parsing user data: $e');
        await prefs.remove(_userKey);
        await prefs.remove(_tokenKey);
        return null;
      }
    } catch (e) {
      print('Error retrieving user: $e');
      return null;
    }
  }

  static Future<void> saveUserAndToken(UserModel user, String token) async {
    if (user.id.isEmpty) {
      print('Error: Attempted to save user with empty ID');
      return;
    }
    print('Saving user: ${user.id}, token: $token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, json.encode(user.toJson()));
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    print('Retrieved token: ${token != null ? "present" : "absent"}');
    return token;
  }

  static Future<void> logout() async {
    print('Logging out');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_tokenKey);
    await DefaultCacheManager().emptyCache();
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}