// import 'package:flutter/material.dart';
// import '../constants/app_colors.dart'; // Assurez-vous d'importer vos couleurs

// class SpecialistProfileScreen extends StatefulWidget {
//   final Map<String, dynamic> specialist;

//   const SpecialistProfileScreen({Key? key, required this.specialist}) : super(key: key);

//   @override
//   State<SpecialistProfileScreen> createState() => _SpecialistProfileScreenState();
// }

// class _SpecialistProfileScreenState extends State<SpecialistProfileScreen> {
//   DateTime? selectedDate;
//   TimeOfDay? selectedTime;
//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController timeController = TextEditingController();
//   final TextEditingController subjectController = TextEditingController();
//   String? appointmentType; // Type de rendez-vous : à domicile, à l'hôpital, en ligne
//   final List<String> weekDays = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi'];

//   // Prix des consultations par type
//   final Map<String, String> consultationPrices = {
//     'À domicile': '10 000 FCFA',
//     'À l\'hôpital': '8 000 FCFA',
//     'En ligne': '5 000 FCFA',
//   };
   
//   // Horaires disponibles par jour
//   final Map<int, List<TimeOfDay>> availableHours = {
//     DateTime.monday: [
//       const TimeOfDay(hour: 8, minute: 0),
//       const TimeOfDay(hour: 9, minute: 0),
//       const TimeOfDay(hour: 10, minute: 0),
//       const TimeOfDay(hour: 14, minute: 0),
//       const TimeOfDay(hour: 15, minute: 0),
//       const TimeOfDay(hour: 16, minute: 0),
//     ],
//     DateTime.tuesday: [
//       const TimeOfDay(hour: 9, minute: 0),
//       const TimeOfDay(hour: 10, minute: 0),
//       const TimeOfDay(hour: 11, minute: 0),
//       const TimeOfDay(hour: 14, minute: 0),
//       const TimeOfDay(hour: 15, minute: 0),
//     ],
//     DateTime.wednesday: [
//       const TimeOfDay(hour: 8, minute: 0),
//       const TimeOfDay(hour: 9, minute: 0),
//       const TimeOfDay(hour: 10, minute: 0),
//       const TimeOfDay(hour: 14, minute: 0),
//       const TimeOfDay(hour: 15, minute: 0),
//     ],
//     DateTime.thursday: [
//       const TimeOfDay(hour: 9, minute: 0),
//       const TimeOfDay(hour: 10, minute: 0),
//       const TimeOfDay(hour: 11, minute: 0),
//       const TimeOfDay(hour: 14, minute: 0),
//       const TimeOfDay(hour: 15, minute: 0),
//     ],
//     DateTime.friday: [
//       const TimeOfDay(hour: 8, minute: 0),
//       const TimeOfDay(hour: 9, minute: 0),
//       const TimeOfDay(hour: 10, minute: 0),
//       const TimeOfDay(hour: 14, minute: 0),
//       const TimeOfDay(hour: 15, minute: 0),
//     ],
//   };

//   List<TimeOfDay> getAvailableHoursForDate(DateTime date) {
//     return availableHours[date.weekday] ?? [];
//   }

//   void _showTimeSelectionDialog(DateTime date) {
//     final List<TimeOfDay> hours = getAvailableHoursForDate(date);

//     showDialog(
//       context: context,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Horaires disponibles',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               if (hours.isEmpty)
//                 const Text(
//                   'Aucun horaire disponible pour cette date',
//                   style: TextStyle(color: Colors.grey),
//                 )
//               else
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: hours.map((time) {
//                     return ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           selectedTime = time;
//                           timeController.text = '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
//                         });
//                         Navigator.pop(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primary,
//                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       child: Text(
//                         '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               const SizedBox(height: 16),
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Fermer'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirmer le rendez-vous'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Médecin : ${widget.specialist['name']}'),
//             Text('Date : ${dateController.text}'),
//             Text('Heure : ${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}'),
//             Text('Objet : ${subjectController.text}'),
//             Text('Type : $appointmentType'),
//             Text('Prix : ${consultationPrices[appointmentType]}'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Annuler'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text('Rendez-vous confirmé !'),
//                 ),
//               );
//             },
//             child: const Text('Confirmer'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     dateController.dispose();
//     timeController.dispose();
//     subjectController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.specialist['name']),
//         //backgroundColor: AppColors.primary,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.message),
//             onPressed: () {
//               // Action pour envoyer un message
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 60,
//                 backgroundImage: AssetImage(widget.specialist['image']),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Center(
//               child: Text(
//                 widget.specialist['name'],
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Center(
//               child: Text(
//                 widget.specialist['specialty'],
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontStyle: FontStyle.italic,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Action pour appeler
//                   },
//                   icon: const Icon(Icons.call, color: Colors.green),
//                   label: const Text('Appeler', style: TextStyle(fontSize: 16, color: Colors.white)),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                 ),
//                 ElevatedButton.icon(
//                   onPressed: () {
//                     // Action pour message
//                   },
//                   icon: const Icon(Icons.message,color:  Colors.blueAccent ),
//                   label: const Text('Message', style: TextStyle(fontSize: 16, color: Colors.white),),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primary,
//                     padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             const Text(
//               'Informations supplémentaires',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 24),

//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Prendre un rendez-vous',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: weekDays.map((day) {
//                         return ElevatedButton(
//                           onPressed: () {
//                             final DateTime now = DateTime.now();
//                             final DateTime nextDay = now.add(Duration(days: (DateTime.monday - now.weekday) % 7));
//                             final DateTime selectedDay = nextDay.add(Duration(days: weekDays.indexOf(day)));

//                             setState(() {
//                               selectedDate = selectedDay;
//                               dateController.text = '${selectedDay.day}/${selectedDay.month}/${selectedDay.year}';
//                               selectedTime = null;
//                               timeController.clear();
//                             });
//                             _showTimeSelectionDialog(selectedDay);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.primary,
//                             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                           child: Text(
//                             day,
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: timeController,
//                       decoration: const InputDecoration(
//                         labelText: 'Heure du rendez-vous',
//                         suffixIcon: Icon(Icons.access_time),
//                         border: OutlineInputBorder(),
//                       ),
//                       readOnly: true,
//                       onTap: () {
//                         if (selectedDate != null) {
//                           _showTimeSelectionDialog(selectedDate!);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text('Veuillez d\'abord sélectionner une date'),
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: subjectController,
//                       decoration: const InputDecoration(
//                         labelText: 'Objet du rendez-vous',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     const Text(
//                       'Type de rendez-vous',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         RadioListTile<String>(
//                           title: Text('À domicile - ${consultationPrices['À domicile']}'),
//                           value: 'À domicile',
//                           groupValue: appointmentType,
//                           onChanged: (value) {
//                             setState(() {
//                               appointmentType = value;
//                             });
//                           },
//                         ),
//                         RadioListTile<String>(
//                           title: Text('À l\'hôpital - ${consultationPrices['À l\'hôpital']}'),
//                           value: 'À l\'hôpital',
//                           groupValue: appointmentType,
//                           onChanged: (value) {
//                             setState(() {
//                               appointmentType = value;
//                             });
//                           },
//                         ),
//                         RadioListTile<String>(
//                           title: Text('En ligne - ${consultationPrices['En ligne']}'),
//                           value: 'En ligne',
//                           groupValue: appointmentType,
//                           onChanged: (value) {
//                             setState(() {
//                               appointmentType = value;
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     SizedBox(
//   width: double.infinity,
//   child: ElevatedButton(
//     onPressed: selectedDate != null && selectedTime != null && subjectController.text.isNotEmpty && appointmentType != null
//         ? _showConfirmationDialog
//         : null,
//     style: ElevatedButton.styleFrom(
//       backgroundColor: AppColors.primary, // Couleur de fond
//       padding: const EdgeInsets.symmetric(vertical: 16), // Padding uniforme
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(5), // Bordure arrondie
//       ),
//     ),
//     child: const Text(
//       'Confirmer le rendez-vous',
//       style: TextStyle(fontSize: 16, color: Colors.white), // Texte en blanc
//     ),
//   ),
// ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),

//             const Text(
//               'Avis des patients',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: 5,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(Icons.person, size: 24),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Patient ${index + 1}',
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           'Très bon spécialiste, je recommande !',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: List.generate(
//                             5,
//                             (starIndex) => Icon(
//                               Icons.star,
//                               color: starIndex < 4 ? Colors.amber : Colors.grey,
//                               size: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 16),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Action pour laisser un avis
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                 ),
//                 child: const Text(
//                   'Laisser un avis',
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




// // lib/screens/specialist_profile_screen.dart
// import 'package:flutter/material.dart';

// class SpecialistProfileScreen extends StatelessWidget {
//   final Map<String, dynamic> specialist;

//   const SpecialistProfileScreen({super.key, required this.specialist});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(specialist['fullName'] ?? 'Spécialiste'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('ID: ${specialist['id'] ?? 'N/A'}'),
//             Text('Nom: ${specialist['fullName'] ?? 'N/A'}'),
//             Text('Spécialité: ${specialist['specialty'] ?? 'Non spécifiée'}'),
//             Text('Email: ${specialist['email'] ?? 'N/A'}'),
//             Text('Rôle: ${specialist['role'] ?? 'N/A'}'),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:medical/constants/app_colors.dart';
// import 'package:medical/config.dart'; // Assuming Config.baseUrl is defined here

// class SpecialistProfileScreen extends StatefulWidget {
//   final Map<String, dynamic> specialist;

//   const SpecialistProfileScreen({super.key, required this.specialist});

//   @override
//   State<SpecialistProfileScreen> createState() => _SpecialistProfileScreenState();
// }

// class _SpecialistProfileScreenState extends State<SpecialistProfileScreen> {
//   late String specialty;
//   late String profilePhoto;
//   late String about;
//   late Map<int, List<TimeOfDay>> availableHours;
//   late Map<String, String> consultationPrices;
//   List<Map<String, dynamic>> appointments = [];
//   List<Map<String, dynamic>> comments = [];

//   @override
//   void initState() {
//     super.initState();
//     specialty = widget.specialist['specialty'] ?? 'Médecin généraliste';
//     profilePhoto = widget.specialist['image'] ?? 'https://via.placeholder.com/150';
//     about = widget.specialist['about'] ?? 'Pas de description pour le moment.';
//     availableHours = widget.specialist['availableHours'] != null
//         ? Map<int, List<TimeOfDay>>.from(widget.specialist['availableHours'].map(
//             (k, v) => MapEntry(int.parse(k), (v as List).map((t) => TimeOfDay(hour: t['hour'], minute: t['minute'])).toList())))
//         : {
//             DateTime.monday: [const TimeOfDay(hour: 9, minute: 0)],
//             DateTime.tuesday: [const TimeOfDay(hour: 9, minute: 0)],
//             DateTime.wednesday: [const TimeOfDay(hour: 9, minute: 0)],
//             DateTime.thursday: [const TimeOfDay(hour: 9, minute: 0)],
//             DateTime.friday: [const TimeOfDay(hour: 9, minute: 0)],
//           };
//     consultationPrices = widget.specialist['consultationPrices'] != null
//         ? Map<String, String>.from(widget.specialist['consultationPrices'])
//         : {
//             'À domicile': '10 000 FCFA',
//             'À l\'hôpital': '8 000 FCFA',
//             'En ligne': '5 000 FCFA',
//           };
//     fetchAppointments();
//     fetchComments();
//   }

//   Future<void> fetchAppointments() async {
//     // Mock API call
//     setState(() {
//       appointments = [
//         {'id': '1', 'patient': 'Patient 1', 'date': '2025-03-24', 'time': '09:00', 'type': 'En ligne'},
//         {'id': '2', 'patient': 'Patient 2', 'date': '2025-03-25', 'time': '14:00', 'type': 'À l\'hôpital'},
//       ];
//     });
//     // Uncomment and adjust for real API
//     // final response = await http.get(Uri.parse('${Config.baseUrl}/appointments?specialistId=${widget.specialist['id']}'));
//     // if (response.statusCode == 200) {
//     //   setState(() => appointments = List<Map<String, dynamic>>.from(jsonDecode(response.body)));
//     // }
//   }

//   Future<void> fetchComments() async {
//     // Mock API call
//     setState(() {
//       comments = [
//         {'id': '1', 'patient': 'Patient 1', 'text': 'Très bon médecin !', 'rating': 4},
//         {'id': '2', 'patient': 'Patient 2', 'text': 'Pas mal.', 'rating': 3},
//       ];
//     });
//     // Uncomment and adjust for real API
//     // final response = await http.get(Uri.parse('${Config.baseUrl}/comments?specialistId=${widget.specialist['id']}'));
//     // if (response.statusCode == 200) {
//     //   setState(() => comments = List<Map<String, dynamic>>.from(jsonDecode(response.body)));
//     // }
//   }

//   Future<void> updateProfile() async {
//     final updatedData = {
//       'specialty': specialty,
//       'profilePhoto': profilePhoto,
//       'about': about,
//       'availableHours': availableHours.map((k, v) => MapEntry(k.toString(), v.map((t) => {'hour': t.hour, 'minute': t.minute}).toList())),
//       'consultationPrices': consultationPrices,
//     };
//     // Mock API call
//     print('Updating profile: $updatedData');
//     // Uncomment and adjust for real API
//     // final response = await http.put(
//     //   Uri.parse('${Config.baseUrl}/users/${widget.specialist['id']}'),
//     //   headers: {'Content-Type': 'application/json'},
//     //   body: jsonEncode(updatedData),
//     // );
//     // if (response.statusCode == 200) {
//     //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil mis à jour !')));
//     // }
//   }

//   void deleteComment(String commentId) async {
//     // Mock API call
//     setState(() {
//       comments.removeWhere((comment) => comment['id'] == commentId);
//     });
//     // Uncomment and adjust for real API
//     // final response = await http.delete(Uri.parse('${Config.baseUrl}/comments/$commentId'));
//     // if (response.statusCode == 200) {
//     //   setState(() => comments.removeWhere((comment) => comment['id'] == commentId));
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.specialist['name'] ?? 'Mon Profil'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Profile Photo
//             Center(
//               child: GestureDetector(
//                 onTap: () async {
//                   // Logic to update photo (e.g., image picker)
//                   setState(() => profilePhoto = 'https://via.placeholder.com/200');
//                   await updateProfile();
//                 },
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundImage: NetworkImage(profilePhoto),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Center(child: Text(widget.specialist['name'] ?? 'Spécialiste', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
//             const SizedBox(height: 8),

//             // Specialty
//             TextField(
//               decoration: const InputDecoration(labelText: 'Spécialité', border: OutlineInputBorder()),
//               controller: TextEditingController(text: specialty),
//               onChanged: (value) => setState(() => specialty = value),
//             ),
//             const SizedBox(height: 16),

//             // About Section
//             TextField(
//               decoration: const InputDecoration(labelText: 'À propos', border: OutlineInputBorder()),
//               controller: TextEditingController(text: about),
//               maxLines: 3,
//               onChanged: (value) => setState(() => about = value),
//             ),
//             const SizedBox(height: 24),

//             // Appointments
//             const Text('Mes Rendez-vous', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: appointments.length,
//               itemBuilder: (context, index) {
//                 final apt = appointments[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text('${apt['patient']} - ${apt['type']}'),
//                     subtitle: Text('${apt['date']} à ${apt['time']}'),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.chat),
//                       onPressed: () {
//                         // Navigate to chat screen with appointment context
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 24),

//             // Availability
//             const Text('Disponibilité hebdomadaire', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             ...availableHours.entries.map((entry) {
//               return Row(
//                 children: [
//                   Expanded(child: Text(DateTime.now().add(Duration(days: entry.key - DateTime.now().weekday)).toString().split(' ')[0])),
//                   ElevatedButton(
//                     onPressed: () async {
//                       final hours = await _editAvailability(entry.value);
//                       if (hours != null) {
//                         setState(() => availableHours[entry.key] = hours);
//                         await updateProfile();
//                       }
//                     },
//                     child: const Text('Modifier'),
//                   ),
//                 ],
//               );
//             }),
//             const SizedBox(height: 24),

//             // Consultation Prices
//             const Text('Prix des consultations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             ...consultationPrices.entries.map((entry) {
//               return TextField(
//                 decoration: InputDecoration(labelText: entry.key, border: const OutlineInputBorder()),
//                 controller: TextEditingController(text: entry.value),
//                 onChanged: (value) => setState(() => consultationPrices[entry.key] = value),
//               );
//             }),
//             const SizedBox(height: 24),

//             // Comments
//             const Text('Avis des patients', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 8),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: comments.length,
//               itemBuilder: (context, index) {
//                 final comment = comments[index];
//                 return Card(
//                   child: ListTile(
//                     title: Text(comment['patient']),
//                     subtitle: Text(comment['text']),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () => deleteComment(comment['id']),
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 24),

//             // Save Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: updateProfile,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 child: const Text('Enregistrer les modifications', style: TextStyle(color: Colors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<List<TimeOfDay>?> _editAvailability(List<TimeOfDay> currentHours) async {
//     List<TimeOfDay> newHours = List.from(currentHours);
//     return await showDialog<List<TimeOfDay>>(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setDialogState) => AlertDialog(
//           title: const Text('Modifier les horaires'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ...newHours.map((time) => Row(
//                     children: [
//                       Text('${time.hour}:${time.minute.toString().padLeft(2, '0')}'),
//                       IconButton(
//                         icon: const Icon(Icons.delete),
//                         onPressed: () => setDialogState(() => newHours.remove(time)),
//                       ),
//                     ],
//                   )),
//               TextButton(
//                 onPressed: () async {
//                   final time = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 9, minute: 0));
//                   if (time != null) setDialogState(() => newHours.add(time));
//                 },
//                 child: const Text('Ajouter un horaire'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, null),
//               child: const Text('Annuler'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.pop(context, newHours),
//               child: const Text('Enregistrer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/app_colors.dart';
import '../config.dart';
import '../services/auth_service.dart';
import '../widgets/review_card.dart';

class SpecialistProfileScreen extends StatefulWidget {
  final Map<String, dynamic> specialist;

  const SpecialistProfileScreen({super.key, required this.specialist});

  @override
  State<SpecialistProfileScreen> createState() => _SpecialistProfileScreenState();
}

class _SpecialistProfileScreenState extends State<SpecialistProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> specialistData;
  List<Map<String, dynamic>> reviews = [];
  bool _isLoading = true;
  bool _isReviewsLoading = true;
  int _selectedTabIndex = 0;

  // Appointment controllers
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  // Review controllers
  final TextEditingController _reviewCommentController = TextEditingController();
  double _reviewRating = 0.0;

  // Appointment states
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _appointmentType;

  // Constants
  static const List<String> _weekDays = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi'];
  static const Map<String, String> _defaultConsultationPrices = {
    'À domicile': '10 000 FCFA',
    'À l\'hôpital': '8 000 FCFA',
    'En ligne': '5 000 FCFA',
  };
  static const Map<int, List<TimeOfDay>> _defaultAvailableHours = {
    DateTime.monday: [TimeOfDay(hour: 9, minute: 0)],
    DateTime.tuesday: [TimeOfDay(hour: 9, minute: 0)],
    DateTime.wednesday: [TimeOfDay(hour: 9, minute: 0)],
    DateTime.thursday: [TimeOfDay(hour: 9, minute: 0)],
    DateTime.friday: [TimeOfDay(hour: 9, minute: 0)],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    specialistData = {
      ...widget.specialist,
      'name': widget.specialist['fullName'] ?? 'Spécialiste inconnu',
      'image': widget.specialist['profilePhoto'] ?? 'https://via.placeholder.com/400',
      'consultationPrices': _defaultConsultationPrices,
      'availableHours': _defaultAvailableHours,
      'experience': widget.specialist['experience'] ?? 'Non spécifié',
      'languages': widget.specialist['languages'] ?? 'Français',
      'location': widget.specialist['location'] ?? 'Non spécifié',
    };
    _loadSpecialistData();
    _loadReviews();
  }

  Future<void> _loadSpecialistData() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Utilisateur non authentifié');

      final response = await http.get(
        Uri.parse('${Config.usersUrl}/${widget.specialist['id']}'),
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      ).timeout(Config.timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          specialistData = {
            ...data,
            'name': data['fullName'] ?? 'Spécialiste inconnu',
            'image': data['profilePhoto'] ?? 'https://via.placeholder.com/400',
            'consultationPrices': data['consultationPrices'] != null
                ? Map<String, String>.from(data['consultationPrices'])
                : _defaultConsultationPrices,
            'availableHours': data['availableHours'] != null
                ? Map<int, List<TimeOfDay>>.from(data['availableHours'].map(
                    (k, v) => MapEntry(
                      int.parse(k),
                      (v as List).map((t) => TimeOfDay(hour: t['hour'], minute: t['minute'])).toList(),
                    ),
                  ))
                : _defaultAvailableHours,
            'experience': data['experience'] ?? 'Non spécifié',
            'languages': data['languages'] ?? 'Français',
            'location': data['location'] ?? 'Non spécifié',
          };
          _isLoading = false;
        });
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement du profil: $e')),
        );
      }
    }
  }

  Future<void> _loadReviews() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Utilisateur non authentifié');

      final response = await http.get(
        Uri.parse('${Config.usersUrl}/${widget.specialist['id']}/reviews'),
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      ).timeout(Config.timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          reviews = List<Map<String, dynamic>>.from(data);
          _isReviewsLoading = false;
        });
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      setState(() => _isReviewsLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement des avis: $e')),
        );
      }
    }
  }

  Future<void> _submitReview() async {
    if (_reviewCommentController.text.isEmpty || _reviewRating == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez entrer un commentaire et une note')),
      );
      return;
    }

    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Utilisateur non authentifié');

      final requestBody = {
        'comment': _reviewCommentController.text,
        'rating': _reviewRating,
      };

      final response = await http.post(
        Uri.parse('${Config.usersUrl}/${widget.specialist['id']}/reviews'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      ).timeout(Config.timeoutDuration);

      if (response.statusCode == 201) {
        setState(() {
          reviews.insert(0, {
            'user': 'Vous',
            'comment': _reviewCommentController.text,
            'rating': _reviewRating,
          });
          _reviewCommentController.clear();
          _reviewRating = 0.0;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Avis soumis avec succès !')),
          );
        }
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la soumission de l\'avis: $e')),
        );
      }
    }
  }

  List<TimeOfDay> _getAvailableHoursForDate(DateTime date) {
    return specialistData['availableHours'][date.weekday] ?? [];
  }

  Future<void> _showTimeSelectionDialog(DateTime date) async {
    final hours = _getAvailableHoursForDate(date);
    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Horaires disponibles', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              if (hours.isEmpty)
                const Text('Aucun horaire disponible', style: TextStyle(color: Colors.grey))
              else
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: hours.map((time) => ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedTime = time;
                            _timeController.text = '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 2,
                        ),
                        child: Text(
                          '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )).toList(),
                ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer', style: TextStyle(color: AppColors.primary, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Confirmer le rendez-vous', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Médecin: ${specialistData['name']}', style: const TextStyle(fontSize: 16)),
            Text('Date: ${_dateController.text}', style: const TextStyle(fontSize: 16)),
            Text('Heure: ${_timeController.text}', style: const TextStyle(fontSize: 16)),
            Text('Objet: ${_subjectController.text}', style: const TextStyle(fontSize: 16)),
            Text('Type: $_appointmentType', style: const TextStyle(fontSize: 16)),
            Text('Prix: ${specialistData['consultationPrices'][_appointmentType]}', style: const TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler', style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await _bookAppointment();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
            ),
            child: const Text('Confirmer', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Future<void> _bookAppointment() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Utilisateur non authentifié');

      final requestBody = {
        'specialistId': specialistData['id'],
        'date': _dateController.text,
        'time': _timeController.text,
        'subject': _subjectController.text,
        'type': _appointmentType,
        'price': specialistData['consultationPrices'][_appointmentType],
      };

      final response = await http.post(
        Uri.parse('${Config.baseUrl}/appointments'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      ).timeout(Config.timeoutDuration);

      if (response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Rendez-vous confirmé !')),
          );
          setState(() {
            _dateController.clear();
            _timeController.clear();
            _subjectController.clear();
            _selectedDate = null;
            _selectedTime = null;
            _appointmentType = null;
          });
        }
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la réservation: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _subjectController.dispose();
    _reviewCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildSliverAppBar(),
        ],
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildTabContent(),
        ),
      ),
    );
  }

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      floating: false,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: specialistData['image'],
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator(color: AppColors.primary)),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.person, size: 120, color: Colors.grey),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.primary.withOpacity(0.8),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider(specialistData['image']),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    specialistData['name'],
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 4, color: Colors.black54, offset: Offset(0, 2))],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    specialistData['specialty'] ?? 'Non spécifiée',
                    style: const TextStyle(fontSize: 18, color: Colors.white70, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    return SingleChildScrollView(
      key: ValueKey(_selectedTabIndex),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton('Profil', 0),
                _buildTabButton('Rendez-vous', 1),
                _buildTabButton('Avis', 2),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: _selectedTabIndex == 0
                  ? _buildInfoTab()
                  : _selectedTabIndex == 1
                      ? _buildAppointmentTab()
                      : _buildReviewsTab(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
          _tabController.animateTo(index);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: _selectedTabIndex == index ? AppColors.primary : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: _selectedTabIndex == index ? Colors.white : AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTab() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call, color: Colors.white, size: 20),
                  label: const Text('Appeler', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.message, color: Colors.white, size: 20),
                  label: const Text('Message', style: TextStyle(color: Colors.white, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'À propos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              specialistData['about'] ?? 'Aucune information disponible.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            _buildInfoRow(Icons.work, 'Expérience', specialistData['experience']),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.language, 'Langues', specialistData['languages']),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, 'Lieu', specialistData['location']),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text(value, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget _buildAppointmentTab() {
    final consultationPrices = specialistData['consultationPrices'] as Map<String, String>? ?? _defaultConsultationPrices;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Prendre un rendez-vous',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _weekDays.map((day) {
                final index = _weekDays.indexOf(day);
                return ElevatedButton(
                  onPressed: () {
                    final now = DateTime.now();
                    final nextMonday = now.add(Duration(days: (DateTime.monday - now.weekday) % 7));
                    final selectedDay = nextMonday.add(Duration(days: index));
                    setState(() {
                      _selectedDate = selectedDay;
                      _dateController.text = '${selectedDay.day}/${selectedDay.month}/${selectedDay.year}';
                      _selectedTime = null;
                      _timeController.clear();
                    });
                    _showTimeSelectionDialog(selectedDay);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                  child: Text(day, style: const TextStyle(color: Colors.white, fontSize: 16)),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'Heure du rendez-vous',
                suffixIcon: const Icon(Icons.access_time, color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              readOnly: true,
              onTap: () {
                if (_selectedDate != null) {
                  _showTimeSelectionDialog(_selectedDate!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez d\'abord sélectionner une date')),
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Objet du rendez-vous',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Type de rendez-vous',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            consultationPrices.isEmpty
                ? const Text(
                    'Aucun type de rendez-vous disponible',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )
                : Column(
                    children: consultationPrices.entries.map<Widget>((entry) {
                      return RadioListTile<String>(
                        title: Text('${entry.key} - ${entry.value}', style: const TextStyle(fontSize: 16)),
                        value: entry.key,
                        groupValue: _appointmentType,
                        onChanged: (value) => setState(() => _appointmentType = value),
                        activeColor: AppColors.primary,
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedDate != null &&
                        _selectedTime != null &&
                        _subjectController.text.isNotEmpty &&
                        _appointmentType != null &&
                        consultationPrices.isNotEmpty
                    ? _showConfirmationDialog
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: const Text(
                  'Confirmer le rendez-vous',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(bottom: 24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Laisser un avis',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _reviewCommentController,
                  decoration: InputDecoration(
                    labelText: 'Votre commentaire',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Note',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          _reviewRating = index + 1.0;
                        });
                      },
                      icon: Icon(
                        index < _reviewRating ? Icons.star : Icons.star_border,
                        color: index < _reviewRating ? Colors.amber : Colors.grey,
                        size: 32,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitReview,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Soumettre l\'avis',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Avis des patients',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        _isReviewsLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
            : reviews.isEmpty
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text('Aucun avis disponible', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      final review = reviews[index];
                      return ReviewCard(
                        user: review['user'] ?? 'Anonyme',
                        comment: review['comment'] ?? '',
                        rating: (review['rating'] as num?)?.toDouble() ?? 0.0,
                      );
                    },
                  ),
      ],
    );
  }
}