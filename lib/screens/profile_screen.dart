// // // // // import 'dart:io';
// // // // // import 'dart:typed_data';

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:path_provider/path_provider.dart';
// // // // // import 'package:permission_handler/permission_handler.dart';
// // // // // import 'package:shared_preferences/shared_preferences.dart';
// // // // // import 'package:qr_flutter/qr_flutter.dart';
// // // // // import 'package:widgets_to_image/widgets_to_image.dart';
// // // // // import '../constants/app_colors.dart';

// // // // // class ProfileScreen extends StatefulWidget {
// // // // //   const ProfileScreen({super.key});

// // // // //   @override
// // // // //   State<ProfileScreen> createState() => _ProfileScreenState();
// // // // // }

// // // // // class _ProfileScreenState extends State<ProfileScreen> {
// // // // //   final Map<String, String> _userData = {
// // // // //     'name': 'Nom Prenom',
// // // // //     'birthdate': '15/03/1990',
// // // // //     'email': 'email.example@gmail.com',
// // // // //     'phone': '+228 XX XX XX XX',
// // // // //     'address': 'Quartier X, Ville',
// // // // //     'bloodType': 'Aucun Groupe Sanguin',
// // // // //     'allergies': 'Aucune allergie',
// // // // //     'emergencyContact': 'Aucun contact d\'urgence',
// // // // //   };

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _loadUserData();
// // // // //   }

// // // // //   WidgetsToImageController controller = WidgetsToImageController();
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.grey[50],
// // // // //       appBar: AppBar(
// // // // //         backgroundColor: AppColors.primary,
// // // // //         elevation: 0,
// // // // //         title: const Text(
// // // // //           'Mon Profil',
// // // // //           style: TextStyle(
// // // // //             color: Colors.white,
// // // // //             fontSize: 20,
// // // // //             fontWeight: FontWeight.w500,
// // // // //           ),
// // // // //         ),
// // // // //         centerTitle: false,
// // // // //         actions: [
// // // // //           IconButton(
// // // // //             icon: const Icon(Icons.settings, color: Colors.white),
// // // // //             onPressed: () {
// // // // //               // TODO: Implémenter les paramètres
// // // // //             },
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //       body: SingleChildScrollView(
// // // // //         child: Column(
// // // // //           children: [
// // // // //             _buildProfileHeader(),
// // // // //             Padding(
// // // // //               padding: const EdgeInsets.all(16),
// // // // //               child: Column(
// // // // //                 children: [
// // // // //                   _buildInfoCard(
// // // // //                       Icons.person_outline, 'name', _userData['name']!),
// // // // //                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate',
// // // // //                       _userData['birthdate']!),
// // // // //                   _buildInfoCard(
// // // // //                       Icons.email_outlined, 'email', _userData['email']!),
// // // // //                   _buildInfoCard(
// // // // //                       Icons.phone_outlined, 'phone', _userData['phone']!),
// // // // //                   _buildInfoCard(Icons.location_on_outlined, 'address',
// // // // //                       _userData['address']!),
// // // // //                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType',
// // // // //                       _userData['bloodType']!),
// // // // //                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies',
// // // // //                       _userData['allergies']!),
// // // // //                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact',
// // // // //                       _userData['emergencyContact']!),
// // // // //                   const SizedBox(height: 20),
// // // // //                   ElevatedButton.icon(
// // // // //                     onPressed: () => _generateQRCode(context),
// // // // //                     icon: const Icon(Icons.qr_code, color: Colors.white),
// // // // //                     label: const Text(
// // // // //                       'Générer le code QR',
// // // // //                       style: TextStyle(color: Colors.white),
// // // // //                     ),
// // // // //                     style: ElevatedButton.styleFrom(
// // // // //                       backgroundColor: AppColors.primary,
// // // // //                       padding: const EdgeInsets.symmetric(
// // // // //                           horizontal: 20, vertical: 12),
// // // // //                       shape: RoundedRectangleBorder(
// // // // //                         borderRadius: BorderRadius.circular(10),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Future<void> _saveFile(Uint8List byteData) async {
// // // // //     await Permission.storage.request();
// // // // //     var status = await Permission.storage.status;
// // // // //     print(status);
// // // // //     final directory = await getExternalStorageDirectories();
// // // // //     print(directory);
// // // // //     final file =
// // // // //         File('/storage/emulated/0/DCIM/${DateTime.now().microsecond}.png');
// // // // //     await file.writeAsBytes(byteData);

// // // // //     // print('end');
// // // // //   }

// // // // //   Future<void> _loadUserData() async {
// // // // //     final prefs = await SharedPreferences.getInstance();
// // // // //     setState(() {
// // // // //       _userData.forEach((key, value) {
// // // // //         _userData[key] = prefs.getString(key) ?? value;
// // // // //       });
// // // // //     });
// // // // //   }

// // // // //   Future<void> _saveUserData(String key, String value) async {
// // // // //     final prefs = await SharedPreferences.getInstance();
// // // // //     await prefs.setString(key, value);
// // // // //     setState(() {
// // // // //       _userData[key] = value;
// // // // //     });
// // // // //   }

// // // // //   Future<void> _editField(
// // // // //       BuildContext context, String field, String currentValue) async {
// // // // //     final controller = TextEditingController(text: currentValue);

// // // // //     String? result = await showDialog<String>(
// // // // //       context: context,
// // // // //       builder: (context) => AlertDialog(
// // // // //         title: Text('Modifier ${_getFieldTitle(field)}'),
// // // // //         content: TextField(
// // // // //           controller: controller,
// // // // //           decoration: InputDecoration(
// // // // //             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
// // // // //           ),
// // // // //         ),
// // // // //         actions: [
// // // // //           TextButton(
// // // // //             onPressed: () => Navigator.pop(context),
// // // // //             child: const Text('Annuler'),
// // // // //           ),
// // // // //           TextButton(
// // // // //             onPressed: () => Navigator.pop(context, controller.text),
// // // // //             child: const Text('Sauvegarder'),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );

// // // // //     if (result != null && result.isNotEmpty) {
// // // // //       await _saveUserData(field, result);
// // // // //     }
// // // // //   }

// // // // //   String _getFieldTitle(String field) {
// // // // //     switch (field) {
// // // // //       case 'name':
// // // // //         return 'Nom complet';
// // // // //       case 'birthdate':
// // // // //         return 'Date de naissance';
// // // // //       case 'email':
// // // // //         return 'Email';
// // // // //       case 'phone':
// // // // //         return 'Téléphone';
// // // // //       case 'address':
// // // // //         return 'Adresse';
// // // // //       case 'bloodType':
// // // // //         return 'Groupe sanguin';
// // // // //       case 'allergies':
// // // // //         return 'Allergies';
// // // // //       case 'emergencyContact':
// // // // //         return 'Contact d\'urgence';
// // // // //       default:
// // // // //         return field;
// // // // //     }
// // // // //   }

// // // // //   Widget _buildProfileHeader() {
// // // // //     return Container(
// // // // //       width: double.infinity,
// // // // //       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
// // // // //       decoration: BoxDecoration(
// // // // //         color: AppColors.primary,
// // // // //         borderRadius: const BorderRadius.only(
// // // // //           bottomLeft: Radius.circular(30),
// // // // //           bottomRight: Radius.circular(30),
// // // // //         ),
// // // // //       ),
// // // // //       child: Column(
// // // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // // //         crossAxisAlignment: CrossAxisAlignment.center,
// // // // //         children: [
// // // // //           Center(
// // // // //             child: SizedBox(
// // // // //               width: 250,
// // // // //               height: 120,
// // // // //               child: Stack(
// // // // //                 alignment: Alignment.center,
// // // // //                 children: [
// // // // //                   Container(
// // // // //                     decoration: BoxDecoration(
// // // // //                       shape: BoxShape.circle,
// // // // //                       border: Border.all(
// // // // //                         color: Colors.white,
// // // // //                         width: 4,
// // // // //                       ),
// // // // //                     ),
// // // // //                     child: const CircleAvatar(
// // // // //                       radius: 80,
// // // // //                       backgroundImage: AssetImage('assets/images/nurse1.jpeg'),
// // // // //                     ),
// // // // //                   ),
// // // // //                   Positioned(
// // // // //                     bottom: 0,
// // // // //                     right: 65,
// // // // //                     child: Container(
// // // // //                       padding: const EdgeInsets.all(4),
// // // // //                       decoration: BoxDecoration(
// // // // //                         color: Colors.white,
// // // // //                         shape: BoxShape.circle,
// // // // //                         boxShadow: [
// // // // //                           BoxShadow(
// // // // //                             color: Colors.black.withOpacity(0.1),
// // // // //                             spreadRadius: 1,
// // // // //                             blurRadius: 2,
// // // // //                             offset: const Offset(0, 1),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                       child: Icon(
// // // // //                         Icons.camera_alt,
// // // // //                         color: AppColors.primary,
// // // // //                         size: 20,
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(height: 20),
// // // // //           const Text(
// // // // //             'Hello',
// // // // //             style: TextStyle(
// // // // //               fontSize: 24,
// // // // //               color: Colors.white,
// // // // //               fontWeight: FontWeight.normal,
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(height: 8),
// // // // //           Text(
// // // // //             _userData['name']!,
// // // // //             style: const TextStyle(
// // // // //               fontSize: 26,
// // // // //               color: Colors.white,
// // // // //               fontWeight: FontWeight.bold,
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildInfoCard(IconData icon, String field, String value) {
// // // // //     return Card(
// // // // //       elevation: 2,
// // // // //       margin: const EdgeInsets.only(bottom: 12),
// // // // //       shape: RoundedRectangleBorder(
// // // // //         borderRadius: BorderRadius.circular(15),
// // // // //       ),
// // // // //       child: InkWell(
// // // // //         onTap: () => _editField(context, field, value),
// // // // //         borderRadius: BorderRadius.circular(15),
// // // // //         child: Padding(
// // // // //           padding: const EdgeInsets.all(16),
// // // // //           child: Row(
// // // // //             children: [
// // // // //               Container(
// // // // //                 padding: const EdgeInsets.all(10),
// // // // //                 decoration: BoxDecoration(
// // // // //                   color: AppColors.primary.withOpacity(0.1),
// // // // //                   borderRadius: BorderRadius.circular(10),
// // // // //                 ),
// // // // //                 child: Icon(icon, color: AppColors.primary, size: 24),
// // // // //               ),
// // // // //               const SizedBox(width: 16),
// // // // //               Expanded(
// // // // //                 child: Column(
// // // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                   children: [
// // // // //                     Text(
// // // // //                       _getFieldTitle(field),
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 14,
// // // // //                         color: Colors.grey[600],
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 4),
// // // // //                     Text(
// // // // //                       value,
// // // // //                       style: const TextStyle(
// // // // //                         fontSize: 16,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //               Icon(
// // // // //                 Icons.edit,
// // // // //                 color: AppColors.primary.withOpacity(0.5),
// // // // //                 size: 20,
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   void _generateQRCode(BuildContext context) {
// // // // //     final qrData = _userData.entries
// // // // //         .map((e) => '${_getFieldTitle(e.key)}: ${e.value}')
// // // // //         .join('\n');

// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder: (context) => AlertDialog(
// // // // //         title: const Text('Code QR'),
// // // // //         content: SizedBox(
// // // // //           width: 200,
// // // // //           height: 250,
// // // // //           child: Column(
// // // // //             mainAxisSize: MainAxisSize.min,
// // // // //             children: [
// // // // //               WidgetsToImage(
// // // // //                   child: Container(
// // // // //                     color: Colors.white,
// // // // //                     child: QrImageView(
// // // // //                       data: qrData,
// // // // //                       version: QrVersions.auto,
// // // // //                       size: 200.0,
// // // // //                       gapless: false,
// // // // //                       errorStateBuilder: (context, error) {
// // // // //                         return const Center(
// // // // //                           child: Text('Erreur de génération du QR code'),
// // // // //                         );
// // // // //                       },
// // // // //                     ),
// // // // //                   ),
// // // // //                   controller: controller),
// // // // //               const SizedBox(height: 10),
// // // // //               const Text('Scannez ce code pour voir les informations.'),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //         actions: [
// // // // //           TextButton(
// // // // //             onPressed: () async {
// // // // //            var les_bites = await   controller.capture();
// // // // //            _saveFile(les_bites!);
// // // // //             },
// // // // //             child: const Text('Enregistrer'),
// // // // //           ),
// // // // //           TextButton(
// // // // //             onPressed: () => Navigator.pop(context),
// // // // //             child: const Text('Fermer'),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }





// // // // // lib/screens/profile_screen.dart
// // // // import 'dart:io';
// // // // import 'dart:typed_data';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:path_provider/path_provider.dart';
// // // // import 'package:permission_handler/permission_handler.dart';
// // // // import 'package:shared_preferences/shared_preferences.dart';
// // // // import 'package:qr_flutter/qr_flutter.dart';
// // // // import 'package:widgets_to_image/widgets_to_image.dart';
// // // // import '../constants/app_colors.dart';
// // // // import '../services/api_service.dart';
// // // // import '../models/user_model.dart';

// // // // class ProfileScreen extends StatefulWidget {
// // // //   const ProfileScreen({super.key});

// // // //   @override
// // // //   State<ProfileScreen> createState() => _ProfileScreenState();
// // // // }

// // // // class _ProfileScreenState extends State<ProfileScreen> {
// // // //   final Map<String, String> _userData = {
// // // //     'name': 'Nom Prenom',
// // // //     'birthdate': '15/03/1990',
// // // //     'email': 'email.example@gmail.com',
// // // //     'phone': '+228 XX XX XX XX',
// // // //     'address': 'Quartier X, Ville',
// // // //     'bloodType': 'Aucun Groupe Sanguin',
// // // //     'allergies': 'Aucune allergie',
// // // //     'emergencyContact': 'Aucun contact d\'urgence',
// // // //     'profilePhoto': 'https://via.placeholder.com/150',
// // // //   };

// // // //   WidgetsToImageController controller = WidgetsToImageController();

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _loadUserData();
// // // //   }

// // // //   Future<void> _loadUserData() async {
// // // //     final prefs = await SharedPreferences.getInstance();
// // // //     try {
// // // //       final userData = await ApiService.getUserProfile();
// // // //       final user = UserModel.fromMap(userData);
// // // //       setState(() {
// // // //         _userData['name'] = user.fullName;
// // // //         _userData['birthdate'] = user.dateOfBirth ?? prefs.getString('birthdate') ?? _userData['birthdate']!;
// // // //         _userData['email'] = user.email;
// // // //         _userData['phone'] = user.phoneNumber ?? prefs.getString('phone') ?? _userData['phone']!;
// // // //         _userData['profilePhoto'] = user.profilePhoto;
// // // //         // Preserve other fields
// // // //         _userData['address'] = prefs.getString('address') ?? _userData['address']!;
// // // //         _userData['bloodType'] = prefs.getString('bloodType') ?? _userData['bloodType']!;
// // // //         _userData['allergies'] = prefs.getString('allergies') ?? _userData['allergies']!;
// // // //         _userData['emergencyContact'] = prefs.getString('emergencyContact') ?? _userData['emergencyContact']!;
// // // //         // Store in SharedPreferences for offline access
// // // //         prefs.setString('name', user.fullName);
// // // //         prefs.setString('email', user.email);
// // // //         prefs.setString('profilePhoto', user.profilePhoto);
// // // //         if (user.dateOfBirth != null) prefs.setString('birthdate', user.dateOfBirth!);
// // // //         if (user.phoneNumber != null) prefs.setString('phone', user.phoneNumber!);
// // // //       });
// // // //     } catch (e) {
// // // //       setState(() {
// // // //         _userData.forEach((key, value) {
// // // //           _userData[key] = prefs.getString(key) ?? value;
// // // //         });
// // // //       });
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Erreur lors du chargement du profil: $e')),
// // // //         );
// // // //       }
// // // //     }
// // // //   }

// // // //   Future<void> _saveFile(Uint8List byteData) async {
// // // //     if (Platform.isAndroid && (await Permission.storage.request()).isDenied) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text('Permission de stockage refusée')),
// // // //       );
// // // //       return;
// // // //     }
// // // //     final directory = await getApplicationDocumentsDirectory();
// // // //     final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
// // // //     await file.writeAsBytes(byteData);
// // // //     if (mounted) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text('QR code enregistré dans ${file.path}')),
// // // //       );
// // // //     }
// // // //   }

// // // //   Future<void> _saveUserData(String key, String value) async {
// // // //     final prefs = await SharedPreferences.getInstance();
// // // //     await prefs.setString(key, value);
// // // //     setState(() {
// // // //       _userData[key] = value;
// // // //     });
// // // //   }

// // // //   Future<void> _editField(BuildContext context, String field, String currentValue) async {
// // // //     final controller = TextEditingController(text: currentValue);

// // // //     String? result = await showDialog<String>(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         title: Text('Modifier ${_getFieldTitle(field)}'),
// // // //         content: TextField(
// // // //           controller: controller,
// // // //           decoration: InputDecoration(
// // // //             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
// // // //           ),
// // // //         ),
// // // //         actions: [
// // // //           TextButton(
// // // //             onPressed: () => Navigator.pop(context),
// // // //             child: const Text('Annuler'),
// // // //           ),
// // // //           TextButton(
// // // //             onPressed: () => Navigator.pop(context, controller.text),
// // // //             child: const Text('Sauvegarder'),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );

// // // //     if (result != null && result.isNotEmpty) {
// // // //       await _saveUserData(field, result);
// // // //     }
// // // //   }

// // // //   String _getFieldTitle(String field) {
// // // //     switch (field) {
// // // //       case 'name':
// // // //         return 'Nom complet';
// // // //       case 'birthdate':
// // // //         return 'Date de naissance';
// // // //       case 'email':
// // // //         return 'Email';
// // // //       case 'phone':
// // // //         return 'Téléphone';
// // // //       case 'address':
// // // //         return 'Adresse';
// // // //       case 'bloodType':
// // // //         return 'Groupe sanguin';
// // // //       case 'allergies':
// // // //         return 'Allergies';
// // // //       case 'emergencyContact':
// // // //         return 'Contact d\'urgence';
// // // //       default:
// // // //         return field;
// // // //     }
// // // //   }

// // // //   Widget _buildProfileHeader() {
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
// // // //       decoration: BoxDecoration(
// // // //         color: AppColors.primary,
// // // //         borderRadius: const BorderRadius.only(
// // // //           bottomLeft: Radius.circular(30),
// // // //           bottomRight: Radius.circular(30),
// // // //         ),
// // // //       ),
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         crossAxisAlignment: CrossAxisAlignment.center,
// // // //         children: [
// // // //           Center(
// // // //             child: SizedBox(
// // // //               width: 250,
// // // //               height: 120,
// // // //               child: Stack(
// // // //                 alignment: Alignment.center,
// // // //                 children: [
// // // //                   Container(
// // // //                     decoration: BoxDecoration(
// // // //                       shape: BoxShape.circle,
// // // //                       border: Border.all(
// // // //                         color: Colors.white,
// // // //                         width: 4,
// // // //                       ),
// // // //                     ),
// // // //                     child: CircleAvatar(
// // // //                       radius: 80,
// // // //                       backgroundImage: _userData['profilePhoto']!.startsWith('http')
// // // //                           ? NetworkImage(_userData['profilePhoto']!)
// // // //                           : AssetImage('assets/images/nurse1.jpeg') as ImageProvider,
// // // //                     ),
// // // //                   ),
// // // //                   Positioned(
// // // //                     bottom: 0,
// // // //                     right: 65,
// // // //                     child: Container(
// // // //                       padding: const EdgeInsets.all(4),
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.white,
// // // //                         shape: BoxShape.circle,
// // // //                         boxShadow: [
// // // //                           BoxShadow(
// // // //                             color: Colors.black.withOpacity(0.1),
// // // //                             spreadRadius: 1,
// // // //                             blurRadius: 2,
// // // //                             offset: const Offset(0, 1),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                       child: Icon(
// // // //                         Icons.camera_alt,
// // // //                         color: AppColors.primary,
// // // //                         size: 20,
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(height: 20),
// // // //           const Text(
// // // //             'Hello',
// // // //             style: TextStyle(
// // // //               fontSize: 24,
// // // //               color: Colors.white,
// // // //               fontWeight: FontWeight.normal,
// // // //             ),
// // // //           ),
// // // //           const SizedBox(height: 8),
// // // //           Text(
// // // //             _userData['name']!,
// // // //             style: const TextStyle(
// // // //               fontSize: 26,
// // // //               color: Colors.white,
// // // //               fontWeight: FontWeight.bold,
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildInfoCard(IconData icon, String field, String value) {
// // // //     return Card(
// // // //       elevation: 2,
// // // //       margin: const EdgeInsets.only(bottom: 12),
// // // //       shape: RoundedRectangleBorder(
// // // //         borderRadius: BorderRadius.circular(15),
// // // //       ),
// // // //       child: InkWell(
// // // //         onTap: () => _editField(context, field, value),
// // // //         borderRadius: BorderRadius.circular(15),
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(16),
// // // //           child: Row(
// // // //             children: [
// // // //               Container(
// // // //                 padding: const EdgeInsets.all(10),
// // // //                 decoration: BoxDecoration(
// // // //                   color: AppColors.primary.withOpacity(0.1),
// // // //                   borderRadius: BorderRadius.circular(10),
// // // //                 ),
// // // //                 child: Icon(icon, color: AppColors.primary, size: 24),
// // // //               ),
// // // //               const SizedBox(width: 16),
// // // //               Expanded(
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     Text(
// // // //                       _getFieldTitle(field),
// // // //                       style: TextStyle(
// // // //                         fontSize: 14,
// // // //                         color: Colors.grey[600],
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 4),
// // // //                     Text(
// // // //                       value,
// // // //                       style: const TextStyle(
// // // //                         fontSize: 16,
// // // //                         fontWeight: FontWeight.bold,
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               Icon(
// // // //                 Icons.edit,
// // // //                 color: AppColors.primary.withOpacity(0.5),
// // // //                 size: 20,
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _generateQRCode(BuildContext context) {
// // // //     final qrData = _userData.entries
// // // //         .map((e) => '${_getFieldTitle(e.key)}: ${e.value}')
// // // //         .join('\n');

// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         title: const Text('Code QR'),
// // // //         content: SizedBox(
// // // //           width: 200,
// // // //           height: 250,
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               WidgetsToImage(
// // // //                 controller: controller,
// // // //                 child: Container(
// // // //                   color: Colors.white,
// // // //                   child: QrImageView(
// // // //                     data: qrData,
// // // //                     version: QrVersions.auto,
// // // //                     size: 200.0,
// // // //                     gapless: false,
// // // //                     errorStateBuilder: (context, error) {
// // // //                       return const Center(
// // // //                         child: Text('Erreur de génération du QR code'),
// // // //                       );
// // // //                     },
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 10),
// // // //               const Text('Scannez ce code pour voir les informations.'),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //         actions: [
// // // //           TextButton(
// // // //             onPressed: () async {
// // // //               var bytes = await controller.capture();
// // // //               if (bytes != null) {
// // // //                 await _saveFile(bytes);
// // // //               }
// // // //             },
// // // //             child: const Text('Enregistrer'),
// // // //           ),
// // // //           TextButton(
// // // //             onPressed: () => Navigator.pop(context),
// // // //             child: const Text('Fermer'),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.grey[50],
// // // //       appBar: AppBar(
// // // //         backgroundColor: AppColors.primary,
// // // //         elevation: 0,
// // // //         title: const Text(
// // // //           'Mon Profil',
// // // //           style: TextStyle(
// // // //             color: Colors.white,
// // // //             fontSize: 20,
// // // //             fontWeight: FontWeight.w500,
// // // //           ),
// // // //         ),
// // // //         centerTitle: false,
// // // //         actions: [
// // // //           IconButton(
// // // //             icon: const Icon(Icons.settings, color: Colors.white),
// // // //             onPressed: () {
// // // //               // TODO: Implémenter les paramètres
// // // //             },
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       body: SingleChildScrollView(
// // // //         child: Column(
// // // //           children: [
// // // //             _buildProfileHeader(),
// // // //             Padding(
// // // //               padding: const EdgeInsets.all(16),
// // // //               child: Column(
// // // //                 children: [
// // // //                   _buildInfoCard(Icons.person_outline, 'name', _userData['name']!),
// // // //                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate', _userData['birthdate']!),
// // // //                   _buildInfoCard(Icons.email_outlined, 'email', _userData['email']!),
// // // //                   _buildInfoCard(Icons.phone_outlined, 'phone', _userData['phone']!),
// // // //                   _buildInfoCard(Icons.location_on_outlined, 'address', _userData['address']!),
// // // //                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _userData['bloodType']!),
// // // //                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _userData['allergies']!),
// // // //                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact', _userData['emergencyContact']!),
// // // //                   const SizedBox(height: 20),
// // // //                   ElevatedButton.icon(
// // // //                     onPressed: () => _generateQRCode(context),
// // // //                     icon: const Icon(Icons.qr_code, color: Colors.white),
// // // //                     label: const Text(
// // // //                       'Générer le code QR',
// // // //                       style: TextStyle(color: Colors.white),
// // // //                     ),
// // // //                     style: ElevatedButton.styleFrom(
// // // //                       backgroundColor: AppColors.primary,
// // // //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // // //                       shape: RoundedRectangleBorder(
// // // //                         borderRadius: BorderRadius.circular(10),
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }



// // // // import 'dart:io';
// // // // import 'dart:typed_data';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:http/http.dart' as http;
// // // // import 'package:path_provider/path_provider.dart';
// // // // import 'package:permission_handler/permission_handler.dart';
// // // // import 'package:shared_preferences/shared_preferences.dart';
// // // // import 'package:qr_flutter/qr_flutter.dart';
// // // // import 'package:widgets_to_image/widgets_to_image.dart';
// // // // import '../constants/app_colors.dart';
// // // // import '../config.dart';
// // // // import '../models/user_model.dart';
// // // // import 'signin_screen.dart';
// // // // import 'dart:convert';

// // // // class ProfileScreen extends StatefulWidget {
// // // //   const ProfileScreen({super.key});

// // // //   @override
// // // //   State<ProfileScreen> createState() => _ProfileScreenState();
// // // // }

// // // // class _ProfileScreenState extends State<ProfileScreen> {
// // // //   final Map<String, String> _userData = {
// // // //     'name': 'Nom Prenom',
// // // //     'birthdate': '15/03/1990',
// // // //     'email': 'email.example@gmail.com',
// // // //     'phone': '+228 XX XX XX XX',
// // // //     'address': 'Quartier X, Ville',
// // // //     'bloodType': 'Aucun Groupe Sanguin',
// // // //     'allergies': 'Aucune allergie',
// // // //     'emergencyContact': 'Aucun contact d\'urgence',
// // // //     'profilePhoto': 'https://via.placeholder.com/150',
// // // //   };

// // // //   WidgetsToImageController controller = WidgetsToImageController();

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _loadUserData();
// // // //   }

// // // //   Future<void> _loadUserData() async {
// // // //     print('Démarrage de _loadUserData');
// // // //     await Config.loadToken();
// // // //     print('Token chargé : ${Config.jwtToken}');

// // // //     if (Config.jwtToken == null) {
// // // //       print('Aucun token trouvé, redirection vers SignInScreen');
// // // //       if (mounted) {
// // // //         Navigator.pushReplacementNamed(context, '/signin');
// // // //       }
// // // //       return;
// // // //     }

// // // //     final prefs = await SharedPreferences.getInstance();
// // // //     try {
// // // //       print('Envoi de la requête à ${Config.usersUrl}/me');
// // // //       final response = await http.get(
// // // //         Uri.parse('${Config.usersUrl}/me'),
// // // //         headers: Config.authHeaders,
// // // //       ).timeout(Config.timeoutDuration);

// // // //       print('Statut de la réponse : ${response.statusCode}');
// // // //       print('Corps de la réponse : ${response.body}');

// // // //       if (response.statusCode == 200) {
// // // //         final data = jsonDecode(response.body);
// // // //         print('Données décodées : $data');
// // // //         final user = UserModel.fromMap(data);
// // // //         setState(() {
// // // //           _userData['name'] = user.fullName ?? prefs.getString('name') ?? 'Nom Prenom';
// // // //           _userData['birthdate'] = user.dateOfBirth ?? prefs.getString('birthdate') ?? _userData['birthdate']!;
// // // //           _userData['email'] = user.email ?? prefs.getString('email') ?? _userData['email']!;
// // // //           _userData['phone'] = user.phoneNumber ?? prefs.getString('phone') ?? _userData['phone']!;
// // // //           _userData['profilePhoto'] = user.profilePhoto ?? prefs.getString('profilePhoto') ?? _userData['profilePhoto']!;
// // // //           _userData['address'] = prefs.getString('address') ?? _userData['address']!;
// // // //           _userData['bloodType'] = prefs.getString('bloodType') ?? _userData['bloodType']!;
// // // //           _userData['allergies'] = prefs.getString('allergies') ?? _userData['allergies']!;
// // // //           _userData['emergencyContact'] = prefs.getString('emergencyContact') ?? _userData['emergencyContact']!;
// // // //           // Sauvegarde dans SharedPreferences
// // // //           prefs.setString('name', _userData['name']!);
// // // //           prefs.setString('email', _userData['email']!);
// // // //           prefs.setString('profilePhoto', _userData['profilePhoto']!);
// // // //           if (user.dateOfBirth != null) prefs.setString('birthdate', user.dateOfBirth!);
// // // //           if (user.phoneNumber != null) prefs.setString('phone', user.phoneNumber!);
// // // //           print('Données utilisateur mises à jour : ${_userData['name']}');
// // // //         });
// // // //       } else {
// // // //         print('Erreur lors de la récupération du profil : ${response.statusCode}');
// // // //         setState(() {
// // // //           _userData.forEach((key, value) {
// // // //             _userData[key] = prefs.getString(key) ?? value;
// // // //           });
// // // //         });
// // // //         if (response.statusCode == 401 || response.statusCode == 404) {
// // // //           print('Erreur 401 ou 404, déconnexion et redirection vers SignInScreen');
// // // //           await Config.removeToken();
// // // //           if (mounted) {
// // // //             Navigator.pushReplacementNamed(context, '/signin');
// // // //           }
// // // //         } else {
// // // //           if (mounted) {
// // // //             ScaffoldMessenger.of(context).showSnackBar(
// // // //               SnackBar(content: Text('Erreur lors du chargement du profil: ${response.statusCode}')),
// // // //             );
// // // //           }
// // // //         }
// // // //       }
// // // //     } catch (e) {
// // // //       print('Erreur réseau ou timeout : $e');
// // // //       setState(() {
// // // //         _userData.forEach((key, value) {
// // // //           _userData[key] = prefs.getString(key) ?? value;
// // // //         });
// // // //       });
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Erreur réseau: $e')),
// // // //         );
// // // //       }
// // // //     }
// // // //   }

// // // //   Future<void> _saveUserData(String key, String value) async {
// // // //     // Validation côté client
// // // //     if (!_validateField(key, value)) {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text(_getValidationErrorMessage(key))),
// // // //         );
// // // //       }
// // // //       return;
// // // //     }

// // // //     // Mapper les clés de _userData aux clés de l'API
// // // //     final apiKey = _mapToApiKey(key);
// // // //     try {
// // // //       print('Envoi de la requête PATCH à ${Config.usersUrl}/me');
// // // //       final response = await http.patch(
// // // //         Uri.parse('${Config.usersUrl}/me'),
// // // //         headers: Config.authHeaders,
// // // //         body: jsonEncode({apiKey: value}),
// // // //       ).timeout(Config.timeoutDuration);

// // // //       print('Statut de la réponse PATCH : ${response.statusCode}');
// // // //       print('Corps de la réponse PATCH : ${response.body}');

// // // //       if (response.statusCode == 200) {
// // // //         final prefs = await SharedPreferences.getInstance();
// // // //         await prefs.setString(key, value);
// // // //         setState(() {
// // // //           _userData[key] = value;
// // // //         });
// // // //         if (mounted) {
// // // //           ScaffoldMessenger.of(context).showSnackBar(
// // // //             const SnackBar(content: Text('Mise à jour réussie')),
// // // //           );
// // // //         }
// // // //       } else {
// // // //         throw Exception('Échec de la mise à jour: ${response.statusCode} - ${response.body}');
// // // //       }
// // // //     } catch (e) {
// // // //       print('Erreur lors de la mise à jour : $e');
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
// // // //         );
// // // //       }
// // // //     }
// // // //   }

// // // //   bool _validateField(String key, String value) {
// // // //     switch (key) {
// // // //       case 'email':
// // // //         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
// // // //       case 'phone':
// // // //         return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);
// // // //       case 'birthdate':
// // // //         try {
// // // //           final parts = value.split('/');
// // // //           if (parts.length != 3) return false;
// // // //           final day = int.parse(parts[0]);
// // // //           final month = int.parse(parts[1]);
// // // //           final year = int.parse(parts[2]);
// // // //           final date = DateTime(year, month, day);
// // // //           return date.isBefore(DateTime.now()) && year >= 1900;
// // // //         } catch (e) {
// // // //           return false;
// // // //         }
// // // //       case 'name':
// // // //         return value.trim().isNotEmpty && value.length <= 100;
// // // //       case 'address':
// // // //       case 'bloodType':
// // // //       case 'allergies':
// // // //       case 'emergencyContact':
// // // //         return value.trim().isNotEmpty;
// // // //       default:
// // // //         return true;
// // // //     }
// // // //   }

// // // //   String _getValidationErrorMessage(String key) {
// // // //     switch (key) {
// // // //       case 'email':
// // // //         return 'Veuillez entrer un email valide (ex: nom@domaine.com)';
// // // //       case 'phone':
// // // //         return 'Veuillez entrer un numéro de téléphone valide (ex: +22890123456)';
// // // //       case 'birthdate':
// // // //         return 'Veuillez entrer une date de naissance valide (ex: 15/03/1990)';
// // // //       case 'name':
// // // //         return 'Veuillez entrer un nom valide (non vide, max 100 caractères)';
// // // //       case 'address':
// // // //       case 'bloodType':
// // // //       case 'allergies':
// // // //       case 'emergencyContact':
// // // //         return 'Ce champ ne peut pas être vide';
// // // //       default:
// // // //         return 'Valeur invalide';
// // // //     }
// // // //   }

// // // //   String _mapToApiKey(String key) {
// // // //     switch (key) {
// // // //       case 'name':
// // // //         return 'fullName';
// // // //       case 'phone':
// // // //         return 'phoneNumber';
// // // //       case 'birthdate':
// // // //         return 'dateOfBirth';
// // // //       default:
// // // //         return key;
// // // //     }
// // // //   }

// // // //   Future<void> _saveFile(Uint8List byteData) async {
// // // //     if (Platform.isAndroid && (await Permission.storage.request()).isDenied) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         const SnackBar(content: Text('Permission de stockage refusée')),
// // // //       );
// // // //       return;
// // // //     }
// // // //     final directory = await getApplicationDocumentsDirectory();
// // // //     final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
// // // //     await file.writeAsBytes(byteData);
// // // //     if (mounted) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text('QR code enregistré dans ${file.path}')),
// // // //       );
// // // //     }
// // // //   }

// // // //   Future<void> _editField(BuildContext context, String field, String currentValue) async {
// // // //     final controller = TextEditingController(text: currentValue);

// // // //     String? result = await showDialog<String>(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         title: Text('Modifier ${_getFieldTitle(field)}'),
// // // //         content: TextField(
// // // //           controller: controller,
// // // //           decoration: InputDecoration(
// // // //             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
// // // //             errorText: _validateField(field, controller.text) ? null : _getValidationErrorMessage(field),
// // // //           ),
// // // //           onChanged: (value) {
// // // //             setState(() {}); // Validation en temps réel
// // // //           },
// // // //         ),
// // // //         actions: [
// // // //           TextButton(
// // // //             onPressed: () => Navigator.pop(context),
// // // //             child: const Text('Annuler'),
// // // //           ),
// // // //           TextButton(
// // // //             onPressed: () {
// // // //               if (_validateField(field, controller.text)) {
// // // //                 Navigator.pop(context, controller.text);
// // // //               } else {
// // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // //                   SnackBar(content: Text(_getValidationErrorMessage(field))),
// // // //                 );
// // // //               }
// // // //             },
// // // //             child: const Text('Sauvegarder'),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );

// // // //     if (result != null && result.isNotEmpty) {
// // // //       await _saveUserData(field, result);
// // // //     }
// // // //   }

// // // //   String _getFieldTitle(String field) {
// // // //     switch (field) {
// // // //       case 'name':
// // // //         return 'Nom complet';
// // // //       case 'birthdate':
// // // //         return 'Date de naissance';
// // // //       case 'email':
// // // //         return 'Email';
// // // //       case 'phone':
// // // //         return 'Téléphone';
// // // //       case 'address':
// // // //         return 'Adresse';
// // // //       case 'bloodType':
// // // //         return 'Groupe sanguin';
// // // //       case 'allergies':
// // // //         return 'Allergies';
// // // //       case 'emergencyContact':
// // // //         return 'Contact d\'urgence';
// // // //       default:
// // // //         return field;
// // // //     }
// // // //   }

// // // //   Widget _buildProfileHeader() {
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
// // // //       decoration: BoxDecoration(
// // // //         color: AppColors.primary,
// // // //         borderRadius: const BorderRadius.only(
// // // //           bottomLeft: Radius.circular(30),
// // // //           bottomRight: Radius.circular(30),
// // // //         ),
// // // //       ),
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         crossAxisAlignment: CrossAxisAlignment.center,
// // // //         children: [
// // // //           Center(
// // // //             child: SizedBox(
// // // //               width: 250,
// // // //               height: 120,
// // // //               child: Stack(
// // // //                 alignment: Alignment.center,
// // // //                 children: [
// // // //                   Container(
// // // //                     decoration: BoxDecoration(
// // // //                       shape: BoxShape.circle,
// // // //                       border: Border.all(
// // // //                         color: Colors.white,
// // // //                         width: 4,
// // // //                       ),
// // // //                     ),
// // // //                     child: CircleAvatar(
// // // //                       radius: 80,
// // // //                       backgroundImage: _userData['profilePhoto']!.startsWith('http')
// // // //                           ? NetworkImage(_userData['profilePhoto']!)
// // // //                           : AssetImage('assets/images/nurse1.jpeg') as ImageProvider,
// // // //                     ),
// // // //                   ),
// // // //                   Positioned(
// // // //                     bottom: 0,
// // // //                     right: 65,
// // // //                     child: Container(
// // // //                       padding: const EdgeInsets.all(4),
// // // //                       decoration: BoxDecoration(
// // // //                         color: Colors.white,
// // // //                         shape: BoxShape.circle,
// // // //                         boxShadow: [
// // // //                           BoxShadow(
// // // //                             color: Colors.black.withOpacity(0.1),
// // // //                             spreadRadius: 1,
// // // //                             blurRadius: 2,
// // // //                             offset: const Offset(0, 1),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                       child: Icon(
// // // //                         Icons.camera_alt,
// // // //                         color: AppColors.primary,
// // // //                         size: 20,
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(height: 20),
// // // //           const Text(
// // // //             'Hello',
// // // //             style: TextStyle(
// // // //               fontSize: 24,
// // // //               color: Colors.white,
// // // //               fontWeight: FontWeight.normal,
// // // //             ),
// // // //           ),
// // // //           const SizedBox(height: 8),
// // // //           Text(
// // // //             _userData['name']!,
// // // //             style: const TextStyle(
// // // //               fontSize: 26,
// // // //               color: Colors.white,
// // // //               fontWeight: FontWeight.bold,
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildInfoCard(IconData icon, String field, String value) {
// // // //     return Card(
// // // //       elevation: 2,
// // // //       margin: const EdgeInsets.only(bottom: 12),
// // // //       shape: RoundedRectangleBorder(
// // // //         borderRadius: BorderRadius.circular(15),
// // // //       ),
// // // //       child: InkWell(
// // // //         onTap: () => _editField(context, field, value),
// // // //         borderRadius: BorderRadius.circular(15),
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(16),
// // // //           child: Row(
// // // //             children: [
// // // //               Container(
// // // //                 padding: const EdgeInsets.all(10),
// // // //                 decoration: BoxDecoration(
// // // //                   color: AppColors.primary.withOpacity(0.1),
// // // //                   borderRadius: BorderRadius.circular(10),
// // // //                 ),
// // // //                 child: Icon(icon, color: AppColors.primary, size: 24),
// // // //               ),
// // // //               const SizedBox(width: 16),
// // // //               Expanded(
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     Text(
// // // //                       _getFieldTitle(field),
// // // //                       style: TextStyle(
// // // //                         fontSize: 14,
// // // //                         color: Colors.grey[600],
// // // //                       ),
// // // //                     ),
// // // //                     const SizedBox(height: 4),
// // // //                     Text(
// // // //                       value,
// // // //                       style: const TextStyle(
// // // //                         fontSize: 16,
// // // //                         fontWeight: FontWeight.bold,
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               Icon(
// // // //                 Icons.edit,
// // // //                 color: AppColors.primary.withOpacity(0.5),
// // // //                 size: 20,
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _generateQRCode(BuildContext context) {
// // // //     final qrData = _userData.entries
// // // //         .map((e) => '${_getFieldTitle(e.key)}: ${e.value}')
// // // //         .join('\n');

// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         title: const Text('Code QR'),
// // // //         content: SizedBox(
// // // //           width: 200,
// // // //           height: 250,
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               WidgetsToImage(
// // // //                 controller: controller,
// // // //                 child: Container(
// // // //                   color: Colors.white,
// // // //                   child: QrImageView(
// // // //                     data: qrData,
// // // //                     version: QrVersions.auto,
// // // //                     size: 200.0,
// // // //                     gapless: false,
// // // //                     errorStateBuilder: (context, error) {
// // // //                       return const Center(
// // // //                         child: Text('Erreur de génération du QR code'),
// // // //                       );
// // // //                     },
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 10),
// // // //               const Text('Scannez ce code pour voir les informations.'),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //         actions: [
// // // //           TextButton(
// // // //             onPressed: () async {
// // // //               var bytes = await controller.capture();
// // // //               if (bytes != null) {
// // // //                 await _saveFile(bytes);
// // // //               }
// // // //             },
// // // //             child: const Text('Enregistrer'),
// // // //           ),
// // // //           TextButton(
// // // //             onPressed: () => Navigator.pop(context),
// // // //             child: const Text('Fermer'),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.grey[50],
// // // //       appBar: AppBar(
// // // //         backgroundColor: AppColors.primary,
// // // //         elevation: 0,
// // // //         title: const Text(
// // // //           'Mon Profil',
// // // //           style: TextStyle(
// // // //             color: Colors.white,
// // // //             fontSize: 20,
// // // //             fontWeight: FontWeight.w500,
// // // //           ),
// // // //         ),
// // // //         centerTitle: false,
// // // //         actions: [
// // // //           IconButton(
// // // //             icon: const Icon(Icons.settings, color: Colors.white),
// // // //             onPressed: () {
// // // //               // TODO: Implémenter les paramètres
// // // //             },
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       body: SingleChildScrollView(
// // // //         child: Column(
// // // //           children: [
// // // //             _buildProfileHeader(),
// // // //             Padding(
// // // //               padding: const EdgeInsets.all(16),
// // // //               child: Column(
// // // //                 children: [
// // // //                   _buildInfoCard(Icons.person_outline, 'name', _userData['name']!),
// // // //                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate', _userData['birthdate']!),
// // // //                   _buildInfoCard(Icons.email_outlined, 'email', _userData['email']!),
// // // //                   _buildInfoCard(Icons.phone_outlined, 'phone', _userData['phone']!),
// // // //                   _buildInfoCard(Icons.location_on_outlined, 'address', _userData['address']!),
// // // //                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _userData['bloodType']!),
// // // //                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _userData['allergies']!),
// // // //                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact', _userData['emergencyContact']!),
// // // //                   const SizedBox(height: 20),
// // // //                   ElevatedButton.icon(
// // // //                     onPressed: () => _generateQRCode(context),
// // // //                     icon: const Icon(Icons.qr_code, color: Colors.white),
// // // //                     label: const Text(
// // // //                       'Générer le code QR',
// // // //                       style: TextStyle(color: Colors.white),
// // // //                     ),
// // // //                     style: ElevatedButton.styleFrom(
// // // //                       backgroundColor: AppColors.primary,
// // // //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // // //                       shape: RoundedRectangleBorder(
// // // //                         borderRadius: BorderRadius.circular(10),
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }



// // // // // lib/screens/profile_screen.dart
// // // //src/

// // // // import 'dart:io';
// // // // import 'dart:typed_data';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:path_provider/path_provider.dart';
// // // // import 'package:permission_handler/permission_handler.dart';
// // // // import 'package:qr_flutter/qr_flutter.dart';
// // // // import 'package:widgets_to_image/widgets_to_image.dart';
// // // // import '../constants/app_colors.dart';
// // // // import '../models/user_model.dart';
// // // // import '../services/auth_service.dart';
// // // // import '../services/api_service.dart';
// // // // import 'signin_screen.dart';

// // // // class ProfileScreen extends StatefulWidget {
// // // //   const ProfileScreen({super.key});

// // // //   @override
// // // //   State<ProfileScreen> createState() => _ProfileScreenState();
// // // // }

// // // // class _ProfileScreenState extends State<ProfileScreen> {
// // // //   UserModel? _currentUser;
// // // //   bool _isLoading = true;
// // // //   WidgetsToImageController controller = WidgetsToImageController();

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _loadUserData();
// // // //   }

// // // //   Future<void> _loadUserData() async {
// // // //     setState(() => _isLoading = true);
// // // //     try {
// // // //       _currentUser = await AuthService.getCurrentUser(forceRefresh: true);
// // // //       if (_currentUser == null || _currentUser!.id.isEmpty) {
// // // //         if (mounted) {
// // // //           Navigator.pushReplacementNamed(context, '/signin');
// // // //         }
// // // //         return;
// // // //       }

// // // //       final userData = await ApiService.getUserProfile();
// // // //       final updatedUser = UserModel.fromMap(userData);
// // // //       if (updatedUser.id != _currentUser!.id) {
// // // //         throw Exception('ID utilisateur incohérent dans la réponse');
// // // //       }
// // // //       await AuthService.saveUser(updatedUser);

// // // //       if (mounted) {
// // // //         setState(() {
// // // //           _currentUser = updatedUser;
// // // //           _isLoading = false;
// // // //         });
// // // //       }
// // // //     } catch (e) {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Erreur: $e')),
// // // //         );
// // // //         setState(() => _isLoading = false);
// // // //       }
// // // //     }
// // // //   }

// // // //   String? _formatDateForDisplay(String? date) {
// // // //     if (date == null) return 'Non renseigné';
// // // //     try {
// // // //       final dateTime = DateTime.parse(date);
// // // //       return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
// // // //     } catch (e) {
// // // //       return date;
// // // //     }
// // // //   }

// // // //   String? _formatDateForApi(String date) {
// // // //     try {
// // // //       final parts = date.split('/');
// // // //       if (parts.length != 3) return null;
// // // //       final day = parts[0];
// // // //       final month = parts[1];
// // // //       final year = parts[2];
// // // //       return '$year-$month-$day';
// // // //     } catch (e) {
// // // //       return null;
// // // //     }
// // // //   }

// // // //   Future<void> _editField(BuildContext context, String field, String currentValue) async {
// // // //     if (field == 'birthdate') {
// // // //       DateTime initialDate;
// // // //       try {
// // // //         final parts = currentValue.split('/');
// // // //         if (parts.length == 3) {
// // // //           initialDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
// // // //         } else {
// // // //           initialDate = DateTime.now();
// // // //         }
// // // //       } catch (e) {
// // // //         initialDate = DateTime.now();
// // // //       }

// // // //       final selectedDate = await showDatePicker(
// // // //         context: context,
// // // //         initialDate: initialDate,
// // // //         firstDate: DateTime(1900),
// // // //         lastDate: DateTime.now(),
// // // //       );

// // // //       if (selectedDate != null) {
// // // //         final formattedDate =
// // // //             '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
// // // //         await _saveUserData(field, formattedDate);
// // // //       }
// // // //       return;
// // // //     }

// // // //     final controller = TextEditingController(text: currentValue.replaceAll('Non renseigné', ''));

// // // //     if (field == 'gender') {
// // // //       String? result = await showDialog<String>(
// // // //         context: context,
// // // //         builder: (context) => AlertDialog(
// // // //           title: Text('Modifier ${_getFieldTitle(field)}'),
// // // //           content: DropdownButtonFormField<String>(
// // // //             value: _currentUser?.gender ?? 'other',
// // // //             decoration: const InputDecoration(labelText: 'Genre'),
// // // //             items: ['male', 'female', 'other']
// // // //                 .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
// // // //                 .toList(),
// // // //             onChanged: (value) {
// // // //               controller.text = value!;
// // // //             },
// // // //           ),
// // // //           actions: [
// // // //             TextButton(
// // // //               onPressed: () => Navigator.pop(context),
// // // //               child: const Text('Annuler'),
// // // //             ),
// // // //             TextButton(
// // // //               onPressed: () => Navigator.pop(context, controller.text),
// // // //               child: const Text('Sauvegarder'),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       );

// // // //       if (result != null && result.isNotEmpty) {
// // // //         await _saveUserData(field, result);
// // // //       }
// // // //       return;
// // // //     }

// // // //     String? result = await showDialog<String>(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         title: Text('Modifier ${_getFieldTitle(field)}'),
// // // //         content: TextField(
// // // //           controller: controller,
// // // //           decoration: InputDecoration(
// // // //             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
// // // //             errorText: _validateField(field, controller.text) ? null : _getValidationErrorMessage(field),
// // // //           ),
// // // //           onChanged: (value) {
// // // //             setState(() {});
// // // //           },
// // // //         ),
// // // //         actions: [
// // // //           TextButton(
// // // //             onPressed: () => Navigator.pop(context),
// // // //             child: const Text('Annuler'),
// // // //           ),
// // // //           TextButton(
// // // //             onPressed: () {
// // // //               if (_validateField(field, controller.text)) {
// // // //                 Navigator.pop(context, controller.text);
// // // //               } else {
// // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // //                   SnackBar(content: Text(_getValidationErrorMessage(field))),
// // // //                 );
// // // //               }
// // // //             },
// // // //             child: const Text('Sauvegarder'),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );

// // // //     if (result != null && result.isNotEmpty) {
// // // //       await _saveUserData(field, result);
// // // //     }
// // // //   }

// // // //   Future<void> _saveUserData(String field, String value) async {
// // // //     if (!_validateField(field, value)) {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text(_getValidationErrorMessage(field))),
// // // //         );
// // // //       }
// // // //       return;
// // // //     }

// // // //     final apiKey = _mapToApiKey(field);
// // // //     final apiValue = field == 'birthdate' ? _formatDateForApi(value) : value;

// // // //     if (apiValue == null && field == 'birthdate') {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(content: Text('Format de date invalide (attendu: JJ/MM/AAAA)')),
// // // //         );
// // // //       }
// // // //       return;
// // // //     }

// // // //     try {
// // // //       await ApiService.updateUserProfile({apiKey: apiValue});
// // // //       final userData = await ApiService.getUserProfile();
// // // //       final updatedUser = UserModel.fromMap(userData);
// // // //       if (updatedUser.id != _currentUser!.id) {
// // // //         throw Exception('ID utilisateur incohérent dans la réponse');
// // // //       }
// // // //       await AuthService.saveUser(updatedUser);

// // // //       if (mounted) {
// // // //         setState(() {
// // // //           _currentUser = updatedUser;
// // // //         });
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(content: Text('Mise à jour réussie')),
// // // //         );
// // // //       }
// // // //     } catch (e) {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
// // // //         );
// // // //       }
// // // //     }
// // // //   }

// // // //   bool _validateField(String key, String value) {
// // // //     switch (key) {
// // // //       case 'email':
// // // //         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
// // // //       case 'phone':
// // // //         return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);
// // // //       case 'birthdate':
// // // //         try {
// // // //           final parts = value.split('/');
// // // //           if (parts.length != 3) return false;
// // // //           final day = int.parse(parts[0]);
// // // //           final month = int.parse(parts[1]);
// // // //           final year = int.parse(parts[2]);
// // // //           final date = DateTime(year, month, day);
// // // //           return date.isBefore(DateTime.now()) && year >= 1900;
// // // //         } catch (e) {
// // // //           return false;
// // // //         }
// // // //       case 'gender':
// // // //         return ['male', 'female', 'other'].contains(value.toLowerCase());
// // // //       case 'name':
// // // //         return value.trim().isNotEmpty && value.length <= 100;
// // // //       case 'address':
// // // //       case 'bloodType':
// // // //       case 'allergies':
// // // //       case 'emergencyContact':
// // // //         return value.trim().isNotEmpty;
// // // //       default:
// // // //         return true;
// // // //     }
// // // //   }

// // // //   String _getValidationErrorMessage(String key) {
// // // //     switch (key) {
// // // //       case 'email':
// // // //         return 'Veuillez entrer un email valide (ex: nom@domaine.com)';
// // // //       case 'phone':
// // // //         return 'Veuillez entrer un numéro de téléphone valide (ex: +22890123456)';
// // // //       case 'birthdate':
// // // //         return 'Veuillez entrer une date de naissance valide (ex: 15/03/1990)';
// // // //       case 'gender':
// // // //         return 'Veuillez entrer un genre valide (male, female, other)';
// // // //       case 'name':
// // // //         return 'Veuillez entrer un nom valide (non vide, max 100 caractères)';
// // // //       case 'address':
// // // //       case 'bloodType':
// // // //       case 'allergies':
// // // //       case 'emergencyContact':
// // // //         return 'Ce champ ne peut pas être vide';
// // // //       default:
// // // //         return 'Valeur invalide';
// // // //     }
// // // //   }

// // // //   String _mapToApiKey(String key) {
// // // //     switch (key) {
// // // //       case 'name':
// // // //         return 'fullName';
// // // //       case 'phone':
// // // //         return 'phoneNumber';
// // // //       case 'birthdate':
// // // //         return 'dateOfBirth';
// // // //       default:
// // // //         return key;
// // // //     }
// // // //   }

// // // //   String _getFieldTitle(String field) {
// // // //     switch (field) {
// // // //       case 'name':
// // // //         return 'Nom complet';
// // // //       case 'birthdate':
// // // //         return 'Date de naissance';
// // // //       case 'email':
// // // //         return 'Email';
// // // //       case 'phone':
// // // //         return 'Téléphone';
// // // //       case 'gender':
// // // //         return 'Genre';
// // // //       case 'address':
// // // //         return 'Adresse';
// // // //       case 'bloodType':
// // // //         return 'Groupe sanguin';
// // // //       case 'allergies':
// // // //         return 'Allergies';
// // // //       case 'emergencyContact':
// // // //         return 'Contact d\'urgence';
// // // //       default:
// // // //         return field;
// // // //     }
// // // //   }

// // // //   Widget _buildProfileHeader() {
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
// // // //       decoration: BoxDecoration(
// // // //         color: AppColors.primary,
// // // //         borderRadius: const BorderRadius.only(
// // // //           bottomLeft: Radius.circular(30),
// // // //           bottomRight: Radius.circular(30),
// // // //         ),
// // // //       ),
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         crossAxisAlignment: CrossAxisAlignment.center,
// // // //         children: [
// // // //           CircleAvatar(
// // // //             radius: 50,
// // // //             backgroundImage: NetworkImage(_currentUser?.profilePhoto ?? 'https://via.placeholder.com/150'),
// // // //           ),
// // // //           const SizedBox(height: 16),
// // // //           Text(
// // // //             _currentUser?.fullName ?? 'Utilisateur',
// // // //             style: const TextStyle(
// // // //               fontSize: 24,
// // // //               color: Colors.white,
// // // //               fontWeight: FontWeight.bold,
// // // //             ),
// // // //           ),
// // // //           Text(
// // // //             _currentUser?.email ?? '',
// // // //             style: const TextStyle(
// // // //               color: Colors.white70,
// // // //               fontSize: 16,
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildInfoCard(IconData icon, String field, String value) {
// // // //     return Card(
// // // //       elevation: 2,
// // // //       margin: const EdgeInsets.only(bottom: 12),
// // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // // //       child: InkWell(
// // // //         onTap: () => _editField(context, field, value),
// // // //         borderRadius: BorderRadius.circular(15),
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(16),
// // // //           child: Row(
// // // //             children: [
// // // //               Container(
// // // //                 padding: const EdgeInsets.all(10),
// // // //                 decoration: BoxDecoration(
// // // //                   color: AppColors.primary.withOpacity(0.1),
// // // //                   borderRadius: BorderRadius.circular(10),
// // // //                 ),
// // // //                 child: Icon(icon, color: AppColors.primary, size: 24),
// // // //               ),
// // // //               const SizedBox(width: 16),
// // // //               Expanded(
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     Text(
// // // //                       _getFieldTitle(field),
// // // //                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
// // // //                     ),
// // // //                     const SizedBox(height: 4),
// // // //                     Text(
// // // //                       value,
// // // //                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               Icon(
// // // //                 Icons.edit,
// // // //                 color: AppColors.primary.withOpacity(0.5),
// // // //                 size: 20,
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _generateQRCode(BuildContext context) {
// // // //     final qrData = [
// // // //       'Nom complet: ${_currentUser?.fullName ?? 'Non renseigné'}',
// // // //       'Email: ${_currentUser?.email ?? 'Non renseigné'}',
// // // //       'Téléphone: ${_currentUser?.phoneNumber ?? 'Non renseigné'}',
// // // //       'Date de naissance: ${_formatDateForDisplay(_currentUser?.dateOfBirth)}',
// // // //       'Genre: ${_currentUser?.gender ?? 'Non renseigné'}',
// // // //       'Adresse: ${_currentUser?.address ?? 'Non renseigné'}',
// // // //       'Groupe sanguin: ${_currentUser?.bloodType ?? 'Non renseigné'}',
// // // //       'Allergies: ${_currentUser?.allergies ?? 'Non renseigné'}',
// // // //       'Contact d\'urgence: ${_currentUser?.emergencyContact ?? 'Non renseigné'}',
// // // //     ].join('\n');

// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         title: const Text('Code QR'),
// // // //         content: SizedBox(
// // // //           width: 200,
// // // //           height: 250,
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               WidgetsToImage(
// // // //                 controller: controller,
// // // //                 child: Container(
// // // //                   color: Colors.white,
// // // //                   child: QrImageView(
// // // //                     data: qrData,
// // // //                     version: QrVersions.auto,
// // // //                     size: 200.0,
// // // //                     gapless: false,
// // // //                     errorStateBuilder: (context, error) {
// // // //                       return const Center(child: Text('Erreur de génération du QR code'));
// // // //                     },
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 10),
// // // //               const Text('Scannez ce code pour voir les informations.'),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //         actions: [
// // // //           TextButton(
// // // //             onPressed: () async {
// // // //               var bytes = await controller.capture();
// // // //               if (bytes != null) {
// // // //                 if (Platform.isAndroid) {
// // // //                   final status = await Permission.storage.request();
// // // //                   if (status.isDenied) {
// // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // //                       const SnackBar(content: Text('Permission de stockage refusée')),
// // // //                     );
// // // //                     return;
// // // //                   }
// // // //                 }
// // // //                 final directory = await getApplicationDocumentsDirectory();
// // // //                 final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
// // // //                 await file.writeAsBytes(bytes);
// // // //                 if (mounted) {
// // // //                   ScaffoldMessenger.of(context).showSnackBar(
// // // //                     SnackBar(content: Text('QR code enregistré dans ${file.path}')),
// // // //                   );
// // // //                 }
// // // //               }
// // // //             },
// // // //             child: const Text('Enregistrer'),
// // // //           ),
// // // //           TextButton(
// // // //             onPressed: () => Navigator.pop(context),
// // // //             child: const Text('Fermer'),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     if (_isLoading) {
// // // //       return Scaffold(
// // // //         appBar: AppBar(
// // // //           title: const Text('Mon Profil'),
// // // //           backgroundColor: AppColors.primary,
// // // //         ),
// // // //         body: const Center(child: CircularProgressIndicator()),
// // // //       );
// // // //     }

// // // //     return Scaffold(
// // // //       backgroundColor: Colors.grey[50],
// // // //       appBar: AppBar(
// // // //         backgroundColor: AppColors.primary,
// // // //         elevation: 0,
// // // //         title: const Text(
// // // //           'Mon Profil',
// // // //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
// // // //         ),
// // // //         actions: [
// // // //           IconButton(
// // // //             icon: const Icon(Icons.logout, color: Colors.white),
// // // //             onPressed: () async {
// // // //               final confirm = await showDialog<bool>(
// // // //                 context: context,
// // // //                 builder: (context) => AlertDialog(
// // // //                   title: const Text('Déconnexion'),
// // // //                   content: const Text('Voulez-vous vraiment vous déconnecter ?'),
// // // //                   actions: [
// // // //                     TextButton(
// // // //                       onPressed: () => Navigator.pop(context, false),
// // // //                       child: const Text('Annuler'),
// // // //                     ),
// // // //                     TextButton(
// // // //                       onPressed: () => Navigator.pop(context, true),
// // // //                       child: const Text('Confirmer'),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               );
// // // //               if (confirm == true) {
// // // //                 await AuthService.logout();
// // // //                 if (mounted) {
// // // //                   Navigator.pushReplacementNamed(context, '/signin');
// // // //                 }
// // // //               }
// // // //             },
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       body: SingleChildScrollView(
// // // //         child: Column(
// // // //           children: [
// // // //             _buildProfileHeader(),
// // // //             Padding(
// // // //               padding: const EdgeInsets.all(16),
// // // //               child: Column(
// // // //                 children: [
// // // //                   _buildInfoCard(Icons.person_outline, 'name', _currentUser?.fullName ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate', _formatDateForDisplay(_currentUser?.dateOfBirth) ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.email_outlined, 'email', _currentUser?.email ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.phone_outlined, 'phone', _currentUser?.phoneNumber ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.transgender, 'gender', _currentUser?.gender ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.location_on_outlined, 'address', _currentUser?.address ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _currentUser?.bloodType ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _currentUser?.allergies ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact', _currentUser?.emergencyContact ?? 'Non renseigné'),
// // // //                   const SizedBox(height: 20),
// // // //                   ElevatedButton.icon(
// // // //                     onPressed: () => _generateQRCode(context),
// // // //                     icon: const Icon(Icons.qr_code, color: Colors.white),
// // // //                     label: const Text('Générer le code QR', style: TextStyle(color: Colors.white)),
// // // //                     style: ElevatedButton.styleFrom(
// // // //                       backgroundColor: AppColors.primary,
// // // //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // // //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }


// // // // import 'dart:io';
// // // // import 'package:cached_network_image/cached_network_image.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:image_picker/image_picker.dart';
// // // // import 'package:path_provider/path_provider.dart';
// // // // import 'package:permission_handler/permission_handler.dart';
// // // // import 'package:qr_flutter/qr_flutter.dart';
// // // // import 'package:widgets_to_image/widgets_to_image.dart';
// // // // import 'package:device_info_plus/device_info_plus.dart';
// // // // import '../constants/app_colors.dart';
// // // // import '../models/user_model.dart';
// // // // import '../services/auth_service.dart';
// // // // import '../services/api_service.dart';
// // // // import 'signin_screen.dart';

// // // // class ProfileScreen extends StatefulWidget {
// // // //   const ProfileScreen({super.key});

// // // //   @override
// // // //   State<ProfileScreen> createState() => _ProfileScreenState();
// // // // }

// // // // class _ProfileScreenState extends State<ProfileScreen> {
// // // //   UserModel? _currentUser;
// // // //   bool _isLoading = true;
// // // //   WidgetsToImageController controller = WidgetsToImageController();
// // // //   final ImagePicker _picker = ImagePicker();

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _loadUserData();
// // // //   }

// // // //   Future<void> _loadUserData() async {
// // // //     setState(() => _isLoading = true);
// // // //     try {
// // // //       _currentUser = await AuthService.getCurrentUser(forceRefresh: true);
// // // //       if (_currentUser == null || _currentUser!.id.isEmpty) {
// // // //         if (mounted) {
// // // //           Navigator.pushReplacementNamed(context, '/signin');
// // // //         }
// // // //         return;
// // // //       }
// // // //       final userData = await ApiService.getUserProfile();
// // // //       print('Profile Photo URL from API: ${userData['profilePhoto']}');
// // // //       final updatedUser = UserModel.fromMap(userData);
// // // //       if (updatedUser.id != _currentUser!.id) {
// // // //         throw Exception('ID utilisateur incohérent dans la réponse');
// // // //       }
// // // //       await AuthService.saveUser(updatedUser);
// // // //       if (mounted) {
// // // //         setState(() {
// // // //           _currentUser = updatedUser;
// // // //           _isLoading = false;
// // // //         });
// // // //       }
// // // //     } catch (e) {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Erreur: $e')),
// // // //         );
// // // //         setState(() => _isLoading = false);
// // // //       }
// // // //     }
// // // //   }

// // // //   Future<bool> _checkAndRequestPermission(Permission permission) async {
// // // //     final status = await permission.status;
// // // //     print('Permission ${permission.toString()}: $status');
// // // //     if (status.isGranted) {
// // // //       return true;
// // // //     }
// // // //     if (status.isPermanentlyDenied) {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(
// // // //             content: const Text('Permission définitivement refusée. Veuillez l\'activer dans les paramètres.'),
// // // //             action: SnackBarAction(
// // // //               label: 'Paramètres',
// // // //               onPressed: () => openAppSettings(),
// // // //             ),
// // // //           ),
// // // //         );
// // // //       }
// // // //       return false;
// // // //     }
// // // //     final newStatus = await permission.request();
// // // //     print('Requested ${permission.toString()}: $newStatus');
// // // //     return newStatus.isGranted;
// // // //   }

// // // //   Future<bool> _requestPermissions() async {
// // // //     if (Platform.isIOS || Platform.isAndroid) {
// // // //       final cameraStatus = await Permission.camera.status;
// // // //       final photoStatus = await (Platform.isAndroid && (await _getAndroidVersion()) >= 33
// // // //           ? Permission.photos.status
// // // //           : Permission.storage.status);
// // // //       print('Camera Status: $cameraStatus');
// // // //       print('Photo/Storage Status: $photoStatus');
// // // //       if (!cameraStatus.isGranted) {
// // // //         final newCameraStatus = await Permission.camera.request();
// // // //         if (!newCameraStatus.isGranted) {
// // // //           if (newCameraStatus.isPermanentlyDenied && mounted) {
// // // //             ScaffoldMessenger.of(context).showSnackBar(
// // // //               SnackBar(
// // // //                 content: const Text('Permission caméra refusée définitivement. Veuillez l\'activer dans les paramètres.'),
// // // //                 action: SnackBarAction(
// // // //                   label: 'Paramètres',
// // // //                   onPressed: () => openAppSettings(),
// // // //                 ),
// // // //               ),
// // // //             );
// // // //           }
// // // //           return false;
// // // //         }
// // // //       }
// // // //       if (!photoStatus.isGranted) {
// // // //         final newPhotoStatus = await (Platform.isAndroid && (await _getAndroidVersion()) >= 33
// // // //             ? Permission.photos.request()
// // // //             : Permission.storage.request());
// // // //         if (!newPhotoStatus.isGranted) {
// // // //           if (newPhotoStatus.isPermanentlyDenied && mounted) {
// // // //             ScaffoldMessenger.of(context).showSnackBar(
// // // //               SnackBar(
// // // //                 content: const Text('Permission photos refusée définitivement. Veuillez l\'activer dans les paramètres.'),
// // // //                 action: SnackBarAction(
// // // //                   label: 'Paramètres',
// // // //                   onPressed: () => openAppSettings(),
// // // //                 ),
// // // //               ),
// // // //             );
// // // //           }
// // // //           return false;
// // // //         }
// // // //       }
// // // //     }
// // // //     return true;
// // // //   }

// // // //   Future<int> _getAndroidVersion() async {
// // // //     if (Platform.isAndroid) {
// // // //       final deviceInfo = DeviceInfoPlugin();
// // // //       final androidInfo = await deviceInfo.androidInfo;
// // // //       return androidInfo.version.sdkInt;
// // // //     }
// // // //     return 0;
// // // //   }

// // // // Future<void> _changeProfilePhoto() async {
// // // //   try {
// // // //     final source = await showDialog<ImageSource>(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         title: const Text('Changer la photo de profil'),
// // // //         content: Column(
// // // //           mainAxisSize: MainAxisSize.min,
// // // //           children: [
// // // //             ListTile(
// // // //               leading: const Icon(Icons.camera_alt),
// // // //               title: const Text('Prendre une photo'),
// // // //               onTap: () => Navigator.pop(context, ImageSource.camera),
// // // //             ),
// // // //             ListTile(
// // // //               leading: const Icon(Icons.photo_library),
// // // //               title: const Text('Choisir dans la galerie'),
// // // //               onTap: () => Navigator.pop(context, ImageSource.gallery),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );

// // // //     if (source == null) return;

// // // //     final XFile? pickedFile = await _picker.pickImage(
// // // //       source: source,
// // // //       maxWidth: 512,
// // // //       maxHeight: 512,
// // // //       imageQuality: 85,
// // // //     );

// // // //     if (pickedFile == null) return;

// // // //     setState(() => _isLoading = true);
    
// // // //     final imageUrl = await ApiService.uploadProfilePhoto(File(pickedFile.path));
    
// // // //     if (imageUrl != null) {
// // // //       await ApiService.updateUserProfile({'profilePhoto': imageUrl});
// // // //       await _loadUserData(); // Recharge les données du profil
      
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(content: Text('Photo de profil mise à jour')),
// // // //         );
// // // //       }
// // // //     }
// // // //   } catch (e) {
// // // //     if (mounted) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(
// // // //         SnackBar(content: Text('Erreur: $e')),
// // // //       );
// // // //     }
// // // //   } finally {
// // // //     setState(() => _isLoading = false);
// // // //   }
// // // // }
// // // //   String? _formatDateForDisplay(String? date) {
// // // //     if (date == null) return 'Non renseigné';
// // // //     try {
// // // //       final dateTime = DateTime.parse(date);
// // // //       return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
// // // //     } catch (e) {
// // // //       return date;
// // // //     }
// // // //   }

// // // //   String? _formatDateForApi(String date) {
// // // //     try {
// // // //       final parts = date.split('/');
// // // //       if (parts.length != 3) return null;
// // // //       final day = parts[0];
// // // //       final month = parts[1];
// // // //       final year = parts[2];
// // // //       return '$year-$month-$day';
// // // //     } catch (e) {
// // // //       return null;
// // // //     }
// // // //   }

// // // //   Future<void> _editField(BuildContext context, String field, String currentValue) async {
// // // //     if (field == 'birthdate') {
// // // //       DateTime initialDate;
// // // //       try {
// // // //         final parts = currentValue.split('/');
// // // //         if (parts.length == 3) {
// // // //           initialDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
// // // //         } else {
// // // //           initialDate = DateTime.now();
// // // //         }
// // // //       } catch (e) {
// // // //         initialDate = DateTime.now();
// // // //       }
// // // //       final selectedDate = await showDatePicker(
// // // //         context: context,
// // // //         initialDate: initialDate,
// // // //         firstDate: DateTime(1900),
// // // //         lastDate: DateTime.now(),
// // // //       );
// // // //       if (selectedDate != null) {
// // // //         final formattedDate =
// // // //             '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
// // // //         await _saveUserData(field, formattedDate);
// // // //       }
// // // //       return;
// // // //     }
// // // //     final controller = TextEditingController(text: currentValue.replaceAll('Non renseigné', ''));
// // // //     if (field == 'gender') {
// // // //       String? result = await showDialog<String>(
// // // //         context: context,
// // // //         builder: (context) => AlertDialog(
// // // //           title: Text('Modifier ${_getFieldTitle(field)}'),
// // // //           content: DropdownButtonFormField<String>(
// // // //             value: _currentUser?.gender ?? 'other',
// // // //             decoration: const InputDecoration(labelText: 'Genre'),
// // // //             items: ['male', 'female', 'other']
// // // //                 .map((gender) => DropdownMenuItem(
// // // //                       value: gender,
// // // //                       child: Text(gender == 'male' ? 'Homme' : gender == 'female' ? 'Femme' : 'Autre'),
// // // //                     ))
// // // //                 .toList(),
// // // //             onChanged: (value) {
// // // //               controller.text = value!;
// // // //             },
// // // //           ),
// // // //           actions: [
// // // //             TextButton(
// // // //               onPressed: () => Navigator.pop(context),
// // // //               child: const Text('Annuler'),
// // // //             ),
// // // //             TextButton(
// // // //               onPressed: () => Navigator.pop(context, controller.text),
// // // //               child: const Text('Sauvegarder'),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       );
// // // //       if (result != null && result.isNotEmpty) {
// // // //         await _saveUserData(field, result);
// // // //       }
// // // //       return;
// // // //     }
// // // //     String? result = await showDialog<String>(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         title: Text('Modifier ${_getFieldTitle(field)}'),
// // // //         content: TextField(
// // // //           controller: controller,
// // // //           decoration: InputDecoration(
// // // //             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
// // // //             errorText: _validateField(field, controller.text) ? null : _getValidationErrorMessage(field),
// // // //           ),
// // // //           onChanged: (value) {
// // // //             setState(() {});
// // // //           },
// // // //         ),
// // // //         actions: [
// // // //           TextButton(
// // // //             onPressed: () => Navigator.pop(context),
// // // //             child: const Text('Annuler'),
// // // //           ),
// // // //           TextButton(
// // // //             onPressed: () {
// // // //               if (_validateField(field, controller.text)) {
// // // //                 Navigator.pop(context, controller.text);
// // // //               } else {
// // // //                 ScaffoldMessenger.of(context).showSnackBar(
// // // //                   SnackBar(content: Text(_getValidationErrorMessage(field))),
// // // //                 );
// // // //               }
// // // //             },
// // // //             child: const Text('Sauvegarder'),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //     if (result != null && result.isNotEmpty) {
// // // //       await _saveUserData(field, result);
// // // //     }
// // // //   }

// // // //   Future<void> _saveUserData(String field, String value) async {
// // // //     if (!_validateField(field, value)) {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text(_getValidationErrorMessage(field))),
// // // //         );
// // // //       }
// // // //       return;
// // // //     }
// // // //     final apiKey = _mapToApiKey(field);
// // // //     final apiValue = field == 'birthdate' ? _formatDateForApi(value) : value;
// // // //     if (apiValue == null && field == 'birthdate') {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(content: Text('Format de date invalide (attendu: JJ/MM/AAAA)')),
// // // //         );
// // // //       }
// // // //       return;
// // // //     }
// // // //     try {
// // // //       await ApiService.updateUserProfile({apiKey: apiValue});
// // // //       final userData = await ApiService.getUserProfile();
// // // //       final updatedUser = UserModel.fromMap(userData);
// // // //       if (updatedUser.id != _currentUser!.id) {
// // // //         throw Exception('ID utilisateur incohérent dans la réponse');
// // // //       }
// // // //       await AuthService.saveUser(updatedUser);
// // // //       if (mounted) {
// // // //         setState(() {
// // // //           _currentUser = updatedUser;
// // // //         });
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           const SnackBar(content: Text('Mise à jour réussie')),
// // // //         );
// // // //       }
// // // //     } catch (e) {
// // // //       if (mounted) {
// // // //         ScaffoldMessenger.of(context).showSnackBar(
// // // //           SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
// // // //         );
// // // //       }
// // // //     }
// // // //   }

// // // //   bool _validateField(String key, String value) {
// // // //     switch (key) {
// // // //       case 'email':
// // // //         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
// // // //       case 'phone':
// // // //         return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);
// // // //       case 'birthdate':
// // // //         try {
// // // //           final parts = value.split('/');
// // // //           if (parts.length != 3) return false;
// // // //           final day = int.parse(parts[0]);
// // // //           final month = int.parse(parts[1]);
// // // //           final year = int.parse(parts[2]);
// // // //           final date = DateTime(year, month, day);
// // // //           return date.isBefore(DateTime.now()) && year >= 1900;
// // // //         } catch (e) {
// // // //           return false;
// // // //         }
// // // //       case 'gender':
// // // //         return ['male', 'female', 'other'].contains(value.toLowerCase());
// // // //       case 'name':
// // // //         return value.trim().isNotEmpty && value.length <= 100;
// // // //       case 'address':
// // // //       case 'bloodType':
// // // //       case 'allergies':
// // // //       case 'emergencyContact':
// // // //         return value.trim().isNotEmpty;
// // // //       default:
// // // //         return true;
// // // //     }
// // // //   }

// // // //   String _getValidationErrorMessage(String key) {
// // // //     switch (key) {
// // // //       case 'email':
// // // //         return 'Veuillez entrer un email valide (ex: nom@domaine.com)';
// // // //       case 'phone':
// // // //         return 'Veuillez entrer un numéro de téléphone valide (ex: +22890123456)';
// // // //       case 'birthdate':
// // // //         return 'Veuillez entrer une date de naissance valide (ex: 15/03/1990)';
// // // //       case 'gender':
// // // //         return 'Veuillez sélectionner un genre valide';
// // // //       case 'name':
// // // //         return 'Veuillez entrer un nom valide (non vide, max 100 caractères)';
// // // //       case 'address':
// // // //       case 'bloodType':
// // // //       case 'allergies':
// // // //       case 'emergencyContact':
// // // //         return 'Ce champ ne peut pas être vide';
// // // //       default:
// // // //         return 'Valeur invalide';
// // // //     }
// // // //   }

// // // //   String _mapToApiKey(String key) {
// // // //     switch (key) {
// // // //       case 'name':
// // // //         return 'fullName';
// // // //       case 'phone':
// // // //         return 'phoneNumber';
// // // //       case 'birthdate':
// // // //         return 'dateOfBirth';
// // // //       default:
// // // //         return key;
// // // //     }
// // // //   }

// // // //   String _getFieldTitle(String field) {
// // // //     switch (field) {
// // // //       case 'name':
// // // //         return 'Nom complet';
// // // //       case 'birthdate':
// // // //         return 'Date de naissance';
// // // //       case 'email':
// // // //         return 'Email';
// // // //       case 'phone':
// // // //         return 'Téléphone';
// // // //       case 'gender':
// // // //         return 'Genre';
// // // //       case 'address':
// // // //         return 'Adresse';
// // // //       case 'bloodType':
// // // //         return 'Groupe sanguin';
// // // //       case 'allergies':
// // // //         return 'Allergies';
// // // //       case 'emergencyContact':
// // // //         return 'Contact d\'urgence';
// // // //       default:
// // // //         return field;
// // // //     }
// // // //   }

// // // //   Widget _buildProfileHeader() {
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
// // // //       decoration: BoxDecoration(
// // // //         color: AppColors.primary,
// // // //         borderRadius: const BorderRadius.only(
// // // //           bottomLeft: Radius.circular(30),
// // // //           bottomRight: Radius.circular(30),
// // // //         ),
// // // //       ),
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         crossAxisAlignment: CrossAxisAlignment.center,
// // // //         children: [
// // // //           Stack(
// // // //             alignment: Alignment.bottomRight,
// // // //             children: [
// // // //               CircleAvatar(
// // // //                 radius: 50,
// // // //                 child: ClipOval(
// // // //                   child: CachedNetworkImage(
// // // //                     imageUrl: _currentUser?.profilePhoto ?? 'https://via.placeholder.com/150',
// // // //                     width: 100,
// // // //                     height: 100,
// // // //                     fit: BoxFit.cover,
// // // //                     placeholder: (context, url) => const CircularProgressIndicator(),
// // // //                     errorWidget: (context, url, error) => const Icon(
// // // //                       Icons.error,
// // // //                       color: Colors.red,
// // // //                       size: 50,
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               GestureDetector(
// // // //                 onTap: _changeProfilePhoto,
// // // //                 child: Container(
// // // //                   padding: const EdgeInsets.all(8),
// // // //                   decoration: BoxDecoration(
// // // //                     color: Colors.white,
// // // //                     shape: BoxShape.circle,
// // // //                     boxShadow: [
// // // //                       BoxShadow(
// // // //                         color: Colors.black.withOpacity(0.2),
// // // //                         blurRadius: 4,
// // // //                         offset: const Offset(0, 2),
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                   child: const Icon(
// // // //                     Icons.camera_alt,
// // // //                     color: AppColors.primary,
// // // //                     size: 20,
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
         
         
         
// // // //           const SizedBox(height: 16),
// // // //           Text(
// // // //             _currentUser?.fullTitle ?? 'Utilisateur',
// // // //             style: const TextStyle(
// // // //               fontSize: 24,
// // // //               color: Colors.white,
// // // //               fontWeight: FontWeight.bold,
// // // //             ),
// // // //           ),
// // // //           Text(
// // // //             _currentUser?.email ?? '',
// // // //             style: const TextStyle(
// // // //               color: Colors.white70,
// // // //               fontSize: 16,
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildInfoCard(IconData icon, String field, String value) {
// // // //     return Card(
// // // //       elevation: 2,
// // // //       margin: const EdgeInsets.only(bottom: 12),
// // // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // // //       child: InkWell(
// // // //         onTap: () => _editField(context, field, value),
// // // //         borderRadius: BorderRadius.circular(15),
// // // //         child: Padding(
// // // //           padding: const EdgeInsets.all(16),
// // // //           child: Row(
// // // //             children: [
// // // //               Container(
// // // //                 padding: const EdgeInsets.all(10),
// // // //                 decoration: BoxDecoration(
// // // //                   color: AppColors.primary.withOpacity(0.1),
// // // //                   borderRadius: BorderRadius.circular(10),
// // // //                 ),
// // // //                 child: Icon(icon, color: AppColors.primary, size: 24),
// // // //               ),
// // // //               const SizedBox(width: 16),
// // // //               Expanded(
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     Text(
// // // //                       _getFieldTitle(field),
// // // //                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
// // // //                     ),
// // // //                     const SizedBox(height: 4),
// // // //                     Text(
// // // //                       value,
// // // //                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               Icon(
// // // //                 Icons.edit,
// // // //                 color: AppColors.primary.withOpacity(0.5),
// // // //                 size: 20,
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   void _generateQRCode(BuildContext context) {
// // // //     final qrData = [
// // // //       'Nom complet: ${_currentUser?.fullName ?? 'Non renseigné'}',
// // // //       'Email: ${_currentUser?.email ?? 'Non renseigné'}',
// // // //       'Téléphone: ${_currentUser?.phoneNumber ?? 'Non renseigné'}',
// // // //       'Date de naissance: ${_formatDateForDisplay(_currentUser?.dateOfBirth)}',
// // // //       'Genre: ${_currentUser?.gender ?? 'Non renseigné'}',
// // // //       'Adresse: ${_currentUser?.address ?? 'Non renseigné'}',
// // // //       'Groupe sanguin: ${_currentUser?.bloodType ?? 'Non renseigné'}',
// // // //       'Allergies: ${_currentUser?.allergies ?? 'Non renseigné'}',
// // // //       'Contact d\'urgence: ${_currentUser?.emergencyContact ?? 'Non renseigné'}',
// // // //     ].join('\n');
// // // //     showDialog(
// // // //       context: context,
// // // //       builder: (context) => AlertDialog(
// // // //         title: const Text('Code QR'),
// // // //         content: SizedBox(
// // // //           width: 200,
// // // //           height: 250,
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               WidgetsToImage(
// // // //                 controller: controller,
// // // //                 child: Container(
// // // //                   color: Colors.white,
// // // //                   child: QrImageView(
// // // //                     data: qrData,
// // // //                     version: QrVersions.auto,
// // // //                     size: 200.0,
// // // //                     gapless: false,
// // // //                     errorStateBuilder: (context, error) {
// // // //                       return const Center(child: Text('Erreur de génération du QR code'));
// // // //                     },
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //               const SizedBox(height: 10),
// // // //               const Text('Scannez ce code pour voir les informations.'),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //         actions: [
// // // //           TextButton(
// // // //             onPressed: () async {
// // // //               final bytes = await controller.capture();
// // // //               if (bytes != null) {
// // // //                 if (Platform.isAndroid) {
// // // //                   final status = await Permission.storage.request();
// // // //                   if (status.isDenied) {
// // // //                     ScaffoldMessenger.of(context).showSnackBar(
// // // //                       const SnackBar(content: Text('Permission de stockage refusée')),
// // // //                     );
// // // //                     return;
// // // //                   }
// // // //                 }
// // // //                 final directory = await getApplicationDocumentsDirectory();
// // // //                 final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
// // // //                 await file.writeAsBytes(bytes);
// // // //                 if (mounted) {
// // // //                   ScaffoldMessenger.of(context).showSnackBar(
// // // //                     SnackBar(content: Text('QR code enregistré dans ${file.path}')),
// // // //                   );
// // // //                 }
// // // //               }
// // // //             },
// // // //             child: const Text('Enregistrer'),
// // // //           ),
// // // //           TextButton(
// // // //             onPressed: () => Navigator.pop(context),
// // // //             child: const Text('Fermer'),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     if (_isLoading) {
// // // //       return Scaffold(
// // // //         appBar: AppBar(
// // // //           title: const Text('Mon Profil'),
// // // //           backgroundColor: AppColors.primary,
// // // //         ),
// // // //         body: const Center(child: CircularProgressIndicator()),
// // // //       );
// // // //     }
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.grey[50],
// // // //       appBar: AppBar(
// // // //         backgroundColor: AppColors.primary,
// // // //         elevation: 0,
// // // //         title: const Text(
// // // //           'Mon Profil',
// // // //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
// // // //         ),
// // // //         actions: [
// // // //           IconButton(
// // // //             icon: const Icon(Icons.logout, color: Colors.white),
// // // //             onPressed: () async {
// // // //               final confirm = await showDialog<bool>(
// // // //                 context: context,
// // // //                 builder: (context) => AlertDialog(
// // // //                   title: const Text('Déconnexion'),
// // // //                   content: const Text('Voulez-vous vraiment vous déconnecter ?'),
// // // //                   actions: [
// // // //                     TextButton(
// // // //                       onPressed: () => Navigator.pop(context, false),
// // // //                       child: const Text('Annuler'),
// // // //                     ),
// // // //                     TextButton(
// // // //                       onPressed: () => Navigator.pop(context, true),
// // // //                       child: const Text('Confirmer'),
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               );
// // // //               if (confirm == true) {
// // // //                 await AuthService.logout();
// // // //                 if (mounted) {
// // // //                   Navigator.pushReplacementNamed(context, '/signin');
// // // //                 }
// // // //               }
// // // //             },
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       body: SingleChildScrollView(
// // // //         child: Column(
// // // //           children: [
// // // //             _buildProfileHeader(),
// // // //             Padding(
// // // //               padding: const EdgeInsets.all(16),
// // // //               child: Column(
// // // //                 children: [
// // // //                   _buildInfoCard(Icons.person_outline, 'name', _currentUser?.fullName ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate', _formatDateForDisplay(_currentUser?.dateOfBirth) ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.email_outlined, 'email', _currentUser?.email ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.phone_outlined, 'phone', _currentUser?.phoneNumber ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.transgender, 'gender', _currentUser?.gender ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.location_on_outlined, 'address', _currentUser?.address ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _currentUser?.bloodType ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _currentUser?.allergies ?? 'Non renseigné'),
// // // //                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact', _currentUser?.emergencyContact ?? 'Non renseigné'),
// // // //                   const SizedBox(height: 20),
// // // //                   ElevatedButton.icon(
// // // //                     onPressed: () => _generateQRCode(context),
// // // //                     icon: const Icon(Icons.qr_code, color: Colors.white),
// // // //                     label: const Text('Générer le code QR', style: TextStyle(color: Colors.white)),
// // // //                     style: ElevatedButton.styleFrom(
// // // //                       backgroundColor: AppColors.primary,
// // // //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // // //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }






// // // import 'dart:io';
// // // import 'package:cached_network_image/cached_network_image.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:path_provider/path_provider.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // // import 'package:qr_flutter/qr_flutter.dart';
// // // import 'package:widgets_to_image/widgets_to_image.dart';
// // // import 'package:device_info_plus/device_info_plus.dart';
// // // import '../constants/app_colors.dart';
// // // import '../models/user_model.dart';
// // // import '../services/auth_service.dart';
// // // import '../services/api_service.dart';
// // // import 'signin_screen.dart';

// // // class ProfileScreen extends StatefulWidget {
// // //   const ProfileScreen({super.key});

// // //   @override
// // //   State<ProfileScreen> createState() => _ProfileScreenState();
// // // }

// // // class _ProfileScreenState extends State<ProfileScreen> {
// // //   UserModel? _currentUser;
// // //   bool _isLoading = true;
// // //   WidgetsToImageController controller = WidgetsToImageController();
// // //   final ImagePicker _picker = ImagePicker();

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _loadUserData();
// // //   }

// // //   Future<void> _loadUserData() async {
// // //     setState(() => _isLoading = true);
// // //     try {
// // //       _currentUser = await AuthService.getCurrentUser(forceRefresh: true);
// // //       if (_currentUser == null || _currentUser!.id.isEmpty) {
// // //         if (mounted) {
// // //           Navigator.pushReplacementNamed(context, '/signin');
// // //         }
// // //         return;
// // //       }
// // //       final userData = await ApiService.getUserProfile();
// // //       print('Profile Photo URL from API: ${userData['profilePhoto']}');
// // //       final updatedUser = UserModel.fromMap(userData);
// // //       if (updatedUser.id != _currentUser!.id) {
// // //         throw Exception('ID utilisateur incohérent dans la réponse');
// // //       }
// // //       await AuthService.saveUser(updatedUser);
// // //       if (mounted) {
// // //         setState(() {
// // //           _currentUser = updatedUser;
// // //           _isLoading = false;
// // //         });
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //         setState(() => _isLoading = false);
// // //       }
// // //     }
// // //   }

// // //   Future<bool> _checkAndRequestPermission(Permission permission) async {
// // //     final status = await permission.status;
// // //     print('Permission ${permission.toString()}: $status');
// // //     if (status.isGranted) {
// // //       return true;
// // //     }
// // //     if (status.isPermanentlyDenied) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(
// // //             content: const Text('Permission définitivement refusée. Veuillez l\'activer dans les paramètres.'),
// // //             action: SnackBarAction(
// // //               label: 'Paramètres',
// // //               onPressed: () => openAppSettings(),
// // //             ),
// // //           ),
// // //         );
// // //       }
// // //       return false;
// // //     }
// // //     final newStatus = await permission.request();
// // //     print('Requested ${permission.toString()}: $newStatus');
// // //     return newStatus.isGranted;
// // //   }

// // //   Future<bool> _requestPermissions() async {
// // //     if (Platform.isIOS || Platform.isAndroid) {
// // //       final permissions = [Permission.camera];

// // //       // Ajouter la permission appropriée pour l'accès aux photos
// // //       if (Platform.isAndroid) {
// // //         final androidVersion = await _getAndroidVersion();
// // //         if (androidVersion >= 33) {
// // //           permissions.add(Permission.photos);
// // //         } else {
// // //           permissions.add(Permission.storage);
// // //         }
// // //       } else if (Platform.isIOS) {
// // //         permissions.add(Permission.photos);
// // //       }

// // //       // Demander toutes les permissions en une seule fois
// // //       final statuses = await permissions.request();

// // //       // Vérifier si toutes les permissions sont accordées
// // //       final allGranted = statuses.values.every((status) => status.isGranted);

// // //       if (!allGranted) {
// // //         for (var entry in statuses.entries) {
// // //           if (!entry.value.isGranted) {
// // //             if (entry.value.isPermanentlyDenied && mounted) {
// // //               ScaffoldMessenger.of(context).showSnackBar(
// // //                 SnackBar(
// // //                   content: Text(
// // //                     'Permission ${entry.key} refusée définitivement. Veuillez l\'activer dans les paramètres.',
// // //                   ),
// // //                   action: SnackBarAction(
// // //                     label: 'Paramètres',
// // //                     onPressed: () => openAppSettings(),
// // //                   ),
// // //                 ),
// // //               );
// // //             }
// // //           }
// // //         }
// // //       }

// // //       return allGranted;
// // //     }
// // //     return true; // Pas de permissions nécessaires sur d'autres plateformes
// // //   }

// // //   Future<int> _getAndroidVersion() async {
// // //     if (Platform.isAndroid) {
// // //       final deviceInfo = DeviceInfoPlugin();
// // //       final androidInfo = await deviceInfo.androidInfo;
// // //       return androidInfo.version.sdkInt;
// // //     }
// // //     return 0;
// // //   }

// // //   Future<void> _changeProfilePhoto() async {
// // //     try {
// // //       // Vérifier les permissions avant de continuer
// // //       final permissionsGranted = await _requestPermissions();
// // //       if (!permissionsGranted) {
// // //         if (mounted) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             const SnackBar(content: Text('Les permissions nécessaires ne sont pas accordées.')),
// // //           );
// // //         }
// // //         return;
// // //       }

// // //       final source = await showDialog<ImageSource>(
// // //         context: context,
// // //         builder: (context) => AlertDialog(
// // //           title: const Text('Changer la photo de profil'),
// // //           content: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               ListTile(
// // //                 leading: const Icon(Icons.camera_alt),
// // //                 title: const Text('Prendre une photo'),
// // //                 onTap: () => Navigator.pop(context, ImageSource.camera),
// // //               ),
// // //               ListTile(
// // //                 leading: const Icon(Icons.photo_library),
// // //                 title: const Text('Choisir dans la galerie'),
// // //                 onTap: () => Navigator.pop(context, ImageSource.gallery),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       );

// // //       if (source == null) return;

// // //       final XFile? pickedFile = await _picker.pickImage(
// // //         source: source,
// // //         maxWidth: 512,
// // //         maxHeight: 512,
// // //         imageQuality: 85,
// // //       ).catchError((e) {
// // //         if (mounted) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             SnackBar(content: Text('Erreur lors de la sélection de l\'image: $e')),
// // //           );
// // //         }
// // //         return null;
// // //       });

// // //       if (pickedFile == null) return;

// // //       setState(() => _isLoading = true);

// // //       final imageUrl = await ApiService.uploadProfilePhoto(File(pickedFile.path));

// // //       if (imageUrl != null) {
// // //         await ApiService.updateUserProfile({'profilePhoto': imageUrl});
// // //         await _loadUserData();

// // //         if (mounted) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             const SnackBar(content: Text('Photo de profil mise à jour')),
// // //           );
// // //         }
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //       }
// // //     } finally {
// // //       setState(() => _isLoading = false);
// // //     }
// // //   }

// // //   String? _formatDateForDisplay(String? date) {
// // //     if (date == null) return 'Non renseigné';
// // //     try {
// // //       final dateTime = DateTime.parse(date);
// // //       return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
// // //     } catch (e) {
// // //       return date;
// // //     }
// // //   }

// // //   String? _formatDateForApi(String date) {
// // //     try {
// // //       final parts = date.split('/');
// // //       if (parts.length != 3) return null;
// // //       final day = parts[0];
// // //       final month = parts[1];
// // //       final year = parts[2];
// // //       return '$year-$month-$day';
// // //     } catch (e) {
// // //       return null;
// // //     }
// // //   }

// // //   Future<void> _editField(BuildContext context, String field, String currentValue) async {
// // //     if (field == 'birthdate') {
// // //       DateTime initialDate;
// // //       try {
// // //         final parts = currentValue.split('/');
// // //         if (parts.length == 3) {
// // //           initialDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
// // //         } else {
// // //           initialDate = DateTime.now();
// // //         }
// // //       } catch (e) {
// // //         initialDate = DateTime.now();
// // //       }
// // //       final selectedDate = await showDatePicker(
// // //         context: context,
// // //         initialDate: initialDate,
// // //         firstDate: DateTime(1900),
// // //         lastDate: DateTime.now(),
// // //       );
// // //       if (selectedDate != null) {
// // //         final formattedDate =
// // //             '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
// // //         await _saveUserData(field, formattedDate);
// // //       }
// // //       return;
// // //     }
// // //     final controller = TextEditingController(text: currentValue.replaceAll('Non renseigné', ''));
// // //     if (field == 'gender') {
// // //       String? result = await showDialog<String>(
// // //         context: context,
// // //         builder: (context) => AlertDialog(
// // //           title: Text('Modifier ${_getFieldTitle(field)}'),
// // //           content: DropdownButtonFormField<String>(
// // //             value: _currentUser?.gender ?? 'other',
// // //             decoration: const InputDecoration(labelText: 'Genre'),
// // //             items: ['male', 'female', 'other']
// // //                 .map((gender) => DropdownMenuItem(
// // //                       value: gender,
// // //                       child: Text(gender == 'male' ? 'Homme' : gender == 'female' ? 'Femme' : 'Autre'),
// // //                     ))
// // //                 .toList(),
// // //             onChanged: (value) {
// // //               if (value != null) {
// // //                 controller.text = value;
// // //                 setState(() {}); // Mise à jour de l'UI si nécessaire
// // //               }
// // //             },
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () => Navigator.pop(context),
// // //               child: const Text('Annuler'),
// // //             ),
// // //             TextButton(
// // //               onPressed: () => Navigator.pop(context, controller.text),
// // //               child: const Text('Sauvegarder'),
// // //             ),
// // //           ],
// // //         ),
// // //       );
// // //       if (result != null && result.isNotEmpty) {
// // //         await _saveUserData(field, result);
// // //       }
// // //       return;
// // //     }
// // //     String? result = await showDialog<String>(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: Text('Modifier ${_getFieldTitle(field)}'),
// // //         content: TextField(
// // //           controller: controller,
// // //           decoration: InputDecoration(
// // //             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
// // //             errorText: _validateField(field, controller.text) ? null : _getValidationErrorMessage(field),
// // //           ),
// // //           onChanged: (value) {
// // //             setState(() {});
// // //           },
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context),
// // //             child: const Text('Annuler'),
// // //           ),
// // //           TextButton(
// // //             onPressed: () {
// // //               if (_validateField(field, controller.text)) {
// // //                 Navigator.pop(context, controller.text);
// // //               } else {
// // //                 ScaffoldMessenger.of(context).showSnackBar(
// // //                   SnackBar(content: Text(_getValidationErrorMessage(field))),
// // //                 );
// // //               }
// // //             },
// // //             child: const Text('Sauvegarder'),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //     if (result != null && result.isNotEmpty) {
// // //       await _saveUserData(field, result);
// // //     }
// // //   }

// // //   Future<void> _saveUserData(String field, String value) async {
// // //     if (!_validateField(field, value)) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text(_getValidationErrorMessage(field))),
// // //         );
// // //       }
// // //       return;
// // //     }
// // //     final apiKey = _mapToApiKey(field);
// // //     final apiValue = field == 'birthdate' ? _formatDateForApi(value) : value;
// // //     if (apiValue == null && field == 'birthdate') {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Format de date invalide (attendu: JJ/MM/AAAA)')),
// // //         );
// // //       }
// // //       return;
// // //     }
// // //     try {
// // //       await ApiService.updateUserProfile({apiKey: apiValue});
// // //       final userData = await ApiService.getUserProfile();
// // //       final updatedUser = UserModel.fromMap(userData);
// // //       if (updatedUser.id != _currentUser!.id) {
// // //         throw Exception('ID utilisateur incohérent dans la réponse');
// // //       }
// // //       await AuthService.saveUser(updatedUser);
// // //       if (mounted) {
// // //         setState(() {
// // //           _currentUser = updatedUser;
// // //         });
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Mise à jour réussie')),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   bool _validateField(String key, String value) {
// // //     switch (key) {
// // //       case 'email':
// // //         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
// // //       case 'phone':
// // //         return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);
// // //       case 'birthdate':
// // //         try {
// // //           final parts = value.split('/');
// // //           if (parts.length != 3) return false;
// // //           final day = int.parse(parts[0]);
// // //           final month = int.parse(parts[1]);
// // //           final year = int.parse(parts[2]);
// // //           final date = DateTime(year, month, day);
// // //           return date.isBefore(DateTime.now()) && year >= 1900;
// // //         } catch (e) {
// // //           return false;
// // //         }
// // //       case 'gender':
// // //         return ['male', 'female', 'other'].contains(value.toLowerCase());
// // //       case 'name':
// // //         return value.trim().isNotEmpty && value.length <= 100;
// // //       case 'address':
// // //       case 'bloodType':
// // //       case 'allergies':
// // //       case 'emergencyContact':
// // //         return value.trim().isNotEmpty;
// // //       default:
// // //         return true;
// // //     }
// // //   }

// // //   String _getValidationErrorMessage(String key) {
// // //     switch (key) {
// // //       case 'email':
// // //         return 'Veuillez entrer un email valide (ex: nom@domaine.com)';
// // //       case 'phone':
// // //         return 'Veuillez entrer un numéro de téléphone valide (ex: +22890123456)';
// // //       case 'birthdate':
// // //         return 'Veuillez entrer une date de naissance valide (ex: 15/03/1990)';
// // //       case 'gender':
// // //         return 'Veuillez sélectionner un genre valide';
// // //       case 'name':
// // //         return 'Veuillez entrer un nom valide (non vide, max 100 caractères)';
// // //       case 'address':
// // //       case 'bloodType':
// // //       case 'allergies':
// // //       case 'emergencyContact':
// // //         return 'Ce champ ne peut pas être vide';
// // //       default:
// // //         return 'Valeur invalide';
// // //     }
// // //   }

// // //   String _mapToApiKey(String key) {
// // //     switch (key) {
// // //       case 'name':
// // //         return 'fullName';
// // //       case 'phone':
// // //         return 'phoneNumber';
// // //       case 'birthdate':
// // //         return 'dateOfBirth';
// // //       default:
// // //         return key;
// // //     }
// // //   }

// // //   String _getFieldTitle(String field) {
// // //     switch (field) {
// // //       case 'name':
// // //         return 'Nom complet';
// // //       case 'birthdate':
// // //         return 'Date de naissance';
// // //       case 'email':
// // //         return 'Email';
// // //       case 'phone':
// // //         return 'Téléphone';
// // //       case 'gender':
// // //         return 'Genre';
// // //       case 'address':
// // //         return 'Adresse';
// // //       case 'bloodType':
// // //         return 'Groupe sanguin';
// // //       case 'allergies':
// // //         return 'Allergies';
// // //       case 'emergencyContact':
// // //         return 'Contact d\'urgence';
// // //       default:
// // //         return field;
// // //     }
// // //   }

// // //   Widget _buildProfileHeader() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
// // //       decoration: BoxDecoration(
// // //         color: AppColors.primary,
// // //         borderRadius: const BorderRadius.only(
// // //           bottomLeft: Radius.circular(30),
// // //           bottomRight: Radius.circular(30),
// // //         ),
// // //       ),
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         crossAxisAlignment: CrossAxisAlignment.center,
// // //         children: [
// // //           Stack(
// // //             alignment: Alignment.bottomRight,
// // //             children: [
// // //               CircleAvatar(
// // //                 radius: 50,
// // //                 child: ClipOval(
// // //                   child: CachedNetworkImage(
// // //                     imageUrl: _currentUser?.profilePhoto ?? 'https://via.placeholder.com/150',
// // //                     width: 100,
// // //                     height: 100,
// // //                     fit: BoxFit.cover,
// // //                     placeholder: (context, url) => const CircularProgressIndicator(),
// // //                     errorWidget: (context, url, error) => const Icon(
// // //                       Icons.error,
// // //                       color: Colors.red,
// // //                       size: 50,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //               GestureDetector(
// // //                 onTap: _changeProfilePhoto,
// // //                 child: Container(
// // //                   padding: const EdgeInsets.all(8),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white,
// // //                     shape: BoxShape.circle,
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black.withOpacity(0.2),
// // //                         blurRadius: 4,
// // //                         offset: const Offset(0, 2),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: const Icon(
// // //                     Icons.camera_alt,
// // //                     color: AppColors.primary,
// // //                     size: 20,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Text(
// // //             _currentUser?.fullTitle ?? 'Utilisateur',
// // //             style: const TextStyle(
// // //               fontSize: 24,
// // //               color: Colors.white,
// // //               fontWeight: FontWeight.bold,
// // //             ),
// // //           ),
// // //           Text(
// // //             _currentUser?.email ?? '',
// // //             style: const TextStyle(
// // //               color: Colors.white70,
// // //               fontSize: 16,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildInfoCard(IconData icon, String field, String value) {
// // //     return Card(
// // //       elevation: 2,
// // //       margin: const EdgeInsets.only(bottom: 12),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // //       child: InkWell(
// // //         onTap: () => _editField(context, field, value),
// // //         borderRadius: BorderRadius.circular(15),
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16),
// // //           child: Row(
// // //             children: [
// // //               Container(
// // //                 padding: const EdgeInsets.all(10),
// // //                 decoration: BoxDecoration(
// // //                   color: AppColors.primary.withOpacity(0.1),
// // //                   borderRadius: BorderRadius.circular(10),
// // //                 ),
// // //                 child: Icon(icon, color: AppColors.primary, size: 24),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       _getFieldTitle(field),
// // //                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Text(
// // //                       value,
// // //                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               Icon(
// // //                 Icons.edit,
// // //                 color: AppColors.primary.withOpacity(0.5),
// // //                 size: 20,
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _generateQRCode(BuildContext context) {
// // //     final qrData = [
// // //       'Nom complet: ${_currentUser?.fullName ?? 'Non renseigné'}',
// // //       'Email: ${_currentUser?.email ?? 'Non renseigné'}',
// // //       'Téléphone: ${_currentUser?.phoneNumber ?? 'Non renseigné'}',
// // //       'Date de naissance: ${_formatDateForDisplay(_currentUser?.dateOfBirth)}',
// // //       'Genre: ${_currentUser?.gender ?? 'Non renseigné'}',
// // //       'Adresse: ${_currentUser?.address ?? 'Non renseigné'}',
// // //       'Groupe sanguin: ${_currentUser?.bloodType ?? 'Non renseigné'}',
// // //       'Allergies: ${_currentUser?.allergies ?? 'Non renseigné'}',
// // //       'Contact d\'urgence: ${_currentUser?.emergencyContact ?? 'Non renseigné'}',
// // //     ].join('\n');
// // //     showDialog(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: const Text('Code QR'),
// // //         content: SizedBox(
// // //           width: 200,
// // //           height: 250,
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               WidgetsToImage(
// // //                 controller: controller,
// // //                 child: Container(
// // //                   color: Colors.white,
// // //                   child: QrImageView(
// // //                     data: qrData,
// // //                     version: QrVersions.auto,
// // //                     size: 200.0,
// // //                     gapless: false,
// // //                     errorStateBuilder: (context, error) {
// // //                       return const Center(child: Text('Erreur de génération du QR code'));
// // //                     },
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 10),
// // //               const Text('Scannez ce code pour voir les informations.'),
// // //             ],
// // //           ),
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () async {
// // //               final bytes = await controller.capture();
// // //               if (bytes != null) {
// // //                 final directory = await getApplicationDocumentsDirectory();
// // //                 final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
// // //                 await file.writeAsBytes(bytes);
// // //                 if (mounted) {
// // //                   ScaffoldMessenger.of(context).showSnackBar(
// // //                     SnackBar(content: Text('QR code enregistré dans ${file.path}')),
// // //                   );
// // //                 }
// // //               }
// // //             },
// // //             child: const Text('Enregistrer'),
// // //           ),
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context),
// // //             child: const Text('Fermer'),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (_isLoading) {
// // //       return Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text('Mon Profil'),
// // //           backgroundColor: AppColors.primary,
// // //         ),
// // //         body: const Center(child: CircularProgressIndicator()),
// // //       );
// // //     }
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[50],
// // //       appBar: AppBar(
// // //         backgroundColor: AppColors.primary,
// // //         elevation: 0,
// // //         title: const Text(
// // //           'Mon Profil',
// // //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
// // //         ),
// // //         actions: [
// // //           IconButton(
// // //             icon: const Icon(Icons.logout, color: Colors.white),
// // //             onPressed: () async {
// // //               final confirm = await showDialog<bool>(
// // //                 context: context,
// // //                 builder: (context) => AlertDialog(
// // //                   title: const Text('Déconnexion'),
// // //                   content: const Text('Voulez-vous vraiment vous déconnecter ?'),
// // //                   actions: [
// // //                     TextButton(
// // //                       onPressed: () => Navigator.pop(context, false),
// // //                       child: const Text('Annuler'),
// // //                     ),
// // //                     TextButton(
// // //                       onPressed: () => Navigator.pop(context, true),
// // //                       child: const Text('Confirmer'),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               );
// // //               if (confirm == true) {
// // //                 await AuthService.logout();
// // //                 if (mounted) {
// // //                   Navigator.pushReplacementNamed(context, '/signin');
// // //                 }
// // //               }
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Column(
// // //           children: [
// // //             _buildProfileHeader(),
// // //             Padding(
// // //               padding: const EdgeInsets.all(16),
// // //               child: Column(
// // //                 children: [
// // //                   _buildInfoCard(Icons.person_outline, 'name', _currentUser?.fullName ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate',
// // //                       _formatDateForDisplay(_currentUser?.dateOfBirth) ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.email_outlined, 'email', _currentUser?.email ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.phone_outlined, 'phone', _currentUser?.phoneNumber ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.transgender, 'gender', _currentUser?.gender ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.location_on_outlined, 'address', _currentUser?.address ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _currentUser?.bloodType ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _currentUser?.allergies ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact',
// // //                       _currentUser?.emergencyContact ?? 'Non renseigné'),
// // //                   const SizedBox(height: 20),
// // //                   ElevatedButton.icon(
// // //                     onPressed: () => _generateQRCode(context),
// // //                     icon: const Icon(Icons.qr_code, color: Colors.white),
// // //                     label: const Text('Générer le code QR', style: TextStyle(color: Colors.white)),
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: AppColors.primary,
// // //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }



// // // import 'dart:io';
// // // import 'package:cached_network_image/cached_network_image.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:path_provider/path_provider.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // // import 'package:qr_flutter/qr_flutter.dart';
// // // import 'package:widgets_to_image/widgets_to_image.dart';
// // // import 'package:device_info_plus/device_info_plus.dart';
// // // import 'package:image/image.dart' as img;
// // // import '../constants/app_colors.dart';
// // // import '../models/user_model.dart';
// // // import '../services/auth_service.dart';
// // // import '../services/api_service.dart';

// // // class ProfileScreen extends StatefulWidget {
// // //   const ProfileScreen({super.key});

// // //   @override
// // //   State<ProfileScreen> createState() => _ProfileScreenState();
// // // }

// // // class _ProfileScreenState extends State<ProfileScreen> {
// // //   UserModel? _currentUser;
// // //   bool _isLoading = false;
// // //   WidgetsToImageController controller = WidgetsToImageController();
// // //   final ImagePicker _picker = ImagePicker();
// // //   File? _selectedImage;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _loadUserData();
// // //   }

// // //   Future<void> _loadUserData() async {
// // //     setState(() => _isLoading = true);
// // //     try {
// // //       _currentUser = await AuthService.getCurrentUser(forceRefresh: true);
// // //       if (_currentUser == null || _currentUser!.id.isEmpty) {
// // //         if (mounted) {
// // //           Navigator.pushReplacementNamed(context, '/signin');
// // //         }
// // //         return;
// // //       }
// // //       final userData = await ApiService.getUserProfile();
// // //       print('Profile Photo URL from API: ${userData['profilePhoto']}');
// // //       final updatedUser = UserModel.fromMap(userData);
// // //       if (updatedUser.id != _currentUser!.id) {
// // //         throw Exception('ID utilisateur incohérent dans la réponse');
// // //       }
// // //       await AuthService.saveUser(updatedUser);
// // //       if (mounted) {
// // //         setState(() {
// // //           _currentUser = updatedUser;
// // //           _isLoading = false;
// // //         });
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //         setState(() => _isLoading = false);
// // //       }
// // //     }
// // //   }

// // //   Future<bool> _requestPermissions() async {
// // //     if (Platform.isIOS || Platform.isAndroid) {
// // //       final permissions = [Permission.camera, Permission.photos];

// // //       if (Platform.isAndroid) {
// // //         final androidVersion = await _getAndroidVersion();
// // //         if (androidVersion < 33) {
// // //           permissions.add(Permission.storage);
// // //         }
// // //       }

// // //       final statuses = await permissions.request();
// // //       final allGranted = statuses.values.every((status) => status.isGranted);

// // //       if (!allGranted) {
// // //         for (var entry in statuses.entries) {
// // //           if (!entry.value.isGranted && entry.value.isPermanentlyDenied && mounted) {
// // //             ScaffoldMessenger.of(context).showSnackBar(
// // //               SnackBar(
// // //                 content: Text(
// // //                   'Permission ${entry.key} refusée définitivement. Veuillez l\'activer dans les paramètres.',
// // //                 ),
// // //                 action: SnackBarAction(
// // //                   label: 'Paramètres',
// // //                   onPressed: () => openAppSettings(),
// // //                 ),
// // //               ),
// // //             );
// // //           }
// // //         }
// // //       }

// // //       return allGranted;
// // //     }
// // //     return true;
// // //   }

// // //   Future<int> _getAndroidVersion() async {
// // //     if (Platform.isAndroid) {
// // //       final deviceInfo = DeviceInfoPlugin();
// // //       final androidInfo = await deviceInfo.androidInfo;
// // //       return androidInfo.version.sdkInt;
// // //     }
// // //     return 0;
// // //   }

// // //   Future<File> convertToJpeg(File image) async {
// // //     final rawImage = await image.readAsBytes();
// // //     final decodedImage = img.decodeImage(rawImage);
// // //     if (decodedImage == null) throw Exception('Impossible de décoder l\'image');
// // //     final jpegImage = img.encodeJpg(decodedImage, quality: 85);
// // //     final tempDir = await getTemporaryDirectory();
// // //     final tempFile = File('${tempDir.path}/profile_photo.jpg');
// // //     await tempFile.writeAsBytes(jpegImage);
// // //     return tempFile;
// // //   }

// // //   Future<void> _pickImage() async {
// // //     try {
// // //       final permissionsGranted = await _requestPermissions();
// // //       if (!permissionsGranted) {
// // //         if (mounted) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             const SnackBar(content: Text('Les permissions nécessaires ne sont pas accordées.')),
// // //           );
// // //         }
// // //         return;
// // //       }

// // //       final source = await showDialog<ImageSource>(
// // //         context: context,
// // //         builder: (context) => AlertDialog(
// // //           title: const Text('Changer la photo de profil'),
// // //           content: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               ListTile(
// // //                 leading: const Icon(Icons.camera_alt),
// // //                 title: const Text('Prendre une photo'),
// // //                 onTap: () => Navigator.pop(context, ImageSource.camera),
// // //               ),
// // //               ListTile(
// // //                 leading: const Icon(Icons.photo_library),
// // //                 title: const Text('Choisir dans la galerie'),
// // //                 onTap: () => Navigator.pop(context, ImageSource.gallery),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       );

// // //       if (source == null) return;

// // //       final XFile? pickedFile = await _picker.pickImage(
// // //         source: source,
// // //         maxWidth: 800,
// // //         maxHeight: 800,
// // //         imageQuality: 85,
// // //       ).catchError((e) {
// // //         if (mounted) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             SnackBar(content: Text('Erreur lors de la sélection de l\'image: $e')),
// // //           );
// // //         }
// // //         return null;
// // //       });

// // //       if (pickedFile == null) return;

// // //       setState(() {
// // //         _selectedImage = File(pickedFile.path);
// // //       });
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   Future<void> _uploadProfilePhoto() async {
// // //     if (_selectedImage == null) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Veuillez sélectionner une image.')),
// // //         );
// // //       }
// // //       return;
// // //     }

// // //     setState(() => _isLoading = true);

// // //     try {
// // //       File imageToUpload = _selectedImage!;
// // //       if (_selectedImage!.path.endsWith('.png')) {
// // //         imageToUpload = await convertToJpeg(_selectedImage!);
// // //       }

// // //       final fileSize = await imageToUpload.length();
// // //       if (fileSize > 5 * 1024 * 1024) {
// // //         throw Exception('L\'image est trop volumineuse (max 5 Mo)');
// // //       }

// // //       final imageUrl = await ApiService.uploadProfilePhoto(imageToUpload);

// // //       if (imageUrl != null) {
// // //         await ApiService.updateUserProfile({'profilePhoto': imageUrl});
// // //         await _loadUserData();
// // //         if (mounted) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             const SnackBar(content: Text('Photo de profil mise à jour')),
// // //           );
// // //           setState(() {
// // //             _selectedImage = null;
// // //           });
// // //         }
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //       }
// // //     } finally {
// // //       setState(() => _isLoading = false);
// // //     }
// // //   }

// // //   String? _formatDateForDisplay(String? date) {
// // //     if (date == null) return 'Non renseigné';
// // //     try {
// // //       final dateTime = DateTime.parse(date);
// // //       return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
// // //     } catch (e) {
// // //       return date;
// // //     }
// // //   }

// // //   String? _formatDateForApi(String date) {
// // //     try {
// // //       final parts = date.split('/');
// // //       if (parts.length != 3) return null;
// // //       final day = parts[0];
// // //       final month = parts[1];
// // //       final year = parts[2];
// // //       return '$year-$month-$day';
// // //     } catch (e) {
// // //       return null;
// // //     }
// // //   }

// // //   Future<void> _editField(BuildContext context, String field, String currentValue) async {
// // //     if (field == 'birthdate') {
// // //       DateTime initialDate;
// // //       try {
// // //         final parts = currentValue.split('/');
// // //         if (parts.length == 3) {
// // //           initialDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
// // //         } else {
// // //           initialDate = DateTime.now();
// // //         }
// // //       } catch (e) {
// // //         initialDate = DateTime.now();
// // //       }
// // //       final selectedDate = await showDatePicker(
// // //         context: context,
// // //         initialDate: initialDate,
// // //         firstDate: DateTime(1900),
// // //         lastDate: DateTime.now(),
// // //       );
// // //       if (selectedDate != null) {
// // //         final formattedDate =
// // //             '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
// // //         await _saveUserData(field, formattedDate);
// // //       }
// // //       return;
// // //     }
// // //     final controller = TextEditingController(text: currentValue.replaceAll('Non renseigné', ''));
// // //     if (field == 'gender') {
// // //       String? result = await showDialog<String>(
// // //         context: context,
// // //         builder: (context) => AlertDialog(
// // //           title: Text('Modifier ${_getFieldTitle(field)}'),
// // //           content: DropdownButtonFormField<String>(
// // //             value: _currentUser?.gender ?? 'other',
// // //             decoration: const InputDecoration(labelText: 'Genre'),
// // //             items: ['male', 'female', 'other']
// // //                 .map((gender) => DropdownMenuItem(
// // //                       value: gender,
// // //                       child: Text(gender == 'male' ? 'Homme' : gender == 'female' ? 'Femme' : 'Autre'),
// // //                     ))
// // //                 .toList(),
// // //             onChanged: (value) {
// // //               if (value != null) {
// // //                 controller.text = value;
// // //                 setState(() {});
// // //               }
// // //             },
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () => Navigator.pop(context),
// // //               child: const Text('Annuler'),
// // //             ),
// // //             TextButton(
// // //               onPressed: () => Navigator.pop(context, controller.text),
// // //               child: const Text('Sauvegarder'),
// // //             ),
// // //           ],
// // //         ),
// // //       );
// // //       if (result != null && result.isNotEmpty) {
// // //         await _saveUserData(field, result);
// // //       }
// // //       return;
// // //     }
// // //     String? result = await showDialog<String>(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: Text('Modifier ${_getFieldTitle(field)}'),
// // //         content: TextField(
// // //           controller: controller,
// // //           decoration: InputDecoration(
// // //             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
// // //             errorText: _validateField(field, controller.text) ? null : _getValidationErrorMessage(field),
// // //           ),
// // //           onChanged: (value) {
// // //             setState(() {});
// // //           },
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context),
// // //             child: const Text('Annuler'),
// // //           ),
// // //           TextButton(
// // //             onPressed: () {
// // //               if (_validateField(field, controller.text)) {
// // //                 Navigator.pop(context, controller.text);
// // //               } else {
// // //                 ScaffoldMessenger.of(context).showSnackBar(
// // //                   SnackBar(content: Text(_getValidationErrorMessage(field))),
// // //                 );
// // //               }
// // //             },
// // //             child: const Text('Sauvegarder'),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //     if (result != null && result.isNotEmpty) {
// // //       await _saveUserData(field, result);
// // //     }
// // //   }

// // //   Future<void> _saveUserData(String field, String value) async {
// // //     if (!_validateField(field, value)) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text(_getValidationErrorMessage(field))),
// // //         );
// // //       }
// // //       return;
// // //     }
// // //     final apiKey = _mapToApiKey(field);
// // //     final apiValue = field == 'birthdate' ? _formatDateForApi(value) : value;
// // //     if (apiValue == null && field == 'birthdate') {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Format de date invalide (attendu: JJ/MM/AAAA)')),
// // //         );
// // //       }
// // //       return;
// // //     }
// // //     try {
// // //       await ApiService.updateUserProfile({apiKey: apiValue});
// // //       final userData = await ApiService.getUserProfile();
// // //       final updatedUser = UserModel.fromMap(userData);
// // //       if (updatedUser.id != _currentUser!.id) {
// // //         throw Exception('ID utilisateur incohérent dans la réponse');
// // //       }
// // //       await AuthService.saveUser(updatedUser);
// // //       if (mounted) {
// // //         setState(() {
// // //           _currentUser = updatedUser;
// // //         });
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Mise à jour réussie')),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   bool _validateField(String key, String value) {
// // //     switch (key) {
// // //       case 'email':
// // //         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
// // //       case 'phone':
// // //         return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);
// // //       case 'birthdate':
// // //         try {
// // //           final parts = value.split('/');
// // //           if (parts.length != 3) return false;
// // //           final day = int.parse(parts[0]);
// // //           final month = int.parse(parts[1]);
// // //           final year = int.parse(parts[2]);
// // //           final date = DateTime(year, month, day);
// // //           return date.isBefore(DateTime.now()) && year >= 1900;
// // //         } catch (e) {
// // //           return false;
// // //         }
// // //       case 'gender':
// // //         return ['male', 'female', 'other'].contains(value.toLowerCase());
// // //       case 'name':
// // //         return value.trim().isNotEmpty && value.length <= 100;
// // //       case 'address':
// // //       case 'bloodType':
// // //       case 'allergies':
// // //       case 'emergencyContact':
// // //         return value.trim().isNotEmpty;
// // //       default:
// // //         return true;
// // //     }
// // //   }

// // //   String _getValidationErrorMessage(String key) {
// // //     switch (key) {
// // //       case 'email':
// // //         return 'Veuillez entrer un email valide (ex: nom@domaine.com)';
// // //       case 'phone':
// // //         return 'Veuillez entrer un numéro de téléphone valide (ex: +22890123456)';
// // //       case 'birthdate':
// // //         return 'Veuillez entrer une date de naissance valide (ex: 15/03/1990)';
// // //       case 'gender':
// // //         return 'Veuillez sélectionner un genre valide';
// // //       case 'name':
// // //         return 'Veuillez entrer un nom valide (non vide, max 100 caractères)';
// // //       case 'address':
// // //       case 'bloodType':
// // //       case 'allergies':
// // //       case 'emergencyContact':
// // //         return 'Ce champ ne peut pas être vide';
// // //       default:
// // //         return 'Valeur invalide';
// // //     }
// // //   }

// // //   String _mapToApiKey(String key) {
// // //     switch (key) {
// // //       case 'name':
// // //         return 'fullName';
// // //       case 'phone':
// // //         return 'phoneNumber';
// // //       case 'birthdate':
// // //         return 'dateOfBirth';
// // //       default:
// // //         return key;
// // //     }
// // //   }

// // //   String _getFieldTitle(String field) {
// // //     switch (field) {
// // //       case 'name':
// // //         return 'Nom complet';
// // //       case 'birthdate':
// // //         return 'Date de naissance';
// // //       case 'email':
// // //         return 'Email';
// // //       case 'phone':
// // //         return 'Téléphone';
// // //       case 'gender':
// // //         return 'Genre';
// // //       case 'address':
// // //         return 'Adresse';
// // //       case 'bloodType':
// // //         return 'Groupe sanguin';
// // //       case 'allergies':
// // //         return 'Allergies';
// // //       case 'emergencyContact':
// // //         return 'Contact d\'urgence';
// // //       default:
// // //         return field;
// // //     }
// // //   }

// // //   Widget _buildProfileHeader() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
// // //       decoration: BoxDecoration(
// // //         color: AppColors.primary,
// // //         borderRadius: const BorderRadius.only(
// // //           bottomLeft: Radius.circular(30),
// // //           bottomRight: Radius.circular(30),
// // //         ),
// // //       ),
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         crossAxisAlignment: CrossAxisAlignment.center,
// // //         children: [
// // //           Stack(
// // //             alignment: Alignment.bottomRight,
// // //             children: [
// // //               CircleAvatar(
// // //                 radius: 50,
// // //                 child: ClipOval(
// // //                   child: _selectedImage != null
// // //                       ? Image.file(
// // //                           _selectedImage!,
// // //                           width: 100,
// // //                           height: 100,
// // //                           fit: BoxFit.cover,
// // //                         )
// // //                       : CachedNetworkImage(
// // //                           imageUrl: _currentUser?.profilePhoto ?? 'https://via.placeholder.com/150',
// // //                           width: 100,
// // //                           height: 100,
// // //                           fit: BoxFit.cover,
// // //                           placeholder: (context, url) => const CircularProgressIndicator(),
// // //                           errorWidget: (context, url, error) => const Icon(
// // //                             Icons.error,
// // //                             color: Colors.red,
// // //                             size: 50,
// // //                           ),
// // //                         ),
// // //                 ),
// // //               ),
// // //               GestureDetector(
// // //                 onTap: _pickImage,
// // //                 child: Container(
// // //                   padding: const EdgeInsets.all(8),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white,
// // //                     shape: BoxShape.circle,
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black.withOpacity(0.2),
// // //                         blurRadius: 4,
// // //                         offset: const Offset(0, 2),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: const Icon(
// // //                     Icons.camera_alt,
// // //                     color: AppColors.primary,
// // //                     size: 20,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           if (_selectedImage != null) ...[
// // //             const SizedBox(height: 16),
// // //             ElevatedButton(
// // //               onPressed: _isLoading ? null : _uploadProfilePhoto,
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: AppColors.primary,
// // //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // //               ),
// // //               child: _isLoading
// // //                   ? const CircularProgressIndicator(color: Colors.white)
// // //                   : const Text(
// // //                       'Confirmer l\'upload',
// // //                       style: TextStyle(color: Colors.white),
// // //                     ),
// // //             ),
// // //           ],
// // //           const SizedBox(height: 16),
// // //           Text(
// // //             _currentUser?.fullTitle ?? 'Utilisateur',
// // //             style: const TextStyle(
// // //               fontSize: 24,
// // //               color: Colors.white,
// // //               fontWeight: FontWeight.bold,
// // //             ),
// // //           ),
// // //           Text(
// // //             _currentUser?.email ?? '',
// // //             style: const TextStyle(
// // //               color: Colors.white70,
// // //               fontSize: 16,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildInfoCard(IconData icon, String field, String value) {
// // //     return Card(
// // //       elevation: 2,
// // //       margin: const EdgeInsets.only(bottom: 12),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // //       child: InkWell(
// // //         onTap: () => _editField(context, field, value),
// // //         borderRadius: BorderRadius.circular(15),
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16),
// // //           child: Row(
// // //             children: [
// // //               Container(
// // //                 padding: const EdgeInsets.all(10),
// // //                 decoration: BoxDecoration(
// // //                   color: AppColors.primary.withOpacity(0.1),
// // //                   borderRadius: BorderRadius.circular(10),
// // //                 ),
// // //                 child: Icon(icon, color: AppColors.primary, size: 24),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       _getFieldTitle(field),
// // //                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Text(
// // //                       value,
// // //                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               Icon(
// // //                 Icons.edit,
// // //                 color: AppColors.primary.withOpacity(0.5),
// // //                 size: 20,
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _generateQRCode(BuildContext context) {
// // //     final qrData = [
// // //       'Nom complet: ${_currentUser?.fullName ?? 'Non renseigné'}',
// // //       'Email: ${_currentUser?.email ?? 'Non renseigné'}',
// // //       'Téléphone: ${_currentUser?.phoneNumber ?? 'Non renseigné'}',
// // //       'Date de naissance: ${_formatDateForDisplay(_currentUser?.dateOfBirth)}',
// // //       'Genre: ${_currentUser?.gender ?? 'Non renseigné'}',
// // //       'Adresse: ${_currentUser?.address ?? 'Non renseigné'}',
// // //       'Groupe sanguin: ${_currentUser?.bloodType ?? 'Non renseigné'}',
// // //       'Allergies: ${_currentUser?.allergies ?? 'Non renseigné'}',
// // //       'Contact d\'urgence: ${_currentUser?.emergencyContact ?? 'Non renseigné'}',
// // //     ].join('\n');
// // //     showDialog(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: const Text('Code QR'),
// // //         content: SizedBox(
// // //           width: 200,
// // //           height: 250,
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               WidgetsToImage(
// // //                 controller: controller,
// // //                 child: Container(
// // //                   color: Colors.white,
// // //                   child: QrImageView(
// // //                     data: qrData,
// // //                     version: QrVersions.auto,
// // //                     size: 200.0,
// // //                     gapless: false,
// // //                     errorStateBuilder: (context, error) {
// // //                       return const Center(child: Text('Erreur de génération du QR code'));
// // //                     },
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 10),
// // //               const Text('Scannez ce code pour voir les informations.'),
// // //             ],
// // //           ),
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () async {
// // //               final bytes = await controller.capture();
// // //               if (bytes != null) {
// // //                 final directory = await getApplicationDocumentsDirectory();
// // //                 final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
// // //                 await file.writeAsBytes(bytes);
// // //                 if (mounted) {
// // //                   ScaffoldMessenger.of(context).showSnackBar(
// // //                     SnackBar(content: Text('QR code enregistré dans ${file.path}')),
// // //                   );
// // //                 }
// // //               }
// // //             },
// // //             child: const Text('Enregistrer'),
// // //           ),
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context),
// // //             child: const Text('Fermer'),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (_isLoading && _currentUser == null) {
// // //       return Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text('Mon Profil'),
// // //           backgroundColor: AppColors.primary,
// // //         ),
// // //         body: const Center(child: CircularProgressIndicator()),
// // //       );
// // //     }
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[50],
// // //       appBar: AppBar(
// // //         backgroundColor: AppColors.primary,
// // //         elevation: 0,
// // //         title: const Text(
// // //           'Mon Profil',
// // //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
// // //         ),
// // //         actions: [
// // //           IconButton(
// // //             icon: const Icon(Icons.logout, color: Colors.white),
// // //             onPressed: () async {
// // //               final confirm = await showDialog<bool>(
// // //                 context: context,
// // //                 builder: (context) => AlertDialog(
// // //                   title: const Text('Déconnexion'),
// // //                   content: const Text('Voulez-vous vraiment vous déconnecter ?'),
// // //                   actions: [
// // //                     TextButton(
// // //                       onPressed: () => Navigator.pop(context, false),
// // //                       child: const Text('Annuler'),
// // //                     ),
// // //                     TextButton(
// // //                       onPressed: () => Navigator.pop(context, true),
// // //                       child: const Text('Confirmer'),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               );
// // //               if (confirm == true) {
// // //                 await AuthService.logout();
// // //                 if (mounted) {
// // //                   Navigator.pushReplacementNamed(context, '/signin');
// // //                 }
// // //               }
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Column(
// // //           children: [
// // //             _buildProfileHeader(),
// // //             Padding(
// // //               padding: const EdgeInsets.all(16),
// // //               child: Column(
// // //                 children: [
// // //                   _buildInfoCard(Icons.person_outline, 'name', _currentUser?.fullName ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate',
// // //                       _formatDateForDisplay(_currentUser?.dateOfBirth) ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.email_outlined, 'email', _currentUser?.email ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.phone_outlined, 'phone', _currentUser?.phoneNumber ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.transgender, 'gender', _currentUser?.gender ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.location_on_outlined, 'address', _currentUser?.address ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _currentUser?.bloodType ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _currentUser?.allergies ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact',
// // //                       _currentUser?.emergencyContact ?? 'Non renseigné'),
// // //                   const SizedBox(height: 20),
// // //                   ElevatedButton.icon(
// // //                     onPressed: () => _generateQRCode(context),
// // //                     icon: const Icon(Icons.qr_code, color: Colors.white),
// // //                     label: const Text('Générer le code QR', style: TextStyle(color: Colors.white)),
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: AppColors.primary,
// // //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }






// // // import 'dart:io';
// // // import 'package:cached_network_image/cached_network_image.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:image_picker/image_picker.dart';
// // // import 'package:path_provider/path_provider.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // // import 'package:qr_flutter/qr_flutter.dart';
// // // import 'package:widgets_to_image/widgets_to_image.dart';
// // // import 'package:device_info_plus/device_info_plus.dart';
// // // import 'package:image/image.dart' as img;
// // // import '../constants/app_colors.dart';
// // // import '../models/user_model.dart';
// // // import '../services/auth_service.dart';
// // // import '../services/api_service.dart';

// // // class ProfileScreen extends StatefulWidget {
// // //   const ProfileScreen({super.key});

// // //   @override
// // //   State<ProfileScreen> createState() => _ProfileScreenState();
// // // }

// // // class _ProfileScreenState extends State<ProfileScreen> {
// // //   UserModel? _currentUser;
// // //   bool _isLoading = false;
// // //   WidgetsToImageController controller = WidgetsToImageController();
// // //   final ImagePicker _picker = ImagePicker();
// // //   File? _selectedImage;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _loadUserData();
// // //   }

// // //   Future<void> _loadUserData() async {
// // //     setState(() => _isLoading = true);
// // //     try {
// // //       _currentUser = await AuthService.getCurrentUser(forceRefresh: true);
// // //       if (_currentUser == null || _currentUser!.id.isEmpty) {
// // //         if (mounted) {
// // //           Navigator.pushReplacementNamed(context, '/signin');
// // //         }
// // //         return;
// // //       }
// // //       final userData = await ApiService.getUserProfile();
// // //       print('Profile Photo URL from API: ${userData['profilePhoto']}');
// // //       final updatedUser = UserModel.fromMap(userData);
// // //       if (updatedUser.id != _currentUser!.id) {
// // //         throw Exception('ID utilisateur incohérent dans la réponse');
// // //       }
// // //       await AuthService.saveUser(updatedUser);
// // //       if (mounted) {
// // //         setState(() {
// // //           _currentUser = updatedUser;
// // //           _isLoading = false;
// // //         });
// // //         print('Updated _currentUser.profilePhoto: ${_currentUser?.profilePhoto}');
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //         setState(() => _isLoading = false);
// // //       }
// // //     }
// // //   }

// // //   Future<bool> _requestPermissions() async {
// // //     if (Platform.isIOS || Platform.isAndroid) {
// // //       final permissions = [Permission.camera, Permission.photos];

// // //       if (Platform.isAndroid) {
// // //         final androidVersion = await _getAndroidVersion();
// // //         if (androidVersion < 33) {
// // //           permissions.add(Permission.storage);
// // //         }
// // //       }

// // //       final statuses = await permissions.request();
// // //       final allGranted = statuses.values.every((status) => status.isGranted);

// // //       if (!allGranted) {
// // //         for (var entry in statuses.entries) {
// // //           if (!entry.value.isGranted && entry.value.isPermanentlyDenied && mounted) {
// // //             ScaffoldMessenger.of(context).showSnackBar(
// // //               SnackBar(
// // //                 content: Text(
// // //                   'Permission ${entry.key} refusée définitivement. Veuillez l\'activer dans les paramètres.',
// // //                 ),
// // //                 action: SnackBarAction(
// // //                   label: 'Paramètres',
// // //                   onPressed: () => openAppSettings(),
// // //                 ),
// // //               ),
// // //             );
// // //           }
// // //         }
// // //       }

// // //       return allGranted;
// // //     }
// // //     return true;
// // //   }

// // //   Future<int> _getAndroidVersion() async {
// // //     if (Platform.isAndroid) {
// // //       final deviceInfo = DeviceInfoPlugin();
// // //       final androidInfo = await deviceInfo.androidInfo;
// // //       return androidInfo.version.sdkInt;
// // //     }
// // //     return 0;
// // //   }

// // //   Future<File> convertToJpeg(File image) async {
// // //     final rawImage = await image.readAsBytes();
// // //     final decodedImage = img.decodeImage(rawImage);
// // //     if (decodedImage == null) throw Exception('Impossible de décoder l\'image');
// // //     final jpegImage = img.encodeJpg(decodedImage, quality: 85);
// // //     final tempDir = await getTemporaryDirectory();
// // //     final tempFile = File('${tempDir.path}/profile_photo.jpg');
// // //     await tempFile.writeAsBytes(jpegImage);
// // //     return tempFile;
// // //   }

// // //   Future<void> _pickImage() async {
// // //     try {
// // //       final permissionsGranted = await _requestPermissions();
// // //       if (!permissionsGranted) {
// // //         if (mounted) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             const SnackBar(content: Text('Les permissions nécessaires ne sont pas accordées.')),
// // //           );
// // //         }
// // //         return;
// // //       }

// // //       final source = await showDialog<ImageSource>(
// // //         context: context,
// // //         builder: (context) => AlertDialog(
// // //           title: const Text('Changer la photo de profil'),
// // //           content: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               ListTile(
// // //                 leading: const Icon(Icons.camera_alt),
// // //                 title: const Text('Prendre une photo'),
// // //                 onTap: () => Navigator.pop(context, ImageSource.camera),
// // //               ),
// // //               ListTile(
// // //                 leading: const Icon(Icons.photo_library),
// // //                 title: const Text('Choisir dans la galerie'),
// // //                 onTap: () => Navigator.pop(context, ImageSource.gallery),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       );

// // //       if (source == null) return;

// // //       final XFile? pickedFile = await _picker.pickImage(
// // //         source: source,
// // //         maxWidth: 800,
// // //         maxHeight: 800,
// // //         imageQuality: 85,
// // //       ).catchError((e) {
// // //         if (mounted) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             SnackBar(content: Text('Erreur lors de la sélection de l\'image: $e')),
// // //           );
// // //         }
// // //         return null;
// // //       });

// // //       if (pickedFile == null) return;

// // //       setState(() {
// // //         _selectedImage = File(pickedFile.path);
// // //       });
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   Future<void> _uploadProfilePhoto() async {
// // //     if (_selectedImage == null) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Veuillez sélectionner une image.')),
// // //         );
// // //       }
// // //       return;
// // //     }

// // //     setState(() => _isLoading = true);

// // //     try {
// // //       File imageToUpload = _selectedImage!;
// // //       if (_selectedImage!.path.endsWith('.png')) {
// // //         imageToUpload = await convertToJpeg(_selectedImage!);
// // //       }

// // //       final fileSize = await imageToUpload.length();
// // //       if (fileSize > 5 * 1024 * 1024) {
// // //         throw Exception('L\'image est trop volumineuse (max 5 Mo)');
// // //       }

// // //       final imageUrl = await ApiService.uploadProfilePhoto(imageToUpload);

// // //       if (imageUrl != null) {
// // //         await ApiService.updateUserProfile({'profilePhoto': imageUrl});
// // //         // Vider le cache pour la nouvelle image
// // //         await CachedNetworkImageProvider(imageUrl).evict();
// // //         await _loadUserData();
// // //         if (mounted) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             const SnackBar(content: Text('Photo de profil mise à jour')),
// // //           );
// // //           setState(() {
// // //             _selectedImage = null;
// // //           });
// // //         }
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur: $e')),
// // //         );
// // //       }
// // //     } finally {
// // //       setState(() => _isLoading = false);
// // //     }
// // //   }

// // //   String? _formatDateForDisplay(String? date) {
// // //     if (date == null) return 'Non renseigné';
// // //     try {
// // //       final dateTime = DateTime.parse(date);
// // //       return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
// // //     } catch (e) {
// // //       return date;
// // //     }
// // //   }

// // //   String? _formatDateForApi(String date) {
// // //     try {
// // //       final parts = date.split('/');
// // //       if (parts.length != 3) return null;
// // //       final day = parts[0];
// // //       final month = parts[1];
// // //       final year = parts[2];
// // //       return '$year-$month-$day';
// // //     } catch (e) {
// // //       return null;
// // //     }
// // //   }

// // //   Future<void> _editField(BuildContext context, String field, String currentValue) async {
// // //     if (field == 'birthdate') {
// // //       DateTime initialDate;
// // //       try {
// // //         final parts = currentValue.split('/');
// // //         if (parts.length == 3) {
// // //           initialDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
// // //         } else {
// // //           initialDate = DateTime.now();
// // //         }
// // //       } catch (e) {
// // //         initialDate = DateTime.now();
// // //       }
// // //       final selectedDate = await showDatePicker(
// // //         context: context,
// // //         initialDate: initialDate,
// // //         firstDate: DateTime(1900),
// // //         lastDate: DateTime.now(),
// // //       );
// // //       if (selectedDate != null) {
// // //         final formattedDate =
// // //             '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
// // //         await _saveUserData(field, formattedDate);
// // //       }
// // //       return;
// // //     }
// // //     final controller = TextEditingController(text: currentValue.replaceAll('Non renseigné', ''));
// // //     if (field == 'gender') {
// // //       String? result = await showDialog<String>(
// // //         context: context,
// // //         builder: (context) => AlertDialog(
// // //           title: Text('Modifier ${_getFieldTitle(field)}'),
// // //           content: DropdownButtonFormField<String>(
// // //             value: _currentUser?.gender ?? 'other',
// // //             decoration: const InputDecoration(labelText: 'Genre'),
// // //             items: ['male', 'female', 'other']
// // //                 .map((gender) => DropdownMenuItem(
// // //                       value: gender,
// // //                       child: Text(gender == 'male' ? 'Homme' : gender == 'female' ? 'Femme' : 'Autre'),
// // //                     ))
// // //                 .toList(),
// // //             onChanged: (value) {
// // //               if (value != null) {
// // //                 controller.text = value;
// // //                 setState(() {});
// // //               }
// // //             },
// // //           ),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () => Navigator.pop(context),
// // //               child: const Text('Annuler'),
// // //             ),
// // //             TextButton(
// // //               onPressed: () => Navigator.pop(context, controller.text),
// // //               child: const Text('Sauvegarder'),
// // //             ),
// // //           ],
// // //         ),
// // //       );
// // //       if (result != null && result.isNotEmpty) {
// // //         await _saveUserData(field, result);
// // //       }
// // //       return;
// // //     }
// // //     String? result = await showDialog<String>(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: Text('Modifier ${_getFieldTitle(field)}'),
// // //         content: TextField(
// // //           controller: controller,
// // //           decoration: InputDecoration(
// // //             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
// // //             errorText: _validateField(field, controller.text) ? null : _getValidationErrorMessage(field),
// // //           ),
// // //           onChanged: (value) {
// // //             setState(() {});
// // //           },
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context),
// // //             child: const Text('Annuler'),
// // //           ),
// // //           TextButton(
// // //             onPressed: () {
// // //               if (_validateField(field, controller.text)) {
// // //                 Navigator.pop(context, controller.text);
// // //               } else {
// // //                 ScaffoldMessenger.of(context).showSnackBar(
// // //                   SnackBar(content: Text(_getValidationErrorMessage(field))),
// // //                 );
// // //               }
// // //             },
// // //             child: const Text('Sauvegarder'),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //     if (result != null && result.isNotEmpty) {
// // //       await _saveUserData(field, result);
// // //     }
// // //   }

// // //   Future<void> _saveUserData(String field, String value) async {
// // //     if (!_validateField(field, value)) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text(_getValidationErrorMessage(field))),
// // //         );
// // //       }
// // //       return;
// // //     }
// // //     final apiKey = _mapToApiKey(field);
// // //     final apiValue = field == 'birthdate' ? _formatDateForApi(value) : value;
// // //     if (apiValue == null && field == 'birthdate') {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Format de date invalide (attendu: JJ/MM/AAAA)')),
// // //         );
// // //       }
// // //       return;
// // //     }
// // //     try {
// // //       await ApiService.updateUserProfile({apiKey: apiValue});
// // //       final userData = await ApiService.getUserProfile();
// // //       final updatedUser = UserModel.fromMap(userData);
// // //       if (updatedUser.id != _currentUser!.id) {
// // //         throw Exception('ID utilisateur incohérent dans la réponse');
// // //       }
// // //       await AuthService.saveUser(updatedUser);
// // //       if (mounted) {
// // //         setState(() {
// // //           _currentUser = updatedUser;
// // //         });
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text('Mise à jour réussie')),
// // //         );
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
// // //         );
// // //       }
// // //     }
// // //   }

// // //   bool _validateField(String key, String value) {
// // //     switch (key) {
// // //       case 'email':
// // //         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
// // //       case 'phone':
// // //         return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);
// // //       case 'birthdate':
// // //         try {
// // //           final parts = value.split('/');
// // //           if (parts.length != 3) return false;
// // //           final day = int.parse(parts[0]);
// // //           final month = int.parse(parts[1]);
// // //           final year = int.parse(parts[2]);
// // //           final date = DateTime(year, month, day);
// // //           return date.isBefore(DateTime.now()) && year >= 1900;
// // //         } catch (e) {
// // //           return false;
// // //         }
// // //       case 'gender':
// // //         return ['male', 'female', 'other'].contains(value.toLowerCase());
// // //       case 'name':
// // //         return value.trim().isNotEmpty && value.length <= 100;
// // //       case 'address':
// // //       case 'bloodType':
// // //       case 'allergies':
// // //       case 'emergencyContact':
// // //         return value.trim().isNotEmpty;
// // //       default:
// // //         return true;
// // //     }
// // //   }

// // //   String _getValidationErrorMessage(String key) {
// // //     switch (key) {
// // //       case 'email':
// // //         return 'Veuillez entrer un email valide (ex: nom@domaine.com)';
// // //       case 'phone':
// // //         return 'Veuillez entrer un numéro de téléphone valide (ex: +22890123456)';
// // //       case 'birthdate':
// // //         return 'Veuillez entrer une date de naissance valide (ex: 15/03/1990)';
// // //       case 'gender':
// // //         return 'Veuillez sélectionner un genre valide';
// // //       case 'name':
// // //         return 'Veuillez entrer un nom valide (non vide, max 100 caractères)';
// // //       case 'address':
// // //       case 'bloodType':
// // //       case 'allergies':
// // //       case 'emergencyContact':
// // //         return 'Ce champ ne peut pas être vide';
// // //       default:
// // //         return 'Valeur invalide';
// // //     }
// // //   }

// // //   String _mapToApiKey(String key) {
// // //     switch (key) {
// // //       case 'name':
// // //         return 'fullName';
// // //       case 'phone':
// // //         return 'phoneNumber';
// // //       case 'birthdate':
// // //         return 'dateOfBirth';
// // //       default:
// // //         return key;
// // //     }
// // //   }

// // //   String _getFieldTitle(String field) {
// // //     switch (field) {
// // //       case 'name':
// // //         return 'Nom complet';
// // //       case 'birthdate':
// // //         return 'Date de naissance';
// // //       case 'email':
// // //         return 'Email';
// // //       case 'phone':
// // //         return 'Téléphone';
// // //       case 'gender':
// // //         return 'Genre';
// // //       case 'address':
// // //         return 'Adresse';
// // //       case 'bloodType':
// // //         return 'Groupe sanguin';
// // //       case 'allergies':
// // //         return 'Allergies';
// // //       case 'emergencyContact':
// // //         return 'Contact d\'urgence';
// // //       default:
// // //         return field;
// // //     }
// // //   }

// // //   Widget _buildProfileHeader() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
// // //       decoration: BoxDecoration(
// // //         color: AppColors.primary,
// // //         borderRadius: const BorderRadius.only(
// // //           bottomLeft: Radius.circular(30),
// // //           bottomRight: Radius.circular(30),
// // //         ),
// // //       ),
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         crossAxisAlignment: CrossAxisAlignment.center,
// // //         children: [
// // //           Stack(
// // //             alignment: Alignment.bottomRight,
// // //             children: [
// // //               CircleAvatar(
// // //                 radius: 50,
// // //                 child: ClipOval(
// // //                   child: _selectedImage != null
// // //                       ? Image.file(
// // //                           _selectedImage!,
// // //                           width: 100,
// // //                           height: 100,
// // //                           fit: BoxFit.cover,
// // //                         )
// // //                       : RepaintBoundary(
// // //                           child: CachedNetworkImage(
// // //                             imageUrl: _currentUser?.profilePhoto ?? 'https://via.placeholder.com/150',
// // //                             cacheKey: '${_currentUser?.profilePhoto}_${DateTime.now().millisecondsSinceEpoch}',
// // //                             width: 100,
// // //                             height: 100,
// // //                             fit: BoxFit.cover,
// // //                             placeholder: (context, url) => const CircularProgressIndicator(),
// // //                             errorWidget: (context, url, error) {
// // //                               print('CachedNetworkImage error: $error, URL: $url');
// // //                               return GestureDetector(
// // //                                 onTap: _loadUserData,
// // //                                 child: const Icon(
// // //                                   Icons.error,
// // //                                   color: Colors.red,
// // //                                   size: 50,
// // //                                 ),
// // //                               );
// // //                             },
// // //                           ),
// // //                         ),
// // //                 ),
// // //               ),
// // //               GestureDetector(
// // //                 onTap: _pickImage,
// // //                 child: Container(
// // //                   padding: const EdgeInsets.all(8),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.white,
// // //                     shape: BoxShape.circle,
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black.withOpacity(0.2),
// // //                         blurRadius: 4,
// // //                         offset: const Offset(0, 2),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: const Icon(
// // //                     Icons.camera_alt,
// // //                     color: AppColors.primary,
// // //                     size: 20,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           if (_selectedImage != null) ...[
// // //             const SizedBox(height: 16),
// // //             ElevatedButton(
// // //               onPressed: _isLoading ? null : _uploadProfilePhoto,
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: AppColors.primary,
// // //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // //               ),
// // //               child: _isLoading
// // //                   ? const CircularProgressIndicator(color: Colors.white)
// // //                   : const Text(
// // //                       'Confirmer l\'upload',
// // //                       style: TextStyle(color: Colors.white),
// // //                     ),
// // //             ),
// // //           ],
// // //           const SizedBox(height: 16),
// // //           Text(
// // //             _currentUser?.fullTitle ?? 'Utilisateur',
// // //             style: const TextStyle(
// // //               fontSize: 24,
// // //               color: Colors.white,
// // //               fontWeight: FontWeight.bold,
// // //             ),
// // //           ),
// // //           Text(
// // //             _currentUser?.email ?? '',
// // //             style: const TextStyle(
// // //               color: Colors.white70,
// // //               fontSize: 16,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildInfoCard(IconData icon, String field, String value) {
// // //     return Card(
// // //       elevation: 2,
// // //       margin: const EdgeInsets.only(bottom: 12),
// // //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// // //       child: InkWell(
// // //         onTap: () => _editField(context, field, value),
// // //         borderRadius: BorderRadius.circular(15),
// // //         child: Padding(
// // //           padding: const EdgeInsets.all(16),
// // //           child: Row(
// // //             children: [
// // //               Container(
// // //                 padding: const EdgeInsets.all(10),
// // //                 decoration: BoxDecoration(
// // //                   color: AppColors.primary.withOpacity(0.1),
// // //                   borderRadius: BorderRadius.circular(10),
// // //                 ),
// // //                 child: Icon(icon, color: AppColors.primary, size: 24),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     Text(
// // //                       _getFieldTitle(field),
// // //                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Text(
// // //                       value,
// // //                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               Icon(
// // //                 Icons.edit,
// // //                 color: AppColors.primary.withOpacity(0.5),
// // //                 size: 20,
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _generateQRCode(BuildContext context) {
// // //     final qrData = [
// // //       'Nom complet: ${_currentUser?.fullName ?? 'Non renseigné'}',
// // //       'Email: ${_currentUser?.email ?? 'Non renseigné'}',
// // //       'Téléphone: ${_currentUser?.phoneNumber ?? 'Non renseigné'}',
// // //       'Date de naissance: ${_formatDateForDisplay(_currentUser?.dateOfBirth)}',
// // //       'Genre: ${_currentUser?.gender ?? 'Non renseigné'}',
// // //       'Adresse: ${_currentUser?.address ?? 'Non renseigné'}',
// // //       'Groupe sanguin: ${_currentUser?.bloodType ?? 'Non renseigné'}',
// // //       'Allergies: ${_currentUser?.allergies ?? 'Non renseigné'}',
// // //       'Contact d\'urgence: ${_currentUser?.emergencyContact ?? 'Non renseigné'}',
// // //     ].join('\n');
// // //     showDialog(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: const Text('Code QR'),
// // //         content: SizedBox(
// // //           width: 200,
// // //           height: 250,
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               WidgetsToImage(
// // //                 controller: controller,
// // //                 child: Container(
// // //                   color: Colors.white,
// // //                   child: QrImageView(
// // //                     data: qrData,
// // //                     version: QrVersions.auto,
// // //                     size: 200.0,
// // //                     gapless: false,
// // //                     errorStateBuilder: (context, error) {
// // //                       return const Center(child: Text('Erreur de génération du QR code'));
// // //                     },
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(height: 10),
// // //               const Text('Scannez ce code pour voir les informations.'),
// // //             ],
// // //           ),
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () async {
// // //               final bytes = await controller.capture();
// // //               if (bytes != null) {
// // //                 final directory = await getApplicationDocumentsDirectory();
// // //                 final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
// // //                 await file.writeAsBytes(bytes);
// // //                 if (mounted) {
// // //                   ScaffoldMessenger.of(context).showSnackBar(
// // //                     SnackBar(content: Text('QR code enregistré dans ${file.path}')),
// // //                   );
// // //                 }
// // //               }
// // //             },
// // //             child: const Text('Enregistrer'),
// // //           ),
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context),
// // //             child: const Text('Fermer'),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (_isLoading && _currentUser == null) {
// // //       return Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text('Mon Profil'),
// // //           backgroundColor: AppColors.primary,
// // //         ),
// // //         body: const Center(child: CircularProgressIndicator()),
// // //       );
// // //     }
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[50],
// // //       appBar: AppBar(
// // //         backgroundColor: AppColors.primary,
// // //         elevation: 0,
// // //         title: const Text(
// // //           'Mon Profil',
// // //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
// // //         ),
// // //         actions: [
// // //           IconButton(
// // //             icon: const Icon(Icons.logout, color: Colors.white),
// // //             onPressed: () async {
// // //               final confirm = await showDialog<bool>(
// // //                 context: context,
// // //                 builder: (context) => AlertDialog(
// // //                   title: const Text('Déconnexion'),
// // //                   content: const Text('Voulez-vous vraiment vous déconnecter ?'),
// // //                   actions: [
// // //                     TextButton(
// // //                       onPressed: () => Navigator.pop(context, false),
// // //                       child: const Text('Annuler'),
// // //                     ),
// // //                     TextButton(
// // //                       onPressed: () => Navigator.pop(context, true),
// // //                       child: const Text('Confirmer'),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               );
// // //               if (confirm == true) {
// // //                 await AuthService.logout();
// // //                 if (mounted) {
// // //                   Navigator.pushReplacementNamed(context, '/signin');
// // //                 }
// // //               }
// // //             },
// // //           ),
// // //         ],
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Column(
// // //           children: [
// // //             _buildProfileHeader(),
// // //             Padding(
// // //               padding: const EdgeInsets.all(16),
// // //               child: Column(
// // //                 children: [
// // //                   _buildInfoCard(Icons.person_outline, 'name', _currentUser?.fullName ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate',
// // //                       _formatDateForDisplay(_currentUser?.dateOfBirth) ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.email_outlined, 'email', _currentUser?.email ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.phone_outlined, 'phone', _currentUser?.phoneNumber ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.transgender, 'gender', _currentUser?.gender ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.location_on_outlined, 'address', _currentUser?.address ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _currentUser?.bloodType ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _currentUser?.allergies ?? 'Non renseigné'),
// // //                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact',
// // //                       _currentUser?.emergencyContact ?? 'Non renseigné'),
// // //                   const SizedBox(height: 20),
// // //                   ElevatedButton.icon(
// // //                     onPressed: () => _generateQRCode(context),
// // //                     icon: const Icon(Icons.qr_code, color: Colors.white),
// // //                     label: const Text('Générer le code QR', style: TextStyle(color: Colors.white)),
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: AppColors.primary,
// // //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// // //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:io';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:qr_flutter/qr_flutter.dart';
// // import 'package:widgets_to_image/widgets_to_image.dart';
// // import 'package:image/image.dart' as img;
// // import '../constants/app_colors.dart';
// // import '../models/user_model.dart';
// // import '../services/auth_service.dart';
// // import '../services/api_service.dart';

// // class ProfileScreen extends StatefulWidget {
// //   const ProfileScreen({super.key});

// //   @override
// //   State<ProfileScreen> createState() => _ProfileScreenState();
// // }

// // class _ProfileScreenState extends State<ProfileScreen> {
// //   UserModel? _currentUser;
// //   bool _isLoading = false;
// //   WidgetsToImageController controller = WidgetsToImageController();
// //   final ImagePicker _picker = ImagePicker();
// //   File? _selectedImage;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadUserData();
// //   }

// //   Future<void> _loadUserData() async {
// //     setState(() => _isLoading = true);
// //     try {
// //       _currentUser = await AuthService.getCurrentUser(forceRefresh: true);
// //       if (_currentUser == null || _currentUser!.id.isEmpty) {
// //         if (mounted) {
// //           Navigator.pushReplacementNamed(context, '/signin');
// //         }
// //         return;
// //       }
// //       final userData = await ApiService.getUserProfile();
// //       print('Profile Photo URL from API: ${userData['profilePhoto']}');
// //       final updatedUser = UserModel.fromMap(userData);
// //       if (updatedUser.id != _currentUser!.id) {
// //         throw Exception('ID utilisateur incohérent dans la réponse');
// //       }
// //       await AuthService.saveUser(updatedUser);
// //       if (mounted) {
// //         setState(() {
// //           _currentUser = updatedUser;
// //           _isLoading = false;
// //         });
// //         print('Updated _currentUser.profilePhoto: ${_currentUser?.profilePhoto}');
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Erreur: $e')),
// //         );
// //         setState(() => _isLoading = false);
// //       }
// //     }
// //   }

// //   Future<bool> _requestPermissions() async {
// //     Map<Permission, PermissionStatus> statuses = await [
// //       Permission.camera,
// //       Platform.isAndroid
// //           ? (Platform.version.startsWith('13') // Android 13+
// //               ? Permission.photos
// //               : Permission.storage)
// //           : Permission.photos,
// //     ].request();
    
// //     bool allGranted = statuses.values.every((status) => status.isGranted);
    
// //     if (!allGranted && mounted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: const Text('Certaines permissions sont nécessaires pour cette fonctionnalité.'),
// //           action: SnackBarAction(
// //             label: 'Paramètres',
// //             onPressed: () => openAppSettings(),
// //           ),
// //         ),
// //       );
// //     }
    
// //     return allGranted;
// //   }

// //   Future<File> convertToJpeg(File image) async {
// //     final rawImage = await image.readAsBytes();
// //     final decodedImage = img.decodeImage(rawImage);
// //     if (decodedImage == null) throw Exception('Impossible de décoder l\'image');
// //     final jpegImage = img.encodeJpg(decodedImage, quality: 85);
// //     final tempDir = await getTemporaryDirectory();
// //     final tempFile = File('${tempDir.path}/profile_photo.jpg');
// //     await tempFile.writeAsBytes(jpegImage);
// //     return tempFile;
// //   }

// //   Future<void> _pickImage() async {
// //     try {
// //       final permissionsGranted = await _requestPermissions();
// //       if (!permissionsGranted) {
// //         return;
// //       }

// //       final source = await showDialog<ImageSource>(
// //         context: context,
// //         builder: (context) => AlertDialog(
// //           title: const Text('Changer la photo de profil'),
// //           content: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               ListTile(
// //                 leading: const Icon(Icons.camera_alt),
// //                 title: const Text('Prendre une photo'),
// //                 onTap: () => Navigator.pop(context, ImageSource.camera),
// //               ),
// //               ListTile(
// //                 leading: const Icon(Icons.photo_library),
// //                 title: const Text('Choisir dans la galerie'),
// //                 onTap: () => Navigator.pop(context, ImageSource.gallery),
// //               ),
// //             ],
// //           ),
// //         ),
// //       );

// //       if (source == null) return;

// //       final XFile? pickedFile = await _picker.pickImage(
// //         source: source,
// //         maxWidth: 800,
// //         maxHeight: 800,
// //         imageQuality: 85,
// //       ).catchError((e) {
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(content: Text('Erreur lors de la sélection de l\'image: $e')),
// //           );
// //         }
// //         return null;
// //       });

// //       if (pickedFile == null) return;

// //       setState(() {
// //         _selectedImage = File(pickedFile.path);
// //       });
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Erreur: $e')),
// //         );
// //       }
// //     }
// //   }

// //   Future<void> _uploadProfilePhoto() async {
// //     if (_selectedImage == null) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Veuillez sélectionner une image.')),
// //         );
// //       }
// //       return;
// //     }

// //     setState(() => _isLoading = true);

// //     try {
// //       File imageToUpload = _selectedImage!;
// //       if (_selectedImage!.path.endsWith('.png')) {
// //         imageToUpload = await convertToJpeg(_selectedImage!);
// //       }

// //       final fileSize = await imageToUpload.length();
// //       if (fileSize > 5 * 1024 * 1024) {
// //         throw Exception('L\'image est trop volumineuse (max 5 Mo)');
// //       }

// //       final imageUrl = await ApiService.uploadProfilePhoto(imageToUpload);

// //       if (imageUrl != null) {
// //         await ApiService.updateUserProfile({'profilePhoto': imageUrl});
// //         // Vider le cache pour la nouvelle image
// //         await CachedNetworkImageProvider(imageUrl).evict();
// //         await _loadUserData();
// //         if (mounted) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             const SnackBar(content: Text('Photo de profil mise à jour')),
// //           );
// //           setState(() {
// //             _selectedImage = null;
// //           });
// //         }
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Erreur: $e')),
// //         );
// //       }
// //     } finally {
// //       setState(() => _isLoading = false);
// //     }
// //   }

// //   String? _formatDateForDisplay(String? date) {
// //     if (date == null) return 'Non renseigné';
// //     try {
// //       final dateTime = DateTime.parse(date);
// //       return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
// //     } catch (e) {
// //       return date;
// //     }
// //   }

// //   String? _formatDateForApi(String date) {
// //     try {
// //       final parts = date.split('/');
// //       if (parts.length != 3) return null;
// //       final day = parts[0];
// //       final month = parts[1];
// //       final year = parts[2];
// //       return '$year-$month-$day';
// //     } catch (e) {
// //       return null;
// //     }
// //   }

// //   Future<void> _editField(BuildContext context, String field, String currentValue) async {
// //     if (field == 'birthdate') {
// //       DateTime initialDate;
// //       try {
// //         final parts = currentValue.split('/');
// //         if (parts.length == 3) {
// //           initialDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
// //         } else {
// //           initialDate = DateTime.now();
// //         }
// //       } catch (e) {
// //         initialDate = DateTime.now();
// //       }
// //       final selectedDate = await showDatePicker(
// //         context: context,
// //         initialDate: initialDate,
// //         firstDate: DateTime(1900),
// //         lastDate: DateTime.now(),
// //       );
// //       if (selectedDate != null) {
// //         final formattedDate =
// //             '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
// //         await _saveUserData(field, formattedDate);
// //       }
// //       return;
// //     }
// //     final controller = TextEditingController(text: currentValue.replaceAll('Non renseigné', ''));
// //     if (field == 'gender') {
// //       String? result = await showDialog<String>(
// //         context: context,
// //         builder: (context) => AlertDialog(
// //           title: Text('Modifier ${_getFieldTitle(field)}'),
// //           content: DropdownButtonFormField<String>(
// //             value: _currentUser?.gender ?? 'other',
// //             decoration: const InputDecoration(labelText: 'Genre'),
// //             items: ['male', 'female', 'other']
// //                 .map((gender) => DropdownMenuItem(
// //                       value: gender,
// //                       child: Text(gender == 'male' ? 'Homme' : gender == 'female' ? 'Femme' : 'Autre'),
// //                     ))
// //                 .toList(),
// //             onChanged: (value) {
// //               if (value != null) {
// //                 controller.text = value;
// //                 setState(() {});
// //               }
// //             },
// //           ),
// //           actions: [
// //             TextButton(
// //               onPressed: () => Navigator.pop(context),
// //               child: const Text('Annuler'),
// //             ),
// //             TextButton(
// //               onPressed: () => Navigator.pop(context, controller.text),
// //               child: const Text('Sauvegarder'),
// //             ),
// //           ],
// //         ),
// //       );
// //       if (result != null && result.isNotEmpty) {
// //         await _saveUserData(field, result);
// //       }
// //       return;
// //     }
// //     String? result = await showDialog<String>(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text('Modifier ${_getFieldTitle(field)}'),
// //         content: TextField(
// //           controller: controller,
// //           decoration: InputDecoration(
// //             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
// //             errorText: _validateField(field, controller.text) ? null : _getValidationErrorMessage(field),
// //           ),
// //           onChanged: (value) {
// //             setState(() {});
// //           },
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text('Annuler'),
// //           ),
// //           TextButton(
// //             onPressed: () {
// //               if (_validateField(field, controller.text)) {
// //                 Navigator.pop(context, controller.text);
// //               } else {
// //                 ScaffoldMessenger.of(context).showSnackBar(
// //                   SnackBar(content: Text(_getValidationErrorMessage(field))),
// //                 );
// //               }
// //             },
// //             child: const Text('Sauvegarder'),
// //           ),
// //         ],
// //       ),
// //     );
// //     if (result != null && result.isNotEmpty) {
// //       await _saveUserData(field, result);
// //     }
// //   }

// //   Future<void> _saveUserData(String field, String value) async {
// //     if (!_validateField(field, value)) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text(_getValidationErrorMessage(field))),
// //         );
// //       }
// //       return;
// //     }
// //     final apiKey = _mapToApiKey(field);
// //     final apiValue = field == 'birthdate' ? _formatDateForApi(value) : value;
// //     if (apiValue == null && field == 'birthdate') {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Format de date invalide (attendu: JJ/MM/AAAA)')),
// //         );
// //       }
// //       return;
// //     }
// //     try {
// //       await ApiService.updateUserProfile({apiKey: apiValue});
// //       final userData = await ApiService.getUserProfile();
// //       final updatedUser = UserModel.fromMap(userData);
// //       if (updatedUser.id != _currentUser!.id) {
// //         throw Exception('ID utilisateur incohérent dans la réponse');
// //       }
// //       await AuthService.saveUser(updatedUser);
// //       if (mounted) {
// //         setState(() {
// //           _currentUser = updatedUser;
// //         });
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Mise à jour réussie')),
// //         );
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
// //         );
// //       }
// //     }
// //   }

// //   bool _validateField(String key, String value) {
// //     switch (key) {
// //       case 'email':
// //         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
// //       case 'phone':
// //         return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);
// //       case 'birthdate':
// //         try {
// //           final parts = value.split('/');
// //           if (parts.length != 3) return false;
// //           final day = int.parse(parts[0]);
// //           final month = int.parse(parts[1]);
// //           final year = int.parse(parts[2]);
// //           final date = DateTime(year, month, day);
// //           return date.isBefore(DateTime.now()) && year >= 1900;
// //         } catch (e) {
// //           return false;
// //         }
// //       case 'gender':
// //         return ['male', 'female', 'other'].contains(value.toLowerCase());
// //       case 'name':
// //         return value.trim().isNotEmpty && value.length <= 100;
// //       case 'address':
// //       case 'bloodType':
// //       case 'allergies':
// //       case 'emergencyContact':
// //         return value.trim().isNotEmpty;
// //       default:
// //         return true;
// //     }
// //   }

// //   String _getValidationErrorMessage(String key) {
// //     switch (key) {
// //       case 'email':
// //         return 'Veuillez entrer un email valide (ex: nom@domaine.com)';
// //       case 'phone':
// //         return 'Veuillez entrer un numéro de téléphone valide (ex: +22890123456)';
// //       case 'birthdate':
// //         return 'Veuillez entrer une date de naissance valide (ex: 15/03/1990)';
// //       case 'gender':
// //         return 'Veuillez sélectionner un genre valide';
// //       case 'name':
// //         return 'Veuillez entrer un nom valide (non vide, max 100 caractères)';
// //       case 'address':
// //       case 'bloodType':
// //       case 'allergies':
// //       case 'emergencyContact':
// //         return 'Ce champ ne peut pas être vide';
// //       default:
// //         return 'Valeur invalide';
// //     }
// //   }

// //   String _mapToApiKey(String key) {
// //     switch (key) {
// //       case 'name':
// //         return 'fullName';
// //       case 'phone':
// //         return 'phoneNumber';
// //       case 'birthdate':
// //         return 'dateOfBirth';
// //       default:
// //         return key;
// //     }
// //   }

// //   String _getFieldTitle(String field) {
// //     switch (field) {
// //       case 'name':
// //         return 'Nom complet';
// //       case 'birthdate':
// //         return 'Date de naissance';
// //       case 'email':
// //         return 'Email';
// //       case 'phone':
// //         return 'Téléphone';
// //       case 'gender':
// //         return 'Genre';
// //       case 'address':
// //         return 'Adresse';
// //       case 'bloodType':
// //         return 'Groupe sanguin';
// //       case 'allergies':
// //         return 'Allergies';
// //       case 'emergencyContact':
// //         return 'Contact d\'urgence';
// //       default:
// //         return field;
// //     }
// //   }

// //   Widget _buildProfileHeader() {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
// //       decoration: BoxDecoration(
// //         color: AppColors.primary,
// //         borderRadius: const BorderRadius.only(
// //           bottomLeft: Radius.circular(30),
// //           bottomRight: Radius.circular(30),
// //         ),
// //       ),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Stack(
// //             alignment: Alignment.bottomRight,
// //             children: [
// //               CircleAvatar(
// //                 radius: 50,
// //                 child: ClipOval(
// //                   child: _selectedImage != null
// //                       ? Image.file(
// //                           _selectedImage!,
// //                           width: 100,
// //                           height: 100,
// //                           fit: BoxFit.cover,
// //                         )
// //                       : RepaintBoundary(
// //                           child: CachedNetworkImage(
// //                             imageUrl: _currentUser?.profilePhoto ?? 'https://via.placeholder.com/150',
// //                             cacheKey: '${_currentUser?.profilePhoto}_${DateTime.now().millisecondsSinceEpoch}',
// //                             width: 100,
// //                             height: 100,
// //                             fit: BoxFit.cover,
// //                             placeholder: (context, url) => const CircularProgressIndicator(),
// //                             errorWidget: (context, url, error) {
// //                               print('CachedNetworkImage error: $error, URL: $url');
// //                               return GestureDetector(
// //                                 onTap: _loadUserData,
// //                                 child: const Icon(
// //                                   Icons.error,
// //                                   color: Colors.red,
// //                                   size: 50,
// //                                 ),
// //                               );
// //                             },
// //                           ),
// //                         ),
// //                 ),
// //               ),
// //               GestureDetector(
// //                 onTap: _pickImage,
// //                 child: Container(
// //                   padding: const EdgeInsets.all(8),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     shape: BoxShape.circle,
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black.withOpacity(0.2),
// //                         blurRadius: 4,
// //                         offset: const Offset(0, 2),
// //                       ),
// //                     ],
// //                   ),
// //                   child: const Icon(
// //                     Icons.camera_alt,
// //                     color: AppColors.primary,
// //                     size: 20,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           if (_selectedImage != null) ...[
// //             const SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: _isLoading ? null : _uploadProfilePhoto,
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: AppColors.primary,
// //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //               ),
// //               child: _isLoading
// //                   ? const CircularProgressIndicator(color: Colors.white)
// //                   : const Text(
// //                       'Confirmer l\'upload',
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //             ),
// //           ],
// //           const SizedBox(height: 16),
// //           Text(
// //             _currentUser?.fullTitle ?? 'Utilisateur',
// //             style: const TextStyle(
// //               fontSize: 24,
// //               color: Colors.white,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           Text(
// //             _currentUser?.email ?? '',
// //             style: const TextStyle(
// //               color: Colors.white70,
// //               fontSize: 16,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildInfoCard(IconData icon, String field, String value) {
// //     return Card(
// //       elevation: 2,
// //       margin: const EdgeInsets.only(bottom: 12),
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// //       child: InkWell(
// //         onTap: () => _editField(context, field, value),
// //         borderRadius: BorderRadius.circular(15),
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Row(
// //             children: [
// //               Container(
// //                 padding: const EdgeInsets.all(10),
// //                 decoration: BoxDecoration(
// //                   color: AppColors.primary.withOpacity(0.1),
// //                   borderRadius: BorderRadius.circular(10),
// //                 ),
// //                 child: Icon(icon, color: AppColors.primary, size: 24),
// //               ),
// //               const SizedBox(width: 16),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       _getFieldTitle(field),
// //                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       value,
// //                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Icon(
// //                 Icons.edit,
// //                 color: AppColors.primary.withOpacity(0.5),
// //                 size: 20,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void _generateQRCode(BuildContext context) {
// //     final qrData = [
// //       'Nom complet: ${_currentUser?.fullName ?? 'Non renseigné'}',
// //       'Email: ${_currentUser?.email ?? 'Non renseigné'}',
// //       'Téléphone: ${_currentUser?.phoneNumber ?? 'Non renseigné'}',
// //       'Date de naissance: ${_formatDateForDisplay(_currentUser?.dateOfBirth)}',
// //       'Genre: ${_currentUser?.gender ?? 'Non renseigné'}',
// //       'Adresse: ${_currentUser?.address ?? 'Non renseigné'}',
// //       'Groupe sanguin: ${_currentUser?.bloodType ?? 'Non renseigné'}',
// //       'Allergies: ${_currentUser?.allergies ?? 'Non renseigné'}',
// //       'Contact d\'urgence: ${_currentUser?.emergencyContact ?? 'Non renseigné'}',
// //     ].join('\n');
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: const Text('Code QR'),
// //         content: SizedBox(
// //           width: 200,
// //           height: 250,
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               WidgetsToImage(
// //                 controller: controller,
// //                 child: Container(
// //                   color: Colors.white,
// //                   child: QrImageView(
// //                     data: qrData,
// //                     version: QrVersions.auto,
// //                     size: 200.0,
// //                     gapless: false,
// //                     errorStateBuilder: (context, error) {
// //                       return const Center(child: Text('Erreur de génération du QR code'));
// //                     },
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 10),
// //               const Text('Scannez ce code pour voir les informations.'),
// //             ],
// //           ),
// //         ),
// //         actions: [
// //           TextButton(
// //             onPressed: () async {
// //               final bytes = await controller.capture();
// //               if (bytes != null) {
// //                 final directory = await getApplicationDocumentsDirectory();
// //                 final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
// //                 await file.writeAsBytes(bytes);
// //                 if (mounted) {
// //                   ScaffoldMessenger.of(context).showSnackBar(
// //                     SnackBar(content: Text('QR code enregistré dans ${file.path}')),
// //                   );
// //                 }
// //               }
// //             },
// //             child: const Text('Enregistrer'),
// //           ),
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text('Fermer'),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     if (_isLoading && _currentUser == null) {
// //       return Scaffold(
// //         appBar: AppBar(
// //           title: const Text('Mon Profil'),
// //           backgroundColor: AppColors.primary,
// //         ),
// //         body: const Center(child: CircularProgressIndicator()),
// //       );
// //     }
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       appBar: AppBar(
// //         backgroundColor: AppColors.primary,
// //         elevation: 0,
// //         title: const Text(
// //           'Mon Profil',
// //           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
// //         ),
// //         actions: [
// //           IconButton(
// //             icon: const Icon(Icons.logout, color: Colors.white),
// //             onPressed: () async {
// //               final confirm = await showDialog<bool>(
// //                 context: context,
// //                 builder: (context) => AlertDialog(
// //                   title: const Text('Déconnexion'),
// //                   content: const Text('Voulez-vous vraiment vous déconnecter ?'),
// //                   actions: [
// //                     TextButton(
// //                       onPressed: () => Navigator.pop(context, false),
// //                       child: const Text('Annuler'),
// //                     ),
// //                     TextButton(
// //                       onPressed: () => Navigator.pop(context, true),
// //                       child: const Text('Confirmer'),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //               if (confirm == true) {
// //                 await AuthService.logout();
// //                 if (mounted) {
// //                   Navigator.pushReplacementNamed(context, '/signin');
// //                 }
// //               }
// //             },
// //           ),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           children: [
// //             _buildProfileHeader(),
// //             Padding(
// //               padding: const EdgeInsets.all(16),
// //               child: Column(
// //                 children: [
// //                   _buildInfoCard(Icons.person_outline, 'name', _currentUser?.fullName ?? 'Non renseigné'),
// //                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate',
// //                       _formatDateForDisplay(_currentUser?.dateOfBirth) ?? 'Non renseigné'),
// //                   _buildInfoCard(Icons.email_outlined, 'email', _currentUser?.email ?? 'Non renseigné'),
// //                   _buildInfoCard(Icons.phone_outlined, 'phone', _currentUser?.phoneNumber ?? 'Non renseigné'),
// //                   _buildInfoCard(Icons.transgender, 'gender', _currentUser?.gender ?? 'Non renseigné'),
// //                   _buildInfoCard(Icons.location_on_outlined, 'address', _currentUser?.address ?? 'Non renseigné'),
// //                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _currentUser?.bloodType ?? 'Non renseigné'),
// //                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _currentUser?.allergies ?? 'Non renseigné'),
// //                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact',
// //                       _currentUser?.emergencyContact ?? 'Non renseigné'),
// //                   const SizedBox(height: 20),
// //                   ElevatedButton.icon(
// //                     onPressed: () => _generateQRCode(context),
// //                     icon: const Icon(Icons.qr_code, color: Colors.white),
// //                     label: const Text('Générer le code QR', style: TextStyle(color: Colors.white)),
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: AppColors.primary,
// //                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
// //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }





// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:medical/permissions/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:widgets_to_image/widgets_to_image.dart';
// import 'package:image/image.dart' as img;
// import '../constants/app_colors.dart';
// import '../models/user_model.dart';
// import '../services/auth_service.dart';
// import '../services/api_service.dart';
// // import 'permission_manager.dart'; // Import PermissionManager

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   UserModel? _currentUser;
//   bool _isLoading = false;
//   WidgetsToImageController controller = WidgetsToImageController();
//   final ImagePicker _picker = ImagePicker();
//   File? _selectedImage;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     setState(() => _isLoading = true);
//     try {
//       _currentUser = await AuthService.getCurrentUser(forceRefresh: true);
//       if (_currentUser == null || _currentUser!.id.isEmpty) {
//         if (mounted) {
//           Navigator.pushReplacementNamed(context, '/signin');
//         }
//         return;
//       }
//       final userData = await ApiService.getUserProfile();
//       print('Profile Photo URL from API: ${userData['profilePhoto']}');
//       final updatedUser = UserModel.fromMap(userData);
//       if (updatedUser.id != _currentUser!.id) {
//         throw Exception('ID utilisateur incohérent dans la réponse');
//       }
//       await AuthService.saveUser(updatedUser);
//       if (mounted) {
//         setState(() {
//           _currentUser = updatedUser;
//           _isLoading = false;
//         });
//         print('Updated _currentUser.profilePhoto: ${_currentUser?.profilePhoto}');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur: $e')),
//         );
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   Future<File> convertToJpeg(File image) async {
//     final rawImage = await image.readAsBytes();
//     final decodedImage = img.decodeImage(rawImage);
//     if (decodedImage == null) throw Exception('Impossible de décoder l\'image');
//     final jpegImage = img.encodeJpg(decodedImage, quality: 85);
//     final tempDir = await getTemporaryDirectory();
//     final tempFile = File('${tempDir.path}/profile_photo.jpg');
//     await tempFile.writeAsBytes(jpegImage);
//     return tempFile;
//   }

//   Future<void> _pickImage() async {
//     try {
//       final permissionsGranted = await PermissionManager.checkAndRequestPermissions(context: context);
//       if (!permissionsGranted) {
//         return;
//       }

//       final source = await showDialog<ImageSource>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Changer la photo de profil'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Prendre une photo'),
//                 onTap: () => Navigator.pop(context, ImageSource.camera),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Choisir dans la galerie'),
//                 onTap: () => Navigator.pop(context, ImageSource.gallery),
//               ),
//             ],
//           ),
//         ),
//       );

//       if (source == null) return;

//       final XFile? pickedFile = await _picker.pickImage(
//         source: source,
//         maxWidth: 800,
//         maxHeight: 800,
//         imageQuality: 85,
//       ).catchError((e) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Erreur lors de la sélection de l\'image: $e')),
//           );
//         }
//         return null;
//       });

//       if (pickedFile == null) return;

//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur: $e')),
//         );
//       }
//     }
//   }

//   Future<void> _uploadProfilePhoto() async {
//     if (_selectedImage == null) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Veuillez sélectionner une image.')),
//         );
//       }
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       File imageToUpload = _selectedImage!;
//       if (_selectedImage!.path.endsWith('.png')) {
//         imageToUpload = await convertToJpeg(_selectedImage!);
//       }

//       final fileSize = await imageToUpload.length();
//       if (fileSize > 5 * 1024 * 1024) {
//         throw Exception('L\'image est trop volumineuse (max 5 Mo)');
//       }

//       final imageUrl = await ApiService.uploadProfilePhoto(imageToUpload);

//       if (imageUrl != null) {
//         await ApiService.updateUserProfile({'profilePhoto': imageUrl});
//         await CachedNetworkImageProvider(imageUrl).evict();
//         await _loadUserData();
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Photo de profil mise à jour')),
//           );
//           setState(() {
//             _selectedImage = null;
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur: $e')),
//         );
//       }
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   String? _formatDateForDisplay(String? date) {
//     if (date == null) return 'Non renseigné';
//     try {
//       final dateTime = DateTime.parse(date);
//       return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
//     } catch (e) {
//       return date;
//     }
//   }

//   String? _formatDateForApi(String date) {
//     try {
//       final parts = date.split('/');
//       if (parts.length != 3) return null;
//       final day = parts[0];
//       final month = parts[1];
//       final year = parts[2];
//       return '$year-$month-$day';
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<void> _editField(BuildContext context, String field, String currentValue) async {
//     if (field == 'birthdate') {
//       DateTime initialDate;
//       try {
//         final parts = currentValue.split('/');
//         if (parts.length == 3) {
//           initialDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
//         } else {
//           initialDate = DateTime.now();
//         }
//       } catch (e) {
//         initialDate = DateTime.now();
//       }
//       final selectedDate = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: DateTime(1900),
//         lastDate: DateTime.now(),
//       );
//       if (selectedDate != null) {
//         final formattedDate =
//             '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
//         await _saveUserData(field, formattedDate);
//       }
//       return;
//     }
//     final controller = TextEditingController(text: currentValue.replaceAll('Non renseigné', ''));
//     if (field == 'gender') {
//       String? result = await showDialog<String>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Modifier ${_getFieldTitle(field)}'),
//           content: DropdownButtonFormField<String>(
//             value: _currentUser?.gender ?? 'other',
//             decoration: const InputDecoration(labelText: 'Genre'),
//             items: ['male', 'female', 'other']
//                 .map((gender) => DropdownMenuItem(
//                       value: gender,
//                       child: Text(gender == 'male' ? 'Homme' : gender == 'female' ? 'Femme' : 'Autre'),
//                     ))
//                 .toList(),
//             onChanged: (value) {
//               if (value != null) {
//                 controller.text = value;
//                 setState(() {});
//               }
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Annuler'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, controller.text),
//               child: const Text('Sauvegarder'),
//             ),
//           ],
//         ),
//       );
//       if (result != null && result.isNotEmpty) {
//         await _saveUserData(field, result);
//       }
//       return;
//     }
//     String? result = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Modifier ${_getFieldTitle(field)}'),
//         content: TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
//             errorText: _validateField(field, controller.text) ? null : _getValidationErrorMessage(field),
//           ),
//           onChanged: (value) {
//             setState(() {});
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Annuler'),
//           ),
//           TextButton(
//             onPressed: () {
//               if (_validateField(field, controller.text)) {
//                 Navigator.pop(context, controller.text);
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(_getValidationErrorMessage(field))),
//                 );
//               }
//             },
//             child: const Text('Sauvegarder'),
//           ),
//         ],
//       ),
//     );
//     if (result != null && result.isNotEmpty) {
//       await _saveUserData(field, result);
//     }
//   }

//   Future<void> _saveUserData(String field, String value) async {
//     if (!_validateField(field, value)) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(_getValidationErrorMessage(field))),
//         );
//       }
//       return;
//     }
//     final apiKey = _mapToApiKey(field);
//     final apiValue = field == 'birthdate' ? _formatDateForApi(value) : value;
//     if (apiValue == null && field == 'birthdate') {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Format de date invalide (attendu: JJ/MM/AAAA)')),
//         );
//       }
//       return;
//     }
//     try {
//       await ApiService.updateUserProfile({apiKey: apiValue});
//       final userData = await ApiService.getUserProfile();
//       final updatedUser = UserModel.fromMap(userData);
//       if (updatedUser.id != _currentUser!.id) {
//         throw Exception('ID utilisateur incohérent dans la réponse');
//       }
//       await AuthService.saveUser(updatedUser);
//       if (mounted) {
//         setState(() {
//           _currentUser = updatedUser;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Mise à jour réussie')),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
//         );
//       }
//     }
//   }

//   bool _validateField(String key, String value) {
//     switch (key) {
//       case 'email':
//         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
//       case 'phone':
//         return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);
//       case 'birthdate':
//         try {
//           final parts = value.split('/');
//           if (parts.length != 3) return false;
//           final day = int.parse(parts[0]);
//           final month = int.parse(parts[1]);
//           final year = int.parse(parts[2]);
//           final date = DateTime(year, month, day);
//           return date.isBefore(DateTime.now()) && year >= 1900;
//         } catch (e) {
//           return false;
//         }
//       case 'gender':
//         return ['male', 'female', 'other'].contains(value.toLowerCase());
//       case 'name':
//         return value.trim().isNotEmpty && value.length <= 100;
//       case 'address':
//       case 'bloodType':
//       case 'allergies':
//       case 'emergencyContact':
//         return value.trim().isNotEmpty;
//       default:
//         return true;
//     }
//   }

//   String _getValidationErrorMessage(String key) {
//     switch (key) {
//       case 'email':
//         return 'Veuillez entrer un email valide (ex: nom@domaine.com)';
//       case 'phone':
//         return 'Veuillez entrer un numéro de téléphone valide (ex: +22890123456)';
//       case 'birthdate':
//         return 'Veuillez entrer une date de naissance valide (ex: 15/03/1990)';
//       case 'gender':
//         return 'Veuillez sélectionner un genre valide';
//       case 'name':
//         return 'Veuillez entrer un nom valide (non vide, max 100 caractères)';
//       case 'address':
//       case 'bloodType':
//       case 'allergies':
//       case 'emergencyContact':
//         return 'Ce champ ne peut pas être vide';
//       default:
//         return 'Valeur invalide';
//     }
//   }

//   String _mapToApiKey(String key) {
//     switch (key) {
//       case 'name':
//         return 'fullName';
//       case 'phone':
//         return 'phoneNumber';
//       case 'birthdate':
//         return 'dateOfBirth';
//       default:
//         return key;
//     }
//   }

//   String _getFieldTitle(String field) {
//     switch (field) {
//       case 'name':
//         return 'Nom complet';
//       case 'birthdate':
//         return 'Date de naissance';
//       case 'email':
//         return 'Email';
//       case 'phone':
//         return 'Téléphone';
//       case 'gender':
//         return 'Genre';
//       case 'address':
//         return 'Adresse';
//       case 'bloodType':
//         return 'Groupe sanguin';
//       case 'allergies':
//         return 'Allergies';
//       case 'emergencyContact':
//         return 'Contact d\'urgence';
//       default:
//         return field;
//     }
//   }

//   Widget _buildProfileHeader() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
//       decoration: BoxDecoration(
//         color: AppColors.primary,
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Stack(
//             alignment: Alignment.bottomRight,
//             children: [
//               CircleAvatar(
//                 radius: 50,
//                 child: ClipOval(
//                   child: _selectedImage != null
//                       ? Image.file(
//                           _selectedImage!,
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         )
//                       : RepaintBoundary(
//                           child: CachedNetworkImage(
//                             imageUrl: _currentUser?.profilePhoto ?? 'https://via.placeholder.com/150',
//                             cacheKey: '${_currentUser?.profilePhoto}_${DateTime.now().millisecondsSinceEpoch}',
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) => const CircularProgressIndicator(),
//                             errorWidget: (context, url, error) {
//                               print('CachedNetworkImage error: $error, URL: $url');
//                               return GestureDetector(
//                                 onTap: _loadUserData,
//                                 child: const Icon(
//                                   Icons.error,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: const Icon(
//                     Icons.camera_alt,
//                     color: AppColors.primary,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           if (_selectedImage != null) ...[
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _uploadProfilePhoto,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               child: _isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text(
//                       'Confirmer l\'upload',
//                       style: TextStyle(color: Colors.white),
//                     ),
//             ),
//           ],
//           const SizedBox(height: 16),
//           Text(
//             _currentUser?.fullTitle ?? 'Utilisateur',
//             style: const TextStyle(
//               fontSize: 24,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             _currentUser?.email ?? '',
//             style: const TextStyle(
//               color: Colors.white70,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoCard(IconData icon, String field, String value) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: InkWell(
//         onTap: () => _editField(context, field, value),
//         borderRadius: BorderRadius.circular(15),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: AppColors.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(icon, color: AppColors.primary, size: 24),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       _getFieldTitle(field),
//                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       value,
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(
//                 Icons.edit,
//                 color: AppColors.primary.withOpacity(0.5),
//                 size: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _generateQRCode(BuildContext context) {
//     final qrData = [
//       'Nom complet: ${_currentUser?.fullName ?? 'Non renseigné'}',
//       'Email: ${_currentUser?.email ?? 'Non renseigné'}',
//       'Téléphone: ${_currentUser?.phoneNumber ?? 'Non renseigné'}',
//       'Date de naissance: ${_formatDateForDisplay(_currentUser?.dateOfBirth)}',
//       'Genre: ${_currentUser?.gender ?? 'Non renseigné'}',
//       'Adresse: ${_currentUser?.address ?? 'Non renseigné'}',
//       'Groupe sanguin: ${_currentUser?.bloodType ?? 'Non renseigné'}',
//       'Allergies: ${_currentUser?.allergies ?? 'Non renseigné'}',
//       'Contact d\'urgence: ${_currentUser?.emergencyContact ?? 'Non renseigné'}',
//     ].join('\n');
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Code QR'),
//         content: SizedBox(
//           width: 200,
//           height: 250,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               WidgetsToImage(
//                 controller: controller,
//                 child: Container(
//                   color: Colors.white,
//                   child: QrImageView(
//                     data: qrData,
//                     version: QrVersions.auto,
//                     size: 200.0,
//                     gapless: false,
//                     errorStateBuilder: (context, error) {
//                       return const Center(child: Text('Erreur de génération du QR code'));
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text('Scannez ce code pour voir les informations.'),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               final bytes = await controller.capture();
//               if (bytes != null) {
//                 final directory = await getApplicationDocumentsDirectory();
//                 final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
//                 await file.writeAsBytes(bytes);
//                 if (mounted) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('QR code enregistré dans ${file.path}')),
//                   );
//                 }
//               }
//             },
//             child: const Text('Enregistrer'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Fermer'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading && _currentUser == null) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Mon Profil'),
//           backgroundColor: AppColors.primary,
//         ),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         title: const Text(
//           'Mon Profil',
//           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.white),
//             onPressed: () async {
//               final confirm = await showDialog<bool>(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Déconnexion'),
//                   content: const Text('Voulez-vous vraiment vous déconnecter ?'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context, false),
//                       child: const Text('Annuler'),
//                     ),
//                     TextButton(
//                       onPressed: () => Navigator.pop(context, true),
//                       child: const Text('Confirmer'),
//                     ),
//                   ],
//                 ),
//               );
//               if (confirm == true) {
//                 await AuthService.logout();
//                 if (mounted) {
//                   Navigator.pushReplacementNamed(context, '/signin');
//                 }
//               }
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildProfileHeader(),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   _buildInfoCard(Icons.person_outline, 'name', _currentUser?.fullName ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate',
//                       _formatDateForDisplay(_currentUser?.dateOfBirth) ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.email_outlined, 'email', _currentUser?.email ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.phone_outlined, 'phone', _currentUser?.phoneNumber ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.transgender, 'gender', _currentUser?.gender ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.location_on_outlined, 'address', _currentUser?.address ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _currentUser?.bloodType ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _currentUser?.allergies ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact',
//                       _currentUser?.emergencyContact ?? 'Non renseigné'),
//                   const SizedBox(height: 20),
//                   ElevatedButton.icon(
//                     onPressed: () => _generateQRCode(context),
//                     icon: const Icon(Icons.qr_code, color: Colors.white),
//                     label: const Text('Générer le code QR', style: TextStyle(color: Colors.white)),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:medical/permissions/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:widgets_to_image/widgets_to_image.dart';
// import 'package:image/image.dart' as img;
// import '../constants/app_colors.dart';
// import '../models/user_model.dart';
// import '../services/auth_service.dart';
// import '../services/api_service.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   UserModel? _currentUser;
//   bool _isLoading = false;
//   WidgetsToImageController controller = WidgetsToImageController();
//   final ImagePicker _picker = ImagePicker();
//   File? _selectedImage;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   Future<void> _loadUserData() async {
//     setState(() => _isLoading = true);
//     try {
//       _currentUser = await AuthService.getCurrentUser(forceRefresh: true);
//       if (_currentUser == null || _currentUser!.id.isEmpty) {
//         if (mounted) {
//           Navigator.pushReplacementNamed(context, '/signin');
//         }
//         return;
//       }
//       final userData = await ApiService.getUserProfile();
//       print('Profile Photo URL from API: ${userData['profilePhoto']}');
//       final updatedUser = UserModel.fromMap(userData);
//       if (updatedUser.id != _currentUser!.id) {
//         throw Exception('ID utilisateur incohérent dans la réponse');
//       }
//       await AuthService.saveUser(updatedUser);
//       if (mounted) {
//         setState(() {
//           _currentUser = updatedUser;
//           _isLoading = false;
//         });
//         print('Updated _currentUser.profilePhoto: ${_currentUser?.profilePhoto}');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur: $e')),
//         );
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   Future<File> convertToJpeg(File image) async {
//     final rawImage = await image.readAsBytes();
//     final decodedImage = img.decodeImage(rawImage);
//     if (decodedImage == null) throw Exception('Impossible de décoder l\'image');
//     final jpegImage = img.encodeJpg(decodedImage, quality: 85);
//     final tempDir = await getTemporaryDirectory();
//     final tempFile = File('${tempDir.path}/profile_photo.jpg');
//     await tempFile.writeAsBytes(jpegImage);
//     return tempFile;
//   }

//   Future<void> _pickImage() async {
//     try {
//       final permissionsGranted = await PermissionManager.checkAndRequestPermissions(context: context);
//       if (!permissionsGranted) {
//         return;
//       }

//       final source = await showDialog<ImageSource>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Changer la photo de profil'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Prendre une photo'),
//                 onTap: () => Navigator.pop(context, ImageSource.camera),
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Choisir dans la galerie'),
//                 onTap: () => Navigator.pop(context, ImageSource.gallery),
//               ),
//             ],
//           ),
//         ),
//       );

//       if (source == null) return;

//       final XFile? pickedFile = await _picker.pickImage(
//         source: source,
//         maxWidth: 800,
//         maxHeight: 800,
//         imageQuality: 85,
//       ).catchError((e) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Erreur lors de la sélection de l\'image: $e')),
//           );
//         }
//         return null;
//       });

//       if (pickedFile == null) return;

//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur: $e')),
//         );
//       }
//     }
//   }

//   Future<void> _uploadProfilePhoto() async {
//     if (_selectedImage == null) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Veuillez sélectionner une image.')),
//         );
//       }
//       return;
//     }

//     setState(() => _isLoading = true);

//     try {
//       File imageToUpload = _selectedImage!;
//       if (_selectedImage!.path.endsWith('.png')) {
//         imageToUpload = await convertToJpeg(_selectedImage!);
//       }

//       final fileSize = await imageToUpload.length();
//       if (fileSize > 5 * 1024 * 1024) {
//         throw Exception('L\'image est trop volumineuse (max 5 Mo)');
//       }

//       final imageUrl = await ApiService.uploadProfilePhoto(imageToUpload);

//       if (imageUrl != null) {
//         await ApiService.updateUserProfile({'profilePhoto': imageUrl});
//         await CachedNetworkImageProvider(imageUrl).evict();
//         await _loadUserData();
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Photo de profil mise à jour')),
//           );
//           setState(() {
//             _selectedImage = null;
//           });
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur: $e')),
//         );
//       }
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   String? _formatDateForDisplay(String? date) {
//     if (date == null) return 'Non renseigné';
//     try {
//       final dateTime = DateTime.parse(date);
//       return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
//     } catch (e) {
//       return date;
//     }
//   }

//   String? _formatDateForApi(String date) {
//     try {
//       final parts = date.split('/');
//       if (parts.length != 3) return null;
//       final day = parts[0];
//       final month = parts[1];
//       final year = parts[2];
//       return '$year-$month-$day';
//     } catch (e) {
//       return null;
//     }
//   }

//   Future<void> _editField(BuildContext context, String field, String currentValue) async {
//     if (field == 'birthdate') {
//       DateTime initialDate;
//       try {
//         final parts = currentValue.split('/');
//         if (parts.length == 3) {
//           initialDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
//         } else {
//           initialDate = DateTime.now();
//         }
//       } catch (e) {
//         initialDate = DateTime.now();
//       }
//       final selectedDate = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: DateTime(1900),
//         lastDate: DateTime.now(),
//       );
//       if (selectedDate != null) {
//         final formattedDate =
//             '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
//         await _saveUserData(field, formattedDate);
//       }
//       return;
//     }
//     final controller = TextEditingController(text: currentValue.replaceAll('Non renseigné', ''));
//     if (field == 'gender') {
//       String? result = await showDialog<String>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Modifier ${_getFieldTitle(field)}'),
//           content: DropdownButtonFormField<String>(
//             value: _currentUser?.gender ?? 'other',
//             decoration: const InputDecoration(labelText: 'Genre'),
//             items: ['male', 'female', 'other']
//                 .map((gender) => DropdownMenuItem(
//                       value: gender,
//                       child: Text(gender == 'male' ? 'Homme' : gender == 'female' ? 'Femme' : 'Autre'),
//                     ))
//                 .toList(),
//             onChanged: (value) {
//               if (value != null) {
//                 controller.text = value;
//                 setState(() {});
//               }
//             },
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Annuler'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, controller.text),
//               child: const Text('Sauvegarder'),
//             ),
//           ],
//         ),
//       );
//       if (result != null && result.isNotEmpty) {
//         await _saveUserData(field, result);
//       }
//       return;
//     }
//     String? result = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Modifier ${_getFieldTitle(field)}'),
//         content: TextField(
//           controller: controller,
//           decoration: InputDecoration(
//             hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
//             errorText: _validateField(field, controller.text) ? null : _getValidationErrorMessage(field),
//           ),
//           onChanged: (value) {
//             setState(() {});
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Annuler'),
//           ),
//           TextButton(
//             onPressed: () {
//               if (_validateField(field, controller.text)) {
//                 Navigator.pop(context, controller.text);
//               } else {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(_getValidationErrorMessage(field))),
//                 );
//               }
//             },
//             child: const Text('Sauvegarder'),
//           ),
//         ],
//       ),
//     );
//     if (result != null && result.isNotEmpty) {
//       await _saveUserData(field, result);
//     }
//   }

//   Future<void> _saveUserData(String field, String value) async {
//     if (!_validateField(field, value)) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(_getValidationErrorMessage(field))),
//         );
//       }
//       return;
//     }
//     final apiKey = _mapToApiKey(field);
//     final apiValue = field == 'birthdate' ? _formatDateForApi(value) : value;
//     if (apiValue == null && field == 'birthdate') {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Format de date invalide (attendu: JJ/MM/AAAA)')),
//         );
//       }
//       return;
//     }
//     try {
//       await ApiService.updateUserProfile({apiKey: apiValue});
//       final userData = await ApiService.getUserProfile();
//       final updatedUser = UserModel.fromMap(userData);
//       if (updatedUser.id != _currentUser!.id) {
//         throw Exception('ID utilisateur incohérent dans la réponse');
//       }
//       await AuthService.saveUser(updatedUser);
//       if (mounted) {
//         setState(() {
//           _currentUser = updatedUser;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Mise à jour réussie')),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
//         );
//       }
//     }
//   }

//   bool _validateField(String key, String value) {
//     switch (key) {
//       case 'email':
//         return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
//       case 'phone':
//         return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);
//       case 'birthdate':
//         try {
//           final parts = value.split('/');
//           if (parts.length != 3) return false;
//           final day = int.parse(parts[0]);
//           final month = int.parse(parts[1]);
//           final year = int.parse(parts[2]);
//           final date = DateTime(year, month, day);
//           return date.isBefore(DateTime.now()) && year >= 1900;
//         } catch (e) {
//           return false;
//         }
//       case 'gender':
//         return ['male', 'female', 'other'].contains(value.toLowerCase());
//       case 'name':
//         return value.trim().isNotEmpty && value.length <= 100;
//       case 'address':
//       case 'bloodType':
//       case 'allergies':
//       case 'emergencyContact':
//         return value.trim().isNotEmpty;
//       default:
//         return true;
//     }
//   }

//   String _getValidationErrorMessage(String key) {
//     switch (key) {
//       case 'email':
//         return 'Veuillez entrer un email valide (ex: nom@domaine.com)';
//       case 'phone':
//         return 'Veuillez entrer un numéro de téléphone valide (ex: +22890123456)';
//       case 'birthdate':
//         return 'Veuillez entrer une date de naissance valide (ex: 15/03/1990)';
//       case 'gender':
//         return 'Veuillez sélectionner un genre valide';
//       case 'name':
//         return 'Veuillez entrer un nom valide (non vide, max 100 caractères)';
//       case 'address':
//       case 'bloodType':
//       case 'allergies':
//       case 'emergencyContact':
//         return 'Ce champ ne peut pas être vide';
//       default:
//         return 'Valeur invalide';
//     }
//   }

//   String _mapToApiKey(String key) {
//     switch (key) {
//       case 'name':
//         return 'fullName';
//       case 'phone':
//         return 'phoneNumber';
//       case 'birthdate':
//         return 'dateOfBirth';
//       default:
//         return key;
//     }
//   }

//   String _getFieldTitle(String field) {
//     switch (field) {
//       case 'name':
//         return 'Nom complet';
//       case 'birthdate':
//         return 'Date de naissance';
//       case 'email':
//         return 'Email';
//       case 'phone':
//         return 'Téléphone';
//       case 'gender':
//         return 'Genre';
//       case 'address':
//         return 'Adresse';
//       case 'bloodType':
//         return 'Groupe sanguin';
//       case 'allergies':
//         return 'Allergies';
//       case 'emergencyContact':
//         return 'Contact d\'urgence';
//       default:
//         return field;
//     }
//   }

//   Widget _buildProfileHeader() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
//       decoration: BoxDecoration(
//         color: AppColors.primary,
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Stack(
//             alignment: Alignment.bottomRight,
//             children: [
//               CircleAvatar(
//                 radius: 50,
//                 child: ClipOval(
//                   child: _selectedImage != null
//                       ? Image.file(
//                           _selectedImage!,
//                           width: 100,
//                           height: 100,
//                           fit: BoxFit.cover,
//                         )
//                       : RepaintBoundary(
//                           child: CachedNetworkImage(
//                             imageUrl: _currentUser?.profilePhoto ?? 'https://via.placeholder.com/150',
//                             cacheKey: _currentUser?.profilePhoto ?? 'default_profile',
//                             width: 100,
//                             height: 100,
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) => const CircularProgressIndicator(),
//                             errorWidget: (context, url, error) {
//                               print('CachedNetworkImage error: $error, URL: $url');
//                               return GestureDetector(
//                                 onTap: _loadUserData,
//                                 child: const Icon(
//                                   Icons.error,
//                                   color: Colors.red,
//                                   size: 50,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.2),
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: const Icon(
//                     Icons.camera_alt,
//                     color: AppColors.primary,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           if (_selectedImage != null) ...[
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _uploadProfilePhoto,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               ),
//               child: _isLoading
//                   ? const CircularProgressIndicator(color: Colors.white)
//                   : const Text(
//                       'Confirmer l\'upload',
//                       style: TextStyle(color: Colors.white),
//                     ),
//             ),
//           ],
//           const SizedBox(height: 16),
//           Text(
//             _currentUser?.fullTitle ?? 'Utilisateur',
//             style: const TextStyle(
//               fontSize: 24,
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             _currentUser?.email ?? '',
//             style: const TextStyle(
//               color: Colors.white70,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoCard(IconData icon, String field, String value) {
//     return Card(
//       elevation: 2,
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: InkWell(
//         onTap: () => _editField(context, field, value),
//         borderRadius: BorderRadius.circular(15),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: AppColors.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(icon, color: AppColors.primary, size: 24),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       _getFieldTitle(field),
//                       style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       value,
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//               Icon(
//                 Icons.edit,
//                 color: AppColors.primary.withOpacity(0.5),
//                 size: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _generateQRCode(BuildContext context) {
//     final qrData = [
//       'Nom complet: ${_currentUser?.fullName ?? 'Non renseigné'}',
//       'Email: ${_currentUser?.email ?? 'Non renseigné'}',
//       'Téléphone: ${_currentUser?.phoneNumber ?? 'Non renseigné'}',
//       'Date de naissance: ${_formatDateForDisplay(_currentUser?.dateOfBirth)}',
//       'Genre: ${_currentUser?.gender ?? 'Non renseigné'}',
//       'Adresse: ${_currentUser?.address ?? 'Non renseigné'}',
//       'Groupe sanguin: ${_currentUser?.bloodType ?? 'Non renseigné'}',
//       'Allergies: ${_currentUser?.allergies ?? 'Non renseigné'}',
//       'Contact d\'urgence: ${_currentUser?.emergencyContact ?? 'Non renseigné'}',
//     ].join('\n');
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Code QR'),
//         content: SizedBox(
//           width: 200,
//           height: 250,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               WidgetsToImage(
//                 controller: controller,
//                 child: Container(
//                   color: Colors.white,
//                   child: QrImageView(
//                     data: qrData,
//                     version: QrVersions.auto,
//                     size: 200.0,
//                     gapless: false,
//                     errorStateBuilder: (context, error) {
//                       return const Center(child: Text('Erreur de génération du QR code'));
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               const Text('Scannez ce code pour voir les informations.'),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               final permissionsGranted = await PermissionManager.checkAndRequestStoragePermissions(context: context);
//               if (!permissionsGranted) return;
//               final bytes = await controller.capture();
//               if (bytes != null) {
//                 final directory = await getApplicationDocumentsDirectory();
//                 final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
//                 await file.writeAsBytes(bytes);
//                 if (mounted) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('QR code enregistré dans ${file.path}')),
//                   );
//                 }
//               }
//             },
//             child: const Text('Enregistrer'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Fermer'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading && _currentUser == null) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Mon Profil'),
//           backgroundColor: AppColors.primary,
//         ),
//         body: const Center(child: CircularProgressIndicator()),
//       );
//     }
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         title: const Text(
//           'Mon Profil',
//           style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout, color: Colors.white),
//             onPressed: () async {
//               final confirm = await showDialog<bool>(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text('Déconnexion'),
//                   content: const Text('Voulez-vous vraiment vous déconnecter ?'),
//                   actions: [
//                     TextButton(
//                       onPressed: () => Navigator.pop(context, false),
//                       child: const Text('Annuler'),
//                     ),
//                     TextButton(
//                       onPressed: () => Navigator.pop(context, true),
//                       child: const Text('Confirmer'),
//                     ),
//                   ],
//                 ),
//               );
//               if (confirm == true) {
//                 await AuthService.logout();
//                 if (mounted) {
//                   Navigator.pushReplacementNamed(context, '/signin');
//                 }
//               }
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildProfileHeader(),
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   _buildInfoCard(Icons.person_outline, 'name', _currentUser?.fullName ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.calendar_today_outlined, 'birthdate',
//                       _formatDateForDisplay(_currentUser?.dateOfBirth) ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.email_outlined, 'email', _currentUser?.email ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.phone_outlined, 'phone', _currentUser?.phoneNumber ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.transgender, 'gender', _currentUser?.gender ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.location_on_outlined, 'address', _currentUser?.address ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _currentUser?.bloodType ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _currentUser?.allergies ?? 'Non renseigné'),
//                   _buildInfoCard(Icons.emergency_outlined, 'emergencyContact',
//                       _currentUser?.emergencyContact ?? 'Non renseigné'),
//                   const SizedBox(height: 20),
//                   ElevatedButton.icon(
//                     onPressed: () => _generateQRCode(context),
//                     icon: const Icon(Icons.qr_code, color: Colors.white),
//                     label: const Text('Générer le code QR', style: TextStyle(color: Colors.white)),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.primary,
//                       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical/permissions/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:image/image.dart' as img;
import '../constants/app_colors.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _currentUser;
  bool _isLoading = false;
  WidgetsToImageController controller = WidgetsToImageController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    try {
      final user = await AuthService.getCurrentUser(forceRefresh: true);
      if (user == null || user.id.isEmpty) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/signin');
        }
        return;
      }
      if (mounted) {
        setState(() {
          _currentUser = user;
          _isLoading = false;
        });
        print('Loaded user: ${user.id}, profilePhoto: ${user.profilePhoto}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  Future<File> convertToJpeg(File image) async {
    final rawImage = await image.readAsBytes();
    final decodedImage = img.decodeImage(rawImage);
    if (decodedImage == null) throw Exception('Impossible de décoder l\'image');
    final jpegImage = img.encodeJpg(decodedImage, quality: 85);
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/profile_photo.jpg');
    await tempFile.writeAsBytes(jpegImage);
    return tempFile;
  }

  Future<void> _pickImage() async {
    try {
      final permissionsGranted = await PermissionManager.checkAndRequestPermissions(context: context);
      if (!permissionsGranted) {
        return;
      }

      final source = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Changer la photo de profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Prendre une photo'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choisir dans la galerie'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        ),
      );

      if (source == null) return;

      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      ).catchError((e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur lors de la sélection de l\'image: $e')),
          );
        }
        return null;
      });

      if (pickedFile == null) return;

      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  Future<void> _uploadProfilePhoto() async {
    if (_selectedImage == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez sélectionner une image.')),
        );
      }
      return;
    }

    setState(() => _isLoading = true);

    try {
      File imageToUpload = _selectedImage!;
      if (_selectedImage!.path.endsWith('.png')) {
        imageToUpload = await convertToJpeg(_selectedImage!);
      }

      final fileSize = await imageToUpload.length();
      if (fileSize > 5 * 1024 * 1024) {
        throw Exception('L\'image est trop volumineuse (max 5 Mo)');
      }

      final imageUrl = await ApiService.uploadProfilePhoto(imageToUpload);

      if (imageUrl != null) {
        await ApiService.updateUserProfile({'profilePhoto': imageUrl});
        await CachedNetworkImageProvider(imageUrl).evict();
        await _loadUserData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Photo de profil mise à jour')),
          );
          setState(() {
            _selectedImage = null;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String? _formatDateForDisplay(String? date) {
    if (date == null) return 'Non renseigné';
    try {
      final dateTime = DateTime.parse(date);
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }

  String? _formatDateForApi(String date) {
    try {
      final parts = date.split('/');
      if (parts.length != 3) return null;
      final day = parts[0];
      final month = parts[1];
      final year = parts[2];
      return '$year-$month-$day';
    } catch (e) {
      return null;
    }
  }

  Future<void> _editField(BuildContext context, String field, String currentValue) async {
    if (field == 'birthdate') {
      DateTime initialDate;
      try {
        final parts = currentValue.split('/');
        if (parts.length == 3) {
          initialDate = DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
        } else {
          initialDate = DateTime.now();
        }
      } catch (e) {
        initialDate = DateTime.now();
      }
      final selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (selectedDate != null) {
        final formattedDate =
            '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
        await _saveUserData(field, formattedDate);
      }
      return;
    }
    final controller = TextEditingController(text: currentValue.replaceAll('Non renseigné', ''));
    if (field == 'gender') {
      String? result = await showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Modifier ${_getFieldTitle(field)}'),
          content: DropdownButtonFormField<String>(
            value: _currentUser?.gender ?? 'other',
            decoration: const InputDecoration(labelText: 'Genre'),
            items: ['male', 'female', 'other']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender == 'male' ? 'Homme' : gender == 'female' ? 'Femme' : 'Autre'),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                controller.text = value;
                setState(() {});
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Sauvegarder'),
            ),
          ],
        ),
      );
      if (result != null && result.isNotEmpty) {
        await _saveUserData(field, result);
      }
      return;
    }
    String? result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Modifier ${_getFieldTitle(field)}'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
            errorText: _validateField(field, controller.text) ? null : _getValidationErrorMessage(field),
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              if (_validateField(field, controller.text)) {
                Navigator.pop(context, controller.text);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_getValidationErrorMessage(field))),
                );
              }
            },
            child: const Text('Sauvegarder'),
          ),
        ],
      ),
    );
    if (result != null && result.isNotEmpty) {
      await _saveUserData(field, result);
    }
  }

  Future<void> _saveUserData(String field, String value) async {
    if (!_validateField(field, value)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_getValidationErrorMessage(field))),
        );
      }
      return;
    }
    final apiKey = _mapToApiKey(field);
    final apiValue = field == 'birthdate' ? _formatDateForApi(value) : value;
    if (apiValue == null && field == 'birthdate') {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Format de date invalide (attendu: JJ/MM/AAAA)')),
        );
      }
      return;
    }
    try {
      await ApiService.updateUserProfile({apiKey: apiValue});
      final userData = await ApiService.getUserProfile();
      final updatedUser = UserModel.fromMap(userData);
      if (updatedUser.id != _currentUser!.id) {
        throw Exception('ID utilisateur incohérent dans la réponse');
      }
      await AuthService.saveUserAndToken(updatedUser, await AuthService.getToken() ?? '');
      if (mounted) {
        setState(() {
          _currentUser = updatedUser;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mise à jour réussie')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la mise à jour: $e')),
        );
      }
    }
  }

  bool _validateField(String key, String value) {
    switch (key) {
      case 'email':
        return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
      case 'phone':
        return RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value);
      case 'birthdate':
        try {
          final parts = value.split('/');
          if (parts.length != 3) return false;
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          final date = DateTime(year, month, day);
          return date.isBefore(DateTime.now()) && year >= 1900;
        } catch (e) {
          return false;
        }
      case 'gender':
        return ['male', 'female', 'other'].contains(value.toLowerCase());
      case 'name':
        return value.trim().isNotEmpty && value.length <= 100;
      case 'address':
      case 'bloodType':
      case 'allergies':
      case 'emergencyContact':
        return value.trim().isNotEmpty;
      default:
        return true;
    }
  }

  String _getValidationErrorMessage(String key) {
    switch (key) {
      case 'email':
        return 'Veuillez entrer un email valide (ex: nom@domaine.com)';
      case 'phone':
        return 'Veuillez entrer un numéro de téléphone valide (ex: +22890123456)';
      case 'birthdate':
        return 'Veuillez entrer une date de naissance valide (ex: 15/03/1990)';
      case 'gender':
        return 'Veuillez sélectionner un genre valide';
      case 'name':
        return 'Veuillez entrer un nom valide (non vide, max 100 caractères)';
      case 'address':
      case 'bloodType':
      case 'allergies':
      case 'emergencyContact':
        return 'Ce champ ne peut pas être vide';
      default:
        return 'Valeur invalide';
    }
  }

  String _mapToApiKey(String key) {
    switch (key) {
      case 'name':
        return 'fullName';
      case 'phone':
        return 'phoneNumber';
      case 'birthdate':
        return 'dateOfBirth';
      default:
        return key;
    }
  }

  String _getFieldTitle(String field) {
    switch (field) {
      case 'name':
        return 'Nom complet';
      case 'birthdate':
        return 'Date de naissance';
      case 'email':
        return 'Email';
      case 'phone':
        return 'Téléphone';
      case 'gender':
        return 'Genre';
      case 'address':
        return 'Adresse';
      case 'bloodType':
        return 'Groupe sanguin';
      case 'allergies':
        return 'Allergies';
      case 'emergencyContact':
        return 'Contact d\'urgence';
      default:
        return field;
    }
  }

  Widget _buildProfileHeader() {
    final profilePhoto = _currentUser?.profilePhoto;
    final isValidUrl = profilePhoto != null &&
        profilePhoto.isNotEmpty &&
        Uri.tryParse(profilePhoto)?.hasAbsolutePath == true &&
        profilePhoto != 'https://example.com/photo.jpg';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                child: ClipOval(
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : RepaintBoundary(
                          child: CachedNetworkImage(
                            imageUrl: isValidUrl ? profilePhoto! : 'https://via.placeholder.com/150',
                            cacheKey: isValidUrl ? profilePhoto : 'default_profile',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) {
                              print('CachedNetworkImage error: $error, URL: $url');
                              return GestureDetector(
                                onTap: _loadUserData,
                                child: const Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                  size: 100,
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: AppColors.primary,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          if (_selectedImage != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _uploadProfilePhoto,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Confirmer l\'upload',
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ],
          const SizedBox(height: 16),
          Text(
            _currentUser?.fullTitle ?? 'Utilisateur',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _currentUser?.email ?? '',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String field, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => _editField(context, field, value),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getFieldTitle(field),
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit,
                color: AppColors.primary.withOpacity(0.5),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _generateQRCode(BuildContext context) {
    final qrData = [
      'Nom complet: ${_currentUser?.fullName ?? 'Non renseigné'}',
      'Email: ${_currentUser?.email ?? 'Non renseigné'}',
      'Téléphone: ${_currentUser?.phoneNumber ?? 'Non renseigné'}',
      'Date de naissance: ${_formatDateForDisplay(_currentUser?.dateOfBirth)}',
      'Genre: ${_currentUser?.gender ?? 'Non renseigné'}',
      'Adresse: ${_currentUser?.address ?? 'Non renseigné'}',
      'Groupe sanguin: ${_currentUser?.bloodType ?? 'Non renseigné'}',
      'Allergies: ${_currentUser?.allergies ?? 'Non renseigné'}',
      'Contact d\'urgence: ${_currentUser?.emergencyContact ?? 'Non renseigné'}',
    ].join('\n');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Code QR'),
        content: SizedBox(
          width: 200,
          height: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WidgetsToImage(
                controller: controller,
                child: Container(
                  color: Colors.white,
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 200.0,
                    gapless: false,
                    errorStateBuilder: (context, error) {
                      return const Center(child: Text('Erreur de génération du QR code'));
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Scannez ce code pour voir les informations.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final permissionsGranted = await PermissionManager.checkAndRequestStoragePermissions(context: context);
              if (!permissionsGranted) return;
              final bytes = await controller.capture();
              if (bytes != null) {
                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png');
                await file.writeAsBytes(bytes);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('QR code enregistré dans ${file.path}')),
                  );
                }
              }
            },
            child: const Text('Enregistrer'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mon Profil'),
          backgroundColor: AppColors.primary,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Mon Profil',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Déconnexion'),
                  content: const Text('Voulez-vous vraiment vous déconnecter ?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Confirmer'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await AuthService.logout();
                if (mounted) {
                  Navigator.pushReplacementNamed(context, '/signin');
                }
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoCard(Icons.person_outline, 'name', _currentUser?.fullName ?? 'Non renseigné'),
                  _buildInfoCard(Icons.calendar_today_outlined, 'birthdate',
                      _formatDateForDisplay(_currentUser?.dateOfBirth) ?? 'Non renseigné'),
                  _buildInfoCard(Icons.email_outlined, 'email', _currentUser?.email ?? 'Non renseigné'),
                  _buildInfoCard(Icons.phone_outlined, 'phone', _currentUser?.phoneNumber ?? 'Non renseigné'),
                  _buildInfoCard(Icons.transgender, 'gender', _currentUser?.gender ?? 'Non renseigné'),
                  _buildInfoCard(Icons.location_on_outlined, 'address', _currentUser?.address ?? 'Non renseigné'),
                  _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _currentUser?.bloodType ?? 'Non renseigné'),
                  _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _currentUser?.allergies ?? 'Non renseigné'),
                  _buildInfoCard(Icons.emergency_outlined, 'emergencyContact',
                      _currentUser?.emergencyContact ?? 'Non renseigné'),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _generateQRCode(context),
                    icon: const Icon(Icons.qr_code, color: Colors.white),
                    label: const Text('Générer le code QR', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}