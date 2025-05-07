// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/user_model.dart';
// import '../config.dart';

// enum CountryCode {
//   togo('+228', Colors.green, 'assets/images/togo_flag.png'),
//   france('+33', Colors.blue, 'assets/images/france_flag.png'),
//   usa('+1', Colors.red, 'assets/images/usa_flag.jpeg');

//   final String code;
//   final Color color;
//   final String flagPath;
//   const CountryCode(this.code, this.color, this.flagPath);
// }

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final _emailController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordController = TextEditingController();

//   bool _usePhoneNumber = false;
//   bool _obscureText = true;
//   bool _isLoading = false;
//   CountryCode _selectedCountry = CountryCode.togo;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _phoneNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   bool _validateEmailOrPhone(String value) {
//     if (_usePhoneNumber) {
//       switch (_selectedCountry) {
//         case CountryCode.togo:
//           return RegExp(r'^[9][0-1][0-9]{6}$').hasMatch(value) && value.length == 8;
//         case CountryCode.france:
//           return RegExp(r'^[6-7][0-9]{8}$').hasMatch(value) && value.length == 9;
//         case CountryCode.usa:
//           return RegExp(r'^[2-9][0-9]{9}$').hasMatch(value) && value.length == 10;
//       }
//     }
//     return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
//   }

//   bool _validatePassword(String password) {
//     return password.length >= 6;
//   }

//   // Future<void> _handleSignIn() async {
//   //   final emailOrPhone = _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
//   //   final password = _passwordController.text.trim();

//   //   if (emailOrPhone.isEmpty || password.isEmpty) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Veuillez remplir tous les champs')),
//   //     );
//   //     return;
//   //   }

//   //   if (!_validateEmailOrPhone(emailOrPhone)) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text(_usePhoneNumber
//   //             ? 'Numéro invalide (${_selectedCountry == CountryCode.togo ? "8 chiffres" : _selectedCountry == CountryCode.france ? "9 chiffres" : "10 chiffres"})'
//   //             : 'Email invalide (ex: nom@domaine.com)'),
//   //       ),
//   //     );
//   //     return;
//   //   }

//   //   if (!_validatePassword(password)) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Le mot de passe doit contenir au moins 6 caractères')),
//   //     );
//   //     return;
//   //   }

//   //   setState(() => _isLoading = true);

//   //   try {
//   //     final requestBody = {
//   //       'emailOrPhone': _usePhoneNumber ? _selectedCountry.code + emailOrPhone : emailOrPhone,
//   //       'password': password,
//   //     };

//   //     print('Login Request Body: ${jsonEncode(requestBody)}');

//   //     final response = await http.post(
//   //       Uri.parse('${Config.baseUrl}/auth/login'),
//   //       headers: {'Content-Type': 'application/json'},
//   //       body: jsonEncode(requestBody),
//   //     );

//   //     print('Login Response Status: ${response.statusCode}');
//   //     print('Login Response Body: ${response.body}');

//   //     if (response.statusCode == 200 || response.statusCode == 201) {
//   //       final data = jsonDecode(response.body);
//   //       final user = UserModel.fromMap(data['user']);
//   //       final token = data['access_token'];

//   //       final prefs = await SharedPreferences.getInstance();
//   //       await prefs.setString('access_token', token);

//   //       print('User Model: ${user.toJson()}');
//   //       print('Tentative de navigation vers /redirect');

//   //       Navigator.pushNamedAndRemoveUntil(
//   //         context,
//   //         '/redirect',
//   //         (route) => false,
//   //         arguments: user,
//   //       );
//   //       print('Navigation réussie');
//   //     } else {
//   //       throw Exception('Échec de la connexion: ${response.statusCode} - ${response.body}');
//   //     }
//   //   } on FormatException catch (e) {
//   //     print('FormatException: $e');
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Erreur de format de réponse: $e')),
//   //       );
//   //     }
//   //   } on http.ClientException catch (e) {
//   //     print('ClientException: $e');
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Erreur réseau: $e')),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     print('Erreur capturée: $e');
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Erreur inattendue: $e')),
//   //       );
//   //     }
//   //   } finally {
//   //     if (mounted) setState(() => _isLoading = false);
//   //   }
//   // }

// // lib/screens/signin_screen.dart
// Future<void> _handleSignIn() async {
//   final emailOrPhone = _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
//   final password = _passwordController.text.trim();

//   if (emailOrPhone.isEmpty || password.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Veuillez remplir tous les champs')),
//     );
//     return;
//   }

//   if (!_validateEmailOrPhone(emailOrPhone)) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(_usePhoneNumber
//             ? 'Numéro invalide (${_selectedCountry == CountryCode.togo ? "8 chiffres" : _selectedCountry == CountryCode.france ? "9 chiffres" : "10 chiffres"})'
//             : 'Email invalide (ex: nom@domaine.com)'),
//       ),
//     );
//     return;
//   }

//   if (!_validatePassword(password)) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Le mot de passe doit contenir au moins 6 caractères')),
//     );
//     return;
//   }

//   setState(() => _isLoading = true);

//   try {
//     final requestBody = {
//       'emailOrPhone': _usePhoneNumber ? _selectedCountry.code + emailOrPhone : emailOrPhone,
//       'password': password,
//     };

//     print('Login Request Body: ${jsonEncode(requestBody)}');

//     final response = await http.post(
//       Uri.parse('${Config.authUrl}/login'),
//       headers: Config.defaultHeaders,
//       body: jsonEncode(requestBody),
//     );

//     print('Login Response Status: ${response.statusCode}');
//     print('Login Response Body: ${response.body}');

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final data = jsonDecode(response.body);
//       final user = UserModel.fromMap(data['user']);
//       final token = data['access_token'];

//       await Config.saveToken(token); // Utiliser Config.saveToken()

//       print('User Model: ${user.toJson()}');
//       print('Tentative de navigation vers /redirect');

//       if (mounted) {
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           '/redirect',
//           (route) => false,
//           arguments: user,
//         );
//         print('Navigation réussie');
//       }
//     } else {
//       throw Exception('Échec de la connexion: ${response.statusCode} - ${response.body}');
//     }
//   } catch (e) {
//     print('Erreur capturée: $e');
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Erreur inattendue: $e')),
//       );
//     }
//   } finally {
//     if (mounted) setState(() => _isLoading = false);
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('assets/images/login.png', height: 200),
//               const SizedBox(height: 30),
//               const Text(
//                 'Content de te revoir !',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
//               ),
//               const SizedBox(height: 40),
//               _buildEmailOrPhoneField(),
//               const SizedBox(height: 20),
//               _buildPasswordField(),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _handleSignIn,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 7, 56, 9),
//                   padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                 ),
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text('Se connecter', style: TextStyle(color: Colors.white, fontSize: 18)),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Pas de compte ? ', style: TextStyle(fontSize: 16, color: Colors.grey)),
//                   TextButton(
//                     onPressed: () => Navigator.pushNamed(context, '/signup'),
//                     child: const Text('Inscrivez-vous', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmailOrPhoneField() {
//     return Row(
//       children: [
//         if (_usePhoneNumber) ...[
//           DropdownButton<CountryCode>(
//             value: _selectedCountry,
//             items: CountryCode.values
//                 .map((country) => DropdownMenuItem(
//                       value: country,
//                       child: Row(
//                         children: [
//                           Image.asset(country.flagPath, width: 24, height: 24),
//                           const SizedBox(width: 8),
//                           Text(country.code, style: TextStyle(color: country.color)),
//                         ],
//                       ),
//                     ))
//                 .toList(),
//             onChanged: (value) => setState(() {
//               _selectedCountry = value!;
//               _phoneNumberController.clear();
//             }),
//             underline: const SizedBox(),
//           ),
//           const SizedBox(width: 8),
//           SizedBox(
//             width: 60,
//             child: TextField(
//               controller: TextEditingController(text: _selectedCountry.code),
//               readOnly: true,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//         ],
//         Expanded(
//           child: TextField(
//             controller: _usePhoneNumber ? _phoneNumberController : _emailController,
//             keyboardType: _usePhoneNumber ? TextInputType.phone : TextInputType.emailAddress,
//             decoration: InputDecoration(
//               labelText: _usePhoneNumber
//                   ? 'Numéro (ex: ${_selectedCountry == CountryCode.togo ? "90123456" : _selectedCountry == CountryCode.france ? "612345678" : "2025550123"})'
//                   : 'Email (ex: nom@domaine.com)',
//               prefixIcon: Icon(_usePhoneNumber ? Icons.phone : Icons.email, color: Colors.grey),
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         IconButton(
//           icon: Icon(_usePhoneNumber ? Icons.email : Icons.phone, color: _usePhoneNumber ? Colors.grey : _selectedCountry.color),
//           onPressed: () => setState(() {
//             _usePhoneNumber = !_usePhoneNumber;
//             _emailController.clear();
//             _phoneNumberController.clear();
//           }),
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextField(
//       controller: _passwordController,
//       obscureText: _obscureText,
//       decoration: InputDecoration(
//         labelText: 'Mot de passe',
//         prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//         suffixIcon: IconButton(
//           icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
//           onPressed: () => setState(() => _obscureText = !_obscureText),
//         ),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//         filled: true,
//         fillColor: Colors.white,
//       ),
//     );
//   }
// }




// // lib/screens/signin_screen.dart
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/user_model.dart';
// import '../config.dart';
// import '../services/auth_service.dart';

// enum CountryCode {
//   togo('+228', Colors.green, 'assets/images/togo_flag.png'),
//   france('+33', Colors.blue, 'assets/images/france_flag.png'),
//   usa('+1', Colors.red, 'assets/images/usa_flag.jpeg');

//   final String code;
//   final Color color;
//   final String flagPath;
//   const CountryCode(this.code, this.color, this.flagPath);
// }

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final _emailController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordController = TextEditingController();

//   bool _usePhoneNumber = false;
//   bool _obscureText = true;
//   bool _isLoading = false;
//   CountryCode _selectedCountry = CountryCode.togo;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _phoneNumberController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   bool _validateEmailOrPhone(String value) {
//     if (_usePhoneNumber) {
//       switch (_selectedCountry) {
//         case CountryCode.togo:
//           return RegExp(r'^[9][0-1][0-9]{6}$').hasMatch(value) && value.length == 8;
//         case CountryCode.france:
//           return RegExp(r'^[6-7][0-9]{8}$').hasMatch(value) && value.length == 9;
//         case CountryCode.usa:
//           return RegExp(r'^[2-9][0-9]{9}$').hasMatch(value) && value.length == 10;
//       }
//     }
//     return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
//   }

//   bool _validatePassword(String password) {
//     return password.length >= 6;
//   }

//   Future<void> _handleSignIn() async {
//     final emailOrPhone = _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     if (emailOrPhone.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Veuillez remplir tous les champs')),
//       );
//       return;
//     }

//     if (!_validateEmailOrPhone(emailOrPhone)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(_usePhoneNumber
//               ? 'Numéro invalide (${_selectedCountry == CountryCode.togo ? "8 chiffres" : _selectedCountry == CountryCode.france ? "9 chiffres" : "10 chiffres"})'
//               : 'Email invalide (ex: nom@domaine.com)'),
//         ),
//       );
//       return;
//     }

//     if (!_validatePassword(password)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Le mot de passe doit contenir au moins 6 caractères')),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final requestBody = {
//         'emailOrPhone': _usePhoneNumber ? _selectedCountry.code + emailOrPhone : emailOrPhone,
//         'password': password,
//       };

//       print('Login Request Body: ${jsonEncode(requestBody)}');

//       final response = await http.post(
//         Uri.parse('${Config.authUrl}/login'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(requestBody),
//       );

//       print('Login Response Status: ${response.statusCode}');
//       print('Login Response Body: ${response.body}');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         final user = UserModel.fromMap(data['user']);
//         final token = data['access_token'];

//         await AuthService.saveToken(token);
//         await AuthService.saveUser(user);

//         if (mounted) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             '/redirect',
//             (route) => false,
//             arguments: user,
//           );
//           print('Navigation réussie');
//         }
//       } else {
//         throw Exception('Échec de la connexion: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e) {
//       print('Erreur capturée: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur inattendue: $e')),
//         );
//       }
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('assets/images/login.png', height: 200),
//               const SizedBox(height: 30),
//               const Text(
//                 'Content de te revoir !',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
//               ),
//               const SizedBox(height: 40),
//               _buildEmailOrPhoneField(),
//               const SizedBox(height: 20),
//               _buildPasswordField(),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _handleSignIn,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 7, 56, 9),
//                   padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                 ),
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text('Se connecter', style: TextStyle(color: Colors.white, fontSize: 18)),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Pas de compte ? ', style: TextStyle(fontSize: 16, color: Colors.grey)),
//                   TextButton(
//                     onPressed: () => Navigator.pushNamed(context, '/signup'),
//                     child: const Text('Inscrivez-vous', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmailOrPhoneField() {
//     return Row(
//       children: [
//         if (_usePhoneNumber) ...[
//           DropdownButton<CountryCode>(
//             value: _selectedCountry,
//             items: CountryCode.values
//                 .map((country) => DropdownMenuItem(
//                       value: country,
//                       child: Row(
//                         children: [
//                           Image.asset(country.flagPath, width: 24, height: 24),
//                           const SizedBox(width: 8),
//                           Text(country.code, style: TextStyle(color: country.color)),
//                         ],
//                       ),
//                     ))
//                 .toList(),
//             onChanged: (value) => setState(() {
//               _selectedCountry = value!;
//               _phoneNumberController.clear();
//             }),
//             underline: const SizedBox(),
//           ),
//           const SizedBox(width: 8),
//           SizedBox(
//             width: 60,
//             child: TextField(
//               controller: TextEditingController(text: _selectedCountry.code),
//               readOnly: true,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//         ],
//         Expanded(
//           child: TextField(
//             controller: _usePhoneNumber ? _phoneNumberController : _emailController,
//             keyboardType: _usePhoneNumber ? TextInputType.phone : TextInputType.emailAddress,
//             decoration: InputDecoration(
//               labelText: _usePhoneNumber
//                   ? 'Numéro (ex: ${_selectedCountry == CountryCode.togo ? "90123456" : _selectedCountry == CountryCode.france ? "612345678" : "2025550123"})'
//                   : 'Email (ex: nom@domaine.com)',
//               prefixIcon: Icon(_usePhoneNumber ? Icons.phone : Icons.email, color: Colors.grey),
//               border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//               filled: true,
//               fillColor: Colors.white,
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         IconButton(
//           icon: Icon(_usePhoneNumber ? Icons.email : Icons.phone, color: _usePhoneNumber ? Colors.grey : _selectedCountry.color),
//           onPressed: () => setState(() {
//             _usePhoneNumber = !_usePhoneNumber;
//             _emailController.clear();
//             _phoneNumberController.clear();
//           }),
//         ),
//       ],
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextField(
//       controller: _passwordController,
//       obscureText: _obscureText,
//       decoration: InputDecoration(
//         labelText: 'Mot de passe',
//         prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//         suffixIcon: IconButton(
//           icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
//           onPressed: () => setState(() => _obscureText = !_obscureText),
//         ),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//         filled: true,
//         fillColor: Colors.white,
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../config.dart';
import '../services/auth_service.dart';

enum CountryCode {
  togo('+228', Colors.green, 'assets/images/togo_flag.png'),
  france('+33', Colors.blue, 'assets/images/france_flag.png'),
  usa('+1', Colors.red, 'assets/images/usa_flag.jpeg');

  final String code;
  final Color color;
  final String flagPath;
  const CountryCode(this.code, this.color, this.flagPath);
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _usePhoneNumber = false;
  bool _obscureText = true;
  bool _isLoading = false;
  CountryCode _selectedCountry = CountryCode.togo;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateEmailOrPhone(String value) {
    if (_usePhoneNumber) {
      switch (_selectedCountry) {
        case CountryCode.togo:
          return RegExp(r'^[9][0-1][0-9]{6}$').hasMatch(value) && value.length == 8;
        case CountryCode.france:
          return RegExp(r'^[6-7][0-9]{8}$').hasMatch(value) && value.length == 9;
        case CountryCode.usa:
          return RegExp(r'^[2-9][0-9]{9}$').hasMatch(value) && value.length == 10;
      }
    }
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  Future<void> _handleSignIn() async {
    final emailOrPhone = _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (emailOrPhone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    if (!_validateEmailOrPhone(emailOrPhone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_usePhoneNumber
              ? 'Numéro invalide (${_selectedCountry == CountryCode.togo ? "8 chiffres" : _selectedCountry == CountryCode.france ? "9 chiffres" : "10 chiffres"})'
              : 'Email invalide (ex: nom@domaine.com)'),
        ),
      );
      return;
    }

    if (!_validatePassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le mot de passe doit contenir au moins 6 caractères')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final requestBody = {
        'emailOrPhone': _usePhoneNumber ? _selectedCountry.code + emailOrPhone : emailOrPhone,
        'password': password,
      };

      print('Login Request Body: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse('${Config.authUrl}/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      ).timeout(Config.timeoutDuration);

      print('Login Response Status: ${response.statusCode}');
      print('Login Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = UserModel.fromMap(data['user']);
        final token = data['access_token'];

        await AuthService.saveUserAndToken(user, token);

        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/redirect',
            (route) => false,
            arguments: user,
          );
          print('Navigation réussie');
        }
      } else {
        throw Exception('Échec de la connexion: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Erreur capturée: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur inattendue: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/login.png', height: 200),
              const SizedBox(height: 30),
              const Text(
                'Content de te revoir !',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 40),
              _buildEmailOrPhoneField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSignIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 7, 56, 9),
                  padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Se connecter', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Pas de compte ? ', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    child: const Text('Inscrivez-vous', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailOrPhoneField() {
    return Row(
      children: [
        if (_usePhoneNumber) ...[
          DropdownButton<CountryCode>(
            value: _selectedCountry,
            items: CountryCode.values
                .map((country) => DropdownMenuItem(
                      value: country,
                      child: Row(
                        children: [
                          Image.asset(country.flagPath, width: 24, height: 24),
                          const SizedBox(width: 8),
                          Text(country.code, style: TextStyle(color: country.color)),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: (value) => setState(() {
              _selectedCountry = value!;
              _phoneNumberController.clear();
            }),
            underline: const SizedBox(),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            child: TextField(
              controller: TextEditingController(text: _selectedCountry.code),
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: TextField(
            controller: _usePhoneNumber ? _phoneNumberController : _emailController,
            keyboardType: _usePhoneNumber ? TextInputType.phone : TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: _usePhoneNumber
                  ? 'Numéro (ex: ${_selectedCountry == CountryCode.togo ? "90123456" : _selectedCountry == CountryCode.france ? "612345678" : "2025550123"})'
                  : 'Email (ex: nom@domaine.com)',
              prefixIcon: Icon(_usePhoneNumber ? Icons.phone : Icons.email, color: Colors.grey),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: Icon(_usePhoneNumber ? Icons.email : Icons.phone, color: _usePhoneNumber ? Colors.grey : _selectedCountry.color),
          onPressed: () => setState(() {
            _usePhoneNumber = !_usePhoneNumber;
            _emailController.clear();
            _phoneNumberController.clear();
          }),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Mot de passe',
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}