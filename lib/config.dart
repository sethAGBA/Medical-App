// import 'dart:io';

// class Config {
//   static String get baseUrl {
//     if (Platform.isAndroid) {
//       return 'http://10.0.2.2:3000'; // Emulator
//     } else if (Platform.isIOS) {
//       return 'http://localhost:3000'; // iOS Simulator
//     } else {
//       return 'http://192.168.1.x:3000'; // Replace with your machine IP
//     }
//   }
// }


// import 'dart:io';

// // class Config {
// //   static String get baseUrl {
// //     if (Platform.isAndroid) {
// //       // Android Emulator: Use 10.0.2.2 to reach host machine
// //       return 'http://10.0.2.2:3000';
      
// //     } else if (Platform.isIOS) {
// //       // iOS Simulator: localhost works as it runs on the host machine
// //       return 'http://localhost:3000';
// //     } else {
// //       // Physical devices: Use your machine's IP (adjust as needed)
// //       // return 'http://10.1.1.54:3000'; // Your macOS IP from ifconfig
// //       return 'http://127.0.0.1:3000'; // Your macOS IP from ifconfig
// //     }
// //   }
// // }

// class Config {
//   static const String baseUrl = 'https://medical-api.onrender.com'; // URL de Render
// }


// import 'dart:io';

// class Config {
//   static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  
//   static String get baseUrl {
//     if (isProduction) {
//       return 'https://medical-api.onrender.com'; // URL de production sur Render
//     }

//     // Environnement de développement
//     if (Platform.isAndroid) {
//       return 'http://10.0.2.2:3000'; // Android Emulator
//     } else if (Platform.isIOS) {
//       return 'http://localhost:3000'; // iOS Simulator
//     } else {
//       return 'http://127.0.0.1:3000'; // Development sur Desktop
//     }
//   }

//   // Autres configurations
//   static const Duration timeoutDuration = Duration(seconds: 30);
//   static const String apiVersion = 'v1';

//   // Headers par défaut
//   static Map<String, String> get defaultHeaders => {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//   };
// }

// //config.dart
// import 'dart:io';

// class Config {
//   static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  
//   static String get baseUrl {
//     if (isProduction) {
//       return 'https://medical-api.onrender.com'; // URL de production Render
//     }

//     // Environnement de développement
//     if (Platform.isAndroid) {
//       return 'http://10.0.2.2:3000';    // Android Emulator
//     } else if (Platform.isIOS) {
//       return 'http://localhost:3000';    // iOS Simulator
//     } else {
//       return 'http://127.0.0.1:3000';    // Development sur Desktop
//     }
//   }

//   // Configuration des temps de réponse
//   static const Duration timeoutDuration = Duration(seconds: 30);
//   static const String apiVersion = 'v1';

//   // Headers par défaut pour les requêtes API
//   static Map<String, String> get defaultHeaders => {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     'Access-Control-Allow-Origin': '*',
//   };

//   // URL spécifiques de l'API
//   static String get authUrl => '$baseUrl/api/v1/auth';
//   static String get usersUrl => '$baseUrl/api/v1/users';
//   static String get appointmentsUrl => '$baseUrl/api/v1/appointments';
// }
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  static String? _jwtToken;
  
  // Getter et Setter pour le JWT Token
  static String? get jwtToken => _jwtToken;
  static set jwtToken(String? value) => _jwtToken = value;

  static String get baseUrl {
    if (isProduction) {
      // return 'https://medical-api.onrender.com';
      return 'https://medical-api-t14f.onrender.com';
    }

    // Environnement de développement
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';    // Android Emulator
    } else if (Platform.isIOS) {
      return 'http://localhost:3000';    // iOS Simulator
    } else {
      return 'http://127.0.0.1:3000';    // Development sur Desktop
    }
  }

  // Configuration des temps de réponse
  static const Duration timeoutDuration = Duration(seconds: 30);
  
  // Headers avec authentification
  static Map<String, String> get authHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (_jwtToken != null) 'Authorization': 'Bearer $_jwtToken',
  };

  // Headers sans authentification
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // URLs de l'API
  static String get authUrl => '$baseUrl/api/v1/auth';
  static String get usersUrl => '$baseUrl/api/v1/users';
  static String get appointmentsUrl => '$baseUrl/api/v1/appointments';

  // Méthodes de gestion du token
  static Future<void> saveToken(String token) async {
    _jwtToken = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  static Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _jwtToken = prefs.getString('jwt_token');
  }

  static Future<void> removeToken() async {
    _jwtToken = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}