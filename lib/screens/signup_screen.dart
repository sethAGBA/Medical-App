// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:medical/constants/app_colors.dart';
// import 'dart:io'; // Pour utiliser File
// import 'home_screen.dart';
// import 'package:permission_handler/permission_handler.dart';

// enum CountryCode {
//   togo('+228', Colors.green, 'assets/images/togo_flag.png'),
//   france('+33', Colors.blue, 'assets/images/france_flag.png'),
//   usa('+1', Colors.red, 'assets/images/usa_flag.jpeg');

//   final String code;
//   final Color color;
//   final String flagPath;
//   const CountryCode(this.code, this.color, this.flagPath);
// }

// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _dobController = TextEditingController();
//   String _selectedGender = 'Homme';
//   bool _obscureText = true;
//   bool _obscureConfirmText = true;
//   bool _isLoading = false;
//   bool _usePhoneNumber = false;
//   File? _image;
//   CountryCode _selectedCountry = CountryCode.togo;

//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2000),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _dobController.text =
//             "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
//       });
//     }
//   }

//   Future<void> _pickImage() async {
//     final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   bool _validateEmailOrPhone(String value) {
//     if (_usePhoneNumber) {
//       final fullNumber = _selectedCountry.code + value;
//       print('Validating phone number: $fullNumber'); // Débogage

//       switch (_selectedCountry) {
//         case CountryCode.togo:
//           final phoneRegex = RegExp(r'^\+228[9][0-1][0-9]{6}$');
//           return phoneRegex.hasMatch(fullNumber) && value.length == 8;
//         case CountryCode.france:
//           final phoneRegex = RegExp(r'^\+33[6-7][0-9]{8}$');
//           return phoneRegex.hasMatch(fullNumber) && value.length == 9;
//         case CountryCode.usa:
//           final phoneRegex = RegExp(r'^\+1[2-9][0-9]{9}$');
//           return phoneRegex.hasMatch(fullNumber) && value.length == 10;
//       }
//     } else {
//       final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//       return emailRegex.hasMatch(value);
//     }
//     return false;
//   }

//   bool _validatePassword(String password) {
//     return password.length >= 6;
//   }

//   bool _validateConfirmPassword(String password, String confirmPassword) {
//     return password == confirmPassword && password.length >= 6;
//   }

//   void _handleSignUp(BuildContext context) async {
//     final emailOrPhone = _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
//     final password = _passwordController.text.trim();
//     final confirmPassword = _confirmPasswordController.text.trim();

//     if (_usernameController.text.isEmpty ||
//         emailOrPhone.isEmpty ||
//         password.isEmpty ||
//         confirmPassword.isEmpty ||
//         _dobController.text.isEmpty ||
//         _image == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Veuillez remplir tous les champs')),
//       );
//       return;
//     }

//     if (!_validateEmailOrPhone(emailOrPhone)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(_usePhoneNumber
//               ? 'Veuillez entrer un numéro valide (${_selectedCountry == CountryCode.togo ? "8 chiffres" : _selectedCountry == CountryCode.france ? "9 chiffres" : "10 chiffres"} après ${_selectedCountry.code})'
//               : 'Veuillez entrer un email valide (ex: nom@domaine.com)'),
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

//     if (!_validateConfirmPassword(password, confirmPassword)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Les mots de passe ne correspondent pas ou sont trop courts (min. 6 caractères)')),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       await Future.delayed(const Duration(seconds: 2));
//       if (!mounted) return;
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//         (Route<dynamic> route) => false,
//       );
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur lors de l\'inscription: $e')),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Center(
//                 child: Image.asset(
//                   'assets/images/register.png',
//                   height: 200,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               const Text(
//                 'Rejoignez Nous!',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildTextField('Entrez votre nom', _usernameController, icon: Icons.person),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildPhoneOrEmailField(),
//                   ),
//                   const SizedBox(width: 10),
//                   IconButton(
//                     icon: Icon(
//                       _usePhoneNumber ? Icons.email : Icons.phone,
//                       color: _usePhoneNumber ? Colors.grey : _selectedCountry.color,
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         _usePhoneNumber = !_usePhoneNumber;
//                         _emailController.clear();
//                         _phoneNumberController.clear();
//                       });
//                     },
//                     tooltip: _usePhoneNumber
//                         ? 'Utiliser un email'
//                         : 'Utiliser un numéro de téléphone',
//                   ),
//                 ],
//               ),
//               _buildPasswordField('Entrez votre mot de passe', _passwordController, _obscureText, () {
//                 setState(() => _obscureText = !_obscureText);
//               }),
//               _buildPasswordField('Confirmez votre mot de passe', _confirmPasswordController, _obscureConfirmText, () {
//                 setState(() => _obscureConfirmText = !_obscureConfirmText);
//               }),
//               _buildDateField('Entrez votre date de naissance', _dobController, context),
//               _buildGenderDropdown(),
//               ElevatedButton(
//                 onPressed: _pickImage,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                     side: const BorderSide(color: Colors.white, width: 1.0),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//                 ),
//                 child: const Text(
//                   'Cliquez pour sélectionner une photo de profil',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               if (_image != null)
//                 Center(
//                   child: Image.file(
//                     _image!,
//                     height: 100,
//                     width: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : () => _handleSignUp(context),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 7, 56, 9),
//                   padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
//                   textStyle: const TextStyle(fontSize: 18),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                 ),
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.person_add, color: Colors.white),
//                           SizedBox(width: 10),
//                           Text("Inscription", style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Vous avez déjà un compte ?",
//                     style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushReplacementNamed(context, '/signin');
//                     },
//                     child: const Text(
//                       'Connexion',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String hintText, TextEditingController controller, {IconData? icon}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextField(
//         controller: controller,
//         keyboardType: TextInputType.text,
//         decoration: InputDecoration(
//           labelText: hintText,
//           prefixIcon: Icon(icon, color: Colors.grey),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPhoneOrEmailField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: _usePhoneNumber
//           ? Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 DropdownButton<CountryCode>(
//                   value: _selectedCountry,
//                   items: CountryCode.values
//                       .map((country) => DropdownMenuItem(
//                             value: country,
//                             child: Row(
//                               children: [
//                                 Image.asset(
//                                   country.flagPath,
//                                   width: 24,
//                                   height: 24,
//                                 ),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   country.code,
//                                   style: TextStyle(color: country.color),
//                                 ),
//                               ],
//                             ),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedCountry = value!;
//                       _phoneNumberController.clear();
//                     });
//                   },
//                   underline: const SizedBox(),
//                 ),
//                 const SizedBox(width: 8),
//                 Container(
//                   width: 60,
//                   child: TextField(
//                     controller: TextEditingController(text: _selectedCountry.code),
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     controller: _phoneNumberController,
//                     keyboardType: TextInputType.phone,
//                     decoration: InputDecoration(
//                       labelText: 'Numéro (ex: ${_selectedCountry == CountryCode.togo ? "90123456" : _selectedCountry == CountryCode.france ? "612345678" : "2025550123"})',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : TextField(
//               controller: _emailController,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 labelText: 'Entrez votre email (ex: nom@domaine.com)',
//                 prefixIcon: const Icon(Icons.email, color: Colors.grey),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget _buildPasswordField(String hintText, TextEditingController controller, bool obscureText, VoidCallback toggleVisibility) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           labelText: hintText,
//           prefixIcon: const Icon(Icons.lock),
//           suffixIcon: IconButton(
//             icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
//             onPressed: toggleVisibility,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDateField(String hintText, TextEditingController controller, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: TextField(
//         controller: controller,
//         readOnly: true,
//         decoration: InputDecoration(
//           labelText: hintText,
//           prefixIcon: const Icon(Icons.calendar_today),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//         onTap: () => _selectDate(context),
//       ),
//     );
//   }

//   Widget _buildGenderDropdown() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: DropdownButtonFormField<String>(
//         value: _selectedGender,
//         items: ['Homme', 'Femme', 'Autre']
//             .map((gender) => DropdownMenuItem(
//                   value: gender,
//                   child: Text(gender),
//                 ))
//             .toList(),
//         onChanged: (value) {
//           setState(() {
//             _selectedGender = value!;
//           });
//         },
//         decoration: InputDecoration(
//           labelText: 'Sélectionnez votre genre',
//           prefixIcon: const Icon(Icons.person),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _emailController.dispose();
//     _phoneNumberController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _dobController.dispose();
//     super.dispose();
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:io';
// import 'package:medical/constants/app_colors.dart';
// import 'package:medical/screens/home_screen.dart';
// import 'package:medical/models/user_model.dart';

// enum CountryCode {
//   togo('+228', Colors.green, 'assets/images/togo_flag.png'),
//   france('+33', Colors.blue, 'assets/images/france_flag.png'),
//   usa('+1', Colors.red, 'assets/images/usa_flag.jpeg');

//   final String code;
//   final Color color;
//   final String flagPath;
//   const CountryCode(this.code, this.color, this.flagPath);
// }

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//   final _dobController = TextEditingController();

//   String _selectedGender = 'Homme';
//   bool _obscureText = true;
//   bool _obscureConfirmText = true;
//   bool _isLoading = false;
//   bool _usePhoneNumber = false;
//   File? _image;
//   CountryCode _selectedCountry = CountryCode.togo;

//   final ImagePicker _picker = ImagePicker();

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _emailController.dispose();
//     _phoneNumberController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     _dobController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDate() async {
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime(2000),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (pickedDate != null) {
//       setState(() {
//         _dobController.text =
//             "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
//       });
//     }
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() => _image = File(pickedFile.path));
//     }
//   }

//   bool _validateEmailOrPhone(String value) {
//     if (_usePhoneNumber) {
//       final fullNumber = _selectedCountry.code + value;
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

//   bool _validatePassword(String password, String confirmPassword) {
//     return password.length >= 6 && password == confirmPassword;
//   }

//   // Future<void> _handleSignUp() async {
//   //   final username = _usernameController.text.trim();
//   //   final emailOrPhone =
//   //       _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
//   //   final password = _passwordController.text.trim();
//   //   final confirmPassword = _confirmPasswordController.text.trim();
//   //   final dob = _dobController.text.trim();

//   //   if (username.isEmpty || emailOrPhone.isEmpty || password.isEmpty || dob.isEmpty || _image == null) {
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

//   //   if (!_validatePassword(password, confirmPassword)) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Mot de passe invalide (min. 6 caractères) ou non correspondant')),
//   //     );
//   //     return;
//   //   }

//   //   setState(() => _isLoading = true);

//   //   try {
//   //     // Préparer les données pour l'API
//   //     final Map<String, dynamic> body = {
//   //       'username': username,
//   //       'password': password,
//   //       'dob': dob,
//   //       'gender': _selectedGender,
//   //       if (_usePhoneNumber) 'phoneNumber': _selectedCountry.code + emailOrPhone,
//   //       if (!_usePhoneNumber) 'email': emailOrPhone,
//   //     };

//   //     // Simuler l'upload de l'image (à remplacer par une vraie logique d'upload si nécessaire)
//   //     final response = await http.post(
//   //       Uri.parse('http://localhost:3000/auth/signup'), // URL de votre backend NestJS
//   //       headers: {'Content-Type': 'application/json'},
//   //       body: jsonEncode(body),
//   //     );

//   //     if (response.statusCode == 201) {
//   //       final data = jsonDecode(response.body);
//   //       print('Utilisateur créé: ${data['username']}');
//   //       if (mounted) {
//   //         Navigator.pushAndRemoveUntil(
//   //           context,
//   //           MaterialPageRoute(builder: (_) => const HomeScreen()),
//   //           (Route<dynamic> route) => false,
//   //         );
//   //       }
//   //     } else {
//   //       throw Exception('Erreur ${response.statusCode}: ${response.body}');
//   //     }
//   //   } catch (e) {
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Erreur lors de l\'inscription: $e')),
//   //       );
//   //     }
//   //   } finally {
//   //     if (mounted) setState(() => _isLoading = false);
//   //   }
//   // }
// Future<void> _handleSignUp() async {
//   final emailOrPhone = _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
//   final password = _passwordController.text.trim();
//   final dob = _dobController.text.trim();

//   try {
//     final response = await http.post(
//       Uri.parse('http://localhost:3000/auth/register'), // Updated endpoint
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'fullName': _usernameController.text.trim(),
//         'email': _usePhoneNumber ? null : emailOrPhone,
//         'phoneNumber': _usePhoneNumber ? _selectedCountry.code + emailOrPhone : null,
//         'password': password,
//         'dateOfBirth': dob, // Ensure format matches backend (e.g., "2023-01-01")
//         'gender': _selectedGender.toLowerCase(), // Match enum: 'male', 'female', 'other'
//         'profilePhoto': _image != null ? 'uploaded_image_url' : null, // Handle separately
//         'role': 'user', // Hardcoded for now; adjust as needed
//       }),
//     );

//     if (response.statusCode == 201) {
//       final data = jsonDecode(response.body);
//       final user = UserModel.fromMap(data['user']);
//       final token = data['access_token'];
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('access_token', token);

//       if (mounted) {
//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           '/redirect',
//           (route) => false,
//           arguments: user,
//         );
//       }
//     } else {
//       throw Exception('Erreur ${response.statusCode}: ${response.body}');
//     }
//   } catch (e) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
//     }
//   } finally {
//     if (mounted) setState(() => _isLoading = false);
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Image.asset('assets/images/register.png', height: 200, fit: BoxFit.contain),
//             ),
//             const SizedBox(height: 30),
//             const Text(
//               'Rejoignez-nous !',
//               style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
//             ),
//             const SizedBox(height: 20),
//             _buildTextField('Nom', _usernameController, Icons.person),
//             _buildEmailOrPhoneField(),
//             _buildPasswordField('Mot de passe', _passwordController, _obscureText, () {
//               setState(() => _obscureText = !_obscureText);
//             }),
//             _buildPasswordField('Confirmer le mot de passe', _confirmPasswordController, _obscureConfirmText, () {
//               setState(() => _obscureConfirmText = !_obscureConfirmText);
//             }),
//             _buildDateField(),
//             _buildGenderDropdown(),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               child: const Text('Sélectionner une photo', style: TextStyle(color: Colors.white, fontSize: 16)),
//             ),
//             if (_image != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Center(child: Image.file(_image!, height: 100, width: 100, fit: BoxFit.cover)),
//               ),
//             const SizedBox(height: 30),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _handleSignUp,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 7, 56, 9),
//                 padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//               ),
//               child: _isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.person_add, color: Colors.white),
//                         SizedBox(width: 10),
//                         Text('Inscription', style: TextStyle(color: Colors.white, fontSize: 18)),
//                       ],
//                     ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Déjà un compte ? ', style: TextStyle(fontSize: 16, color: Colors.grey)),
//                 TextButton(
//                   onPressed: () => Navigator.pushNamed(context, '/signin'),
//                   child: const Text('Connexion', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon, color: Colors.grey),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmailOrPhoneField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           if (_usePhoneNumber) ...[
//             DropdownButton<CountryCode>(
//               value: _selectedCountry,
//               items: CountryCode.values
//                   .map((country) => DropdownMenuItem(
//                         value: country,
//                         child: Row(
//                           children: [
//                             Image.asset(country.flagPath, width: 24, height: 24),
//                             const SizedBox(width: 8),
//                             Text(country.code, style: TextStyle(color: country.color)),
//                           ],
//                         ),
//                       ))
//                   .toList(),
//               onChanged: (value) => setState(() {
//                 _selectedCountry = value!;
//                 _phoneNumberController.clear();
//               }),
//               underline: const SizedBox(),
//             ),
//             const SizedBox(width: 8),
//             SizedBox(
//               width: 60,
//               child: TextField(
//                 controller: TextEditingController(text: _selectedCountry.code),
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                   contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//           ],
//           Expanded(
//             child: TextField(
//               controller: _usePhoneNumber ? _phoneNumberController : _emailController,
//               keyboardType: _usePhoneNumber ? TextInputType.phone : TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 labelText: _usePhoneNumber
//                     ? 'Numéro (ex: ${_selectedCountry == CountryCode.togo ? "90123456" : _selectedCountry == CountryCode.france ? "612345678" : "2025550123"})'
//                     : 'Email (ex: nom@domaine.com)',
//                 prefixIcon: Icon(_usePhoneNumber ? Icons.phone : Icons.email, color: Colors.grey),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//             ),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             icon: Icon(_usePhoneNumber ? Icons.email : Icons.phone, color: _usePhoneNumber ? Colors.grey : _selectedCountry.color),
//             onPressed: () => setState(() {
//               _usePhoneNumber = !_usePhoneNumber;
//               _emailController.clear();
//               _phoneNumberController.clear();
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPasswordField(String label, TextEditingController controller, bool obscure, VoidCallback toggle) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextField(
//         controller: controller,
//         obscureText: obscure,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//           suffixIcon: IconButton(
//             icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
//             onPressed: toggle,
//           ),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       ),
//     );
//   }

//   Widget _buildDateField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: TextField(
//         controller: _dobController,
//         readOnly: true,
//         onTap: _selectDate,
//         decoration: InputDecoration(
//           labelText: 'Date de naissance',
//           prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       ),
//     );
//   }

//   Widget _buildGenderDropdown() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: DropdownButtonFormField<String>(
//         value: _selectedGender,
//         items: ['Homme', 'Femme', 'Autre']
//             .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
//             .toList(),
//         onChanged: (value) => setState(() => _selectedGender = value!),
//         decoration: InputDecoration(
//           labelText: 'Genre',
//           prefixIcon: const Icon(Icons.person, color: Colors.grey),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/user_model.dart';

// enum CountryCode {
//   togo('+228', Colors.green, 'assets/images/togo_flag.png'),
//   france('+33', Colors.blue, 'assets/images/france_flag.png'),
//   usa('+1', Colors.red, 'assets/images/usa_flag.jpeg');

//   final String code;
//   final Color color;
//   final String flagPath;
//   const CountryCode(this.code, this.color, this.flagPath);
// }

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _fullNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _dobController = TextEditingController();

//   bool _usePhoneNumber = false;
//   bool _obscureText = true;
//   bool _isLoading = false;
//   String _selectedGender = 'male';
//   CountryCode _selectedCountry = CountryCode.togo;

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _emailController.dispose();
//     _phoneNumberController.dispose();
//     _passwordController.dispose();
//     _dobController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleSignUp() async {
//     final fullName = _fullNameController.text.trim();
//     final emailOrPhone =
//         _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
//     final password = _passwordController.text.trim();
//     final dob = _dobController.text.trim();

//     if (fullName.isEmpty || emailOrPhone.isEmpty || password.isEmpty || dob.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Veuillez remplir tous les champs')),
//       );
//       return;
//     }

//     if (!_usePhoneNumber &&
//         !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailOrPhone)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Email invalide (ex: nom@domaine.com)')),
//       );
//       return;
//     }

//     if (_usePhoneNumber) {
//       if (_selectedCountry == CountryCode.togo &&
//           !RegExp(r'^[9][0-1][0-9]{6}$').hasMatch(emailOrPhone)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Numéro invalide (ex: 90123456)')),
//         );
//         return;
//       }
//       // Add similar validation for France and USA if needed
//     }

//     if (password.length < 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Mot de passe trop court (min. 6 caractères)')),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:3000/auth/register'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           'fullName': fullName,
//           'email': _usePhoneNumber ? null : emailOrPhone,
//           'phoneNumber': _usePhoneNumber ? _selectedCountry.code + emailOrPhone : null,
//           'password': password,
//           'dateOfBirth': dob.split('/').reversed.join('-'), // Convert "DD/MM/YYYY" to "YYYY-MM-DD"
//           'gender': _selectedGender,
//           'profilePhoto': null, // Handle image upload separately
//           'role': 'user',
//         }),
//       );

//       if (response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         final user = UserModel.fromMap(data['user']);
//         final token = data['access_token'];

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('access_token', token);

//         if (mounted) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             '/redirect',
//             (route) => false,
//             arguments: user,
//           );
//         }
//       } else {
//         throw Exception('Erreur ${response.statusCode}: ${response.body}');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur: $e')),
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
//               Image.asset('assets/images/register.png', height: 200),
//               const SizedBox(height: 30),
//               const Text(
//                 'Créer un compte',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _fullNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Nom complet',
//                   prefixIcon: const Icon(Icons.person, color: Colors.grey),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildEmailOrPhoneField(),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: _obscureText,
//                 decoration: InputDecoration(
//                   labelText: 'Mot de passe',
//                   prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                   suffixIcon: IconButton(
//                     icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
//                     onPressed: () => setState(() => _obscureText = !_obscureText),
//                   ),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _dobController,
//                 decoration: InputDecoration(
//                   labelText: 'Date de naissance (JJ/MM/AAAA)',
//                   prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 onTap: () async {
//                   final date = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(1900),
//                     lastDate: DateTime.now(),
//                   );
//                   if (date != null) {
//                     _dobController.text = '${date.day}/${date.month}/${date.year}';
//                   }
//                 },
//               ),
//               const SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 items: ['male', 'female', 'other']
//                     .map((gender) => DropdownMenuItem(
//                           value: gender,
//                           child: Text(gender == 'male'
//                               ? 'Homme'
//                               : gender == 'female'
//                                   ? 'Femme'
//                                   : 'Autre'),
//                         ))
//                     .toList(),
//                 onChanged: (value) => setState(() => _selectedGender = value!),
//                 decoration: InputDecoration(
//                   labelText: 'Sexe',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _handleSignUp,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 7, 56, 9),
//                   padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                 ),
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text('S\'inscrire', style: TextStyle(color: Colors.white, fontSize: 18)),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center, // Fixed typo here
//                 children: [
//                   const Text('Déjà un compte ? ', style: TextStyle(fontSize: 16, color: Colors.grey)),
//                   TextButton(
//                     onPressed: () => Navigator.pushNamed(context, '/signin'),
//                     child: const Text('Connectez-vous', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
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
// }




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

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _fullNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _dobController = TextEditingController();

//   bool _usePhoneNumber = false;
//   bool _obscureText = true;
//   bool _isLoading = false;
//   String _selectedGender = 'male';
//   CountryCode _selectedCountry = CountryCode.togo;

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _emailController.dispose();
//     _phoneNumberController.dispose();
//     _passwordController.dispose();
//     _dobController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleSignUp() async {
//     final fullName = _fullNameController.text.trim();
//     final emailOrPhone =
//         _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
//     final password = _passwordController.text.trim();
//     final dob = _dobController.text.trim();

//     if (fullName.isEmpty || emailOrPhone.isEmpty || password.isEmpty || dob.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Veuillez remplir tous les champs')),
//       );
//       return;
//     }

//     if (!_usePhoneNumber &&
//         !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailOrPhone)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Email invalide (ex: nom@domaine.com)')),
//       );
//       return;
//     }

//     if (_usePhoneNumber) {
//       if (_selectedCountry == CountryCode.togo &&
//           !RegExp(r'^[9][0-1][0-9]{6}$').hasMatch(emailOrPhone)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Numéro invalide (ex: 90123456)')),
//         );
//         return;
//       }
//     }

//     if (password.length < 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Mot de passe trop court (min. 6 caractères)')),
//       );
//       return;
//     }

//     // Validate and format dateOfBirth
//     String formattedDob;
//     try {
//       final parts = dob.split('/');
//       if (parts.length != 3) throw FormatException('Format attendu: JJ/MM/AAAA');
//       final day = int.parse(parts[0]);
//       final month = int.parse(parts[1]);
//       final year = int.parse(parts[2]);
//       formattedDob = DateTime(year, month, day).toIso8601String(); // Full ISO 8601
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Date de naissance invalide (ex: 21/03/1990)')),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final requestBody = {
//         'fullName': fullName,
//         'email': _usePhoneNumber ? null : emailOrPhone,
//         'phoneNumber': _usePhoneNumber ? _selectedCountry.code + emailOrPhone : null,
//         'password': password,
//         'dateOfBirth': formattedDob, // e.g., "1990-03-21T00:00:00.000Z"
//         'gender': _selectedGender,
//         'profilePhoto': null,
//         'role': 'user',
//       };

//       // Log the request body
//       print('Request Body: ${jsonEncode(requestBody)}');

//       final response = await http.post(
//         Uri.parse('${Config.baseUrl}/auth/register'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(requestBody),
//       );

//       print('Response Status: ${response.statusCode}');
//       print('Response Body: ${response.body}');

//       if (response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         final user = UserModel.fromMap(data['user']);
//         final token = data['access_token'];

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('access_token', token);

//         if (mounted) {
//           Navigator.pushNamedAndRemoveUntil(
//             context,
//             '/redirect',
//             (route) => false,
//             arguments: user,
//           );
//         }
//       } else {
//         throw Exception('Échec de l\'inscription: ${response.statusCode} - ${response.body}');
//       }
//     } on FormatException catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur de format de réponse: $e')),
//         );
//       }
//     } on http.ClientException catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur réseau: $e')),
//         );
//       }
//     } catch (e) {
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
//               Image.asset('assets/images/register.png', height: 200),
//               const SizedBox(height: 30),
//               const Text(
//                 'Créer un compte',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _fullNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Nom complet',
//                   prefixIcon: const Icon(Icons.person, color: Colors.grey),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildEmailOrPhoneField(),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: _obscureText,
//                 decoration: InputDecoration(
//                   labelText: 'Mot de passe',
//                   prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                   suffixIcon: IconButton(
//                     icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
//                     onPressed: () => setState(() => _obscureText = !_obscureText),
//                   ),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _dobController,
//                 decoration: InputDecoration(
//                   labelText: 'Date de naissance (JJ/MM/AAAA)',
//                   prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 onTap: () async {
//                   final date = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(1900),
//                     lastDate: DateTime.now(),
//                   );
//                   if (date != null) {
//                     _dobController.text = '${date.day}/${date.month}/${date.year}';
//                   }
//                 },
//               ),
//               const SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 items: ['male', 'female', 'other']
//                     .map((gender) => DropdownMenuItem(
//                           value: gender,
//                           child: Text(gender == 'male'
//                               ? 'Homme'
//                               : gender == 'female'
//                                   ? 'Femme'
//                                   : 'Autre'),
//                         ))
//                     .toList(),
//                 onChanged: (value) => setState(() => _selectedGender = value!),
//                 decoration: InputDecoration(
//                   labelText: 'Sexe',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _handleSignUp,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 7, 56, 9),
//                   padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                 ),
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text('S\'inscrire', style: TextStyle(color: Colors.white, fontSize: 18)),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Déjà un compte ? ', style: TextStyle(fontSize: 16, color: Colors.grey)),
//                   TextButton(
//                     onPressed: () => Navigator.pushNamed(context, '/signin'),
//                     child: const Text('Connectez-vous', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
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
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../config.dart';

enum CountryCode {
  togo('+228', Colors.green, 'assets/images/togo_flag.png'),
  france('+33', Colors.blue, 'assets/images/france_flag.png'),
  usa('+1', Colors.red, 'assets/images/usa_flag.jpeg');

  final String code;
  final Color color;
  final String flagPath;
  const CountryCode(this.code, this.color, this.flagPath);
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dobController = TextEditingController();

  bool _usePhoneNumber = false;
  bool _obscureText = true;
  bool _isLoading = false;
  String _selectedGender = 'male';
  CountryCode _selectedCountry = CountryCode.togo;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final fullName = _fullNameController.text.trim();
    final emailOrPhone =
        _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
    final password = _passwordController.text.trim();
    final dob = _dobController.text.trim();

    if (fullName.isEmpty || emailOrPhone.isEmpty || password.isEmpty || dob.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    if (!_usePhoneNumber &&
        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailOrPhone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email invalide (ex: nom@domaine.com)')),
      );
      return;
    }

    if (_usePhoneNumber) {
      if (_selectedCountry == CountryCode.togo &&
          !RegExp(r'^[9][0-1][0-9]{6}$').hasMatch(emailOrPhone)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Numéro invalide (ex: 90123456)')),
        );
        return;
      }
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mot de passe trop court (min. 6 caractères)')),
      );
      return;
    }

    // Validate and format dateOfBirth
    String formattedDob;
    try {
      final parts = dob.split('/');
      if (parts.length != 3) throw FormatException('Format attendu: JJ/MM/AAAA');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      formattedDob = DateTime(year, month, day).toIso8601String(); // Full ISO 8601
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Date de naissance invalide (ex: 21/03/1990)')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final requestBody = {
        'fullName': fullName,
        'email': _usePhoneNumber ? null : emailOrPhone,
        'phoneNumber': _usePhoneNumber ? _selectedCountry.code + emailOrPhone : null,
        'password': password,
        'dateOfBirth': formattedDob, // e.g., "1990-03-21T00:00:00.000Z"
        'gender': _selectedGender,
        'profilePhoto': null,
        'role': 'user',
      };

      print('Request URL: ${Config.authUrl}/register');
      print('Request Body: ${jsonEncode(requestBody)}');

      final response = await http.post(
        Uri.parse('${Config.authUrl}/register'), // Utilise Config.authUrl avec /api/v1
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final user = UserModel.fromMap(data); // Ajustez selon votre réponse API
        final token = data['access_token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', token);
        Config.jwtToken = token; // Stocke le token globalement

        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/redirect',
            (route) => false,
            arguments: user,
          );
        }
      } else {
        throw Exception('Échec de l\'inscription: ${response.statusCode} - ${response.body}');
      }
    } on FormatException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de format de réponse: $e')),
        );
      }
    } on http.ClientException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur réseau: $e')),
        );
      }
    } catch (e) {
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
              Image.asset('assets/images/register.png', height: 200),
              const SizedBox(height: 30),
              const Text(
                'Créer un compte',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Nom complet',
                  prefixIcon: const Icon(Icons.person, color: Colors.grey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildEmailOrPhoneField(),
              const SizedBox(height: 20),
              TextField(
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
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: 'Date de naissance (JJ/MM/AAAA)',
                  prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    _dobController.text = '${date.day}/${date.month}/${date.year}';
                  }
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: ['male', 'female', 'other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender == 'male'
                              ? 'Homme'
                              : gender == 'female'
                                  ? 'Femme'
                                  : 'Autre'),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedGender = value!),
                decoration: InputDecoration(
                  labelText: 'Sexe',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleSignUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 7, 56, 9),
                  padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('S\'inscrire', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Déjà un compte ? ', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signin'),
                    child: const Text('Connectez-vous', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
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
}


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

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _fullNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _dobController = TextEditingController();

//   bool _usePhoneNumber = false;
//   bool _obscureText = true;
//   bool _isLoading = false;
//   String _selectedGender = 'male';
//   String _selectedRole = 'user'; // New field for role selection
//   CountryCode _selectedCountry = CountryCode.togo;

//   @override
//   void dispose() {
//     _fullNameController.dispose();
//     _emailController.dispose();
//     _phoneNumberController.dispose();
//     _passwordController.dispose();
//     _dobController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleSignUp() async {
//     final fullName = _fullNameController.text.trim();
//     final emailOrPhone =
//         _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
//     final password = _passwordController.text.trim();
//     final dob = _dobController.text.trim();

//     if (fullName.isEmpty || emailOrPhone.isEmpty || password.isEmpty || dob.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Veuillez remplir tous les champs')),
//       );
//       return;
//     }

//     if (!_usePhoneNumber &&
//         !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailOrPhone)) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Email invalide (ex: nom@domaine.com)')),
//       );
//       return;
//     }

//     if (_usePhoneNumber) {
//       if (_selectedCountry == CountryCode.togo &&
//           !RegExp(r'^[9][0-1][0-9]{6}$').hasMatch(emailOrPhone)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Numéro invalide (ex: 90123456)')),
//         );
//         return;
//       }
//     }

//     if (password.length < 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Mot de passe trop court (min. 6 caractères)')),
//       );
//       return;
//     }

//     String formattedDob;
//     try {
//       final parts = dob.split('/');
//       if (parts.length != 3) throw FormatException('Format attendu: JJ/MM/AAAA');
//       final day = int.parse(parts[0]);
//       final month = int.parse(parts[1]);
//       final year = int.parse(parts[2]);
//       formattedDob = DateTime(year, month, day).toIso8601String();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Date de naissance invalide (ex: 21/03/1990)')),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       final requestBody = {
//         'fullName': fullName,
//         'email': _usePhoneNumber ? null : emailOrPhone,
//         'phoneNumber': _usePhoneNumber ? _selectedCountry.code + emailOrPhone : null,
//         'password': password,
//         'dateOfBirth': formattedDob,
//         'gender': _selectedGender,
//         'profilePhoto': null,
//         'role': _selectedRole, // Use selected role
//       };

//       print('Signup Request Body: ${jsonEncode(requestBody)}');

//       final response = await http.post(
//         Uri.parse('${Config.baseUrl}/auth/register'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(requestBody),
//       );

//       print('Signup Response Status: ${response.statusCode}');
//       print('Signup Response Body: ${response.body}');

//       if (response.statusCode == 201) {
//         final data = jsonDecode(response.body);
//         final user = UserModel.fromMap(data['user']);
//         final token = data['access_token'];

//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('access_token', token);

//         print('User Model: ${user.toJson()}');
//         print('Attempting navigation to /redirect');

//         Navigator.pushNamedAndRemoveUntil(
//           context,
//           '/redirect',
//           (route) => false,
//           arguments: user,
//         );
//         print('Navigation executed successfully');
//       } else {
//         throw Exception('Échec de l\'inscription: ${response.statusCode} - ${response.body}');
//       }
//     } on FormatException catch (e) {
//       print('FormatException: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur de format de réponse: $e')),
//         );
//       }
//     } on http.ClientException catch (e) {
//       print('ClientException: $e');
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur réseau: $e')),
//         );
//       }
//     } catch (e) {
//       print('Caught exception: $e');
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
//               Image.asset('assets/images/signup.png', height: 200),
//               const SizedBox(height: 30),
//               const Text(
//                 'Créer un compte',
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _fullNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Nom complet',
//                   prefixIcon: const Icon(Icons.person, color: Colors.grey),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildEmailOrPhoneField(),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _passwordController,
//                 obscureText: _obscureText,
//                 decoration: InputDecoration(
//                   labelText: 'Mot de passe',
//                   prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                   suffixIcon: IconButton(
//                     icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
//                     onPressed: () => setState(() => _obscureText = !_obscureText),
//                   ),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _dobController,
//                 readOnly: true,
//                 decoration: InputDecoration(
//                   labelText: 'Date de naissance (JJ/MM/AAAA)',
//                   prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//                 onTap: () async {
//                   final date = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(1900),
//                     lastDate: DateTime.now(),
//                   );
//                   if (date != null) {
//                     _dobController.text = '${date.day}/${date.month}/${date.year}';
//                   }
//                 },
//               ),
//               const SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 items: ['male', 'female', 'other']
//                     .map((gender) => DropdownMenuItem(
//                           value: gender,
//                           child: Text(gender == 'male'
//                               ? 'Homme'
//                               : gender == 'female'
//                                   ? 'Femme'
//                                   : 'Autre'),
//                         ))
//                     .toList(),
//                 onChanged: (value) => setState(() => _selectedGender = value!),
//                 decoration: InputDecoration(
//                   labelText: 'Sexe',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 value: _selectedRole,
//                 items: ['user', 'professional', 'admin']
//                     .map((role) => DropdownMenuItem(
//                           value: role,
//                           child: Text(role == 'user'
//                               ? 'Utilisateur'
//                               : role == 'professional'
//                                   ? 'Professionnel'
//                                   : 'Administrateur'),
//                         ))
//                     .toList(),
//                 onChanged: (value) => setState(() => _selectedRole = value!),
//                 decoration: InputDecoration(
//                   labelText: 'Rôle',
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//                   filled: true,
//                   fillColor: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _handleSignUp,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 7, 56, 9),
//                   padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//                 ),
//                 child: _isLoading
//                     ? const CircularProgressIndicator(color: Colors.white)
//                     : const Text('S\'inscrire', style: TextStyle(color: Colors.white, fontSize: 18)),
//               ),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Déjà un compte ? ', style: TextStyle(fontSize: 16, color: Colors.grey)),
//                   TextButton(
//                     onPressed: () => Navigator.pushNamed(context, '/signin'),
//                     child: const Text('Connectez-vous', style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
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
// }