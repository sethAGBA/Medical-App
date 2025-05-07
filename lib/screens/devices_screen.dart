// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical/constants/app_colors.dart';
// import 'dart:convert';
// import 'package:medical/config.dart'; // Import de Config

// class DevicesScreen extends StatefulWidget {
//   const DevicesScreen({super.key});

//   @override
//   _DevicesScreenState createState() => _DevicesScreenState();
// }

// class _DevicesScreenState extends State<DevicesScreen> {
//   String userName = "Utilisateur"; // Valeur par défaut

//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }

//   // Charger le token et récupérer les données de l'utilisateur
//   Future<void> _loadUserData() async {
//     print('Démarrage de _loadUserData');
//     // Charger le token depuis SharedPreferences
//     await Config.loadToken();
//     print('Token chargé : ${Config.jwtToken}');

//     if (Config.jwtToken != null) {
//       try {
//         print('Envoi de la requête à ${Config.usersUrl}/me');
//         final response = await http.get(
//           Uri.parse('${Config.usersUrl}/me'),
//           headers: Config.authHeaders,
//         ).timeout(Config.timeoutDuration);

//         print('Statut de la réponse : ${response.statusCode}');
//         print('Corps de la réponse : ${response.body}');

//         if (response.statusCode == 200) {
//           final data = jsonDecode(response.body);
//           print('Données décodées : $data');
//           setState(() {
//             // Vérifier les champs disponibles dans la réponse
//             userName = data['fullName'] ?? data['email']?.split('@')[0] ?? "Utilisateur";
//             print('Nom mis à jour : $userName');
//           });
//         } else {
//           print('Erreur lors de la récupération du profil : ${response.statusCode}');
//         }
//       } catch (e) {
//         print('Erreur réseau ou timeout : $e');
//       }
//     } else {
//       print('Aucun token trouvé, utilisateur non connecté');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('Construction de l\'interface avec userName : $userName');
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8FAFC),
//       appBar: _buildAppBar(),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             _buildHeader(),
//             const SizedBox(height: 24),
//             _buildHealthMetrics(),
//             const SizedBox(height: 20),
//             _buildMedicationSection(),
//             const SizedBox(height: 20),
//             _buildActivitySection(),
//             const SizedBox(height: 20),
//             _buildHeartRateAnalysis(),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: const Icon(Icons.add, color: Colors.white),
//         backgroundColor: const Color(0xFF3366FF),
//         elevation: 4,
//       ),
//     );
//   }

//   AppBar _buildAppBar() {
//     return AppBar(
//       title: const Text(
//         'Mon Tableau de Santé',
//         style: TextStyle(
//           color: Colors.white,
//           fontWeight: FontWeight.w600,
//           fontSize: 20,
//         ),
//       ),
//       backgroundColor: AppColors.primary,
//       elevation: 0,
//     );
//   }

//   Widget _buildHeader() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Bonjour, $userName',
//           style: const TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF0F172A),
//           ),
//         ),
//         const SizedBox(height: 8),
//         const Text(
//           'Voici votre résumé santé',
//           style: TextStyle(
//             fontSize: 16,
//             color: Color(0xFF64748B),
//           ),
//         ),
//         const SizedBox(height: 16),
//         _buildDateSelector(),
//       ],
//     );
//   }

//   Widget _buildDateSelector() {
//     final currentDate = DateTime.now();
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: List.generate(7, (index) {
//           final date = currentDate.subtract(Duration(days: 3 - index));
//           final isSelected = index == 3;
//           return Container(
//             margin: const EdgeInsets.only(right: 12),
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             decoration: BoxDecoration(
//               color: isSelected ? const Color(0xFF3366FF) : Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: isSelected
//                   ? []
//                   : [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 6,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'][date.weekday - 1],
//                   style: TextStyle(
//                     color: isSelected ? Colors.white : const Color(0xFF64748B),
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   date.day.toString(),
//                   style: TextStyle(
//                     color: isSelected ? Colors.white : const Color(0xFF0F172A),
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   Widget _buildHealthMetrics() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: _buildMetricCard(
//             title: "Rythme cardiaque",
//             value: "66",
//             unit: "bpm",
//             icon: Icons.favorite_outlined,
//             color: const Color(0xFFFF4759),
//             trend: Icons.trending_up,
//           ),
//         ),
//         const SizedBox(width: 16),
//         Expanded(
//           child: _buildMetricCard(
//             title: "Pression art.",
//             value: "123/76",
//             unit: "mmHg",
//             icon: Icons.monitor_heart_outlined,
//             color: const Color(0xFF3366FF),
//             trend: Icons.trending_down,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMetricCard({
//     required String title,
//     required String value,
//     required String unit,
//     required IconData icon,
//     required Color color,
//     required IconData trend,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Icon(icon, color: color, size: 22),
//               ),
//               const SizedBox(width: 8),
//               Flexible(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     color: Color(0xFF64748B),
//                     fontSize: 14,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               const Spacer(),
//               Icon(
//                 trend,
//                 color: trend == Icons.trending_up ? const Color(0xFFFF4759) : const Color(0xFF10B981),
//                 size: 24,
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF0F172A),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             unit,
//             style: const TextStyle(
//               color: Color(0xFF64748B),
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMedicationSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader("Médicaments", Icons.medication_outlined),
//         const SizedBox(height: 16),
//         _buildMedicationItem(
//           time: "6h-7h",
//           name: "Metformine",
//           dosage: "2 comprimés",
//           isTaken: true,
//           icon: Icons.medical_services,
//         ),
//         _buildMedicationItem(
//           time: "Matin",
//           name: "Trulicity",
//           dosage: "1 injection",
//           isTaken: false,
//           icon: Icons.medical_services,
//         ),
//       ],
//     );
//   }

//   Widget _buildSectionHeader(String title, IconData icon) {
//     return Row(
//       children: [
//         Icon(icon, color: const Color(0xFF3366FF)),
//         const SizedBox(width: 8),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: Color(0xFF0F172A),
//           ),
//         ),
//         const Spacer(),
//         const Text(
//           "Voir tout",
//           style: TextStyle(
//             fontSize: 14,
//             color: Color(0xFF3366FF),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildMedicationItem({
//     required String time,
//     required String name,
//     required String dosage,
//     required bool isTaken,
//     required IconData icon,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12), // À corriger en "bottom"
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: const Color(0xFFE0E7FF),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: const Color(0xFF3366FF)),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   dosage,
//                   style: const TextStyle(
//                     color: Color(0xFF64748B),
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 time,
//                 style: const TextStyle(
//                   color: Color(0xFF64748B),
//                   fontSize: 12,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: isTaken ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   isTaken ? "Pris" : "En attente",
//                   style: TextStyle(
//                     color: isTaken ? const Color(0xFF065F46) : const Color(0xFFB91C1C),
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildActivitySection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader("Activités", Icons.directions_run),
//         const SizedBox(height: 16),
//         _buildActivityCard(
//           icon: Icons.directions_walk,
//           title: "Marche",
//           progress: 0.75,
//           value: "750 pas",
//           target: "1000 pas",
//           isCompleted: true,
//         ),
//         const SizedBox(height: 12),
//         _buildActivityCard(
//           icon: Icons.pool,
//           title: "Natation",
//           progress: 0.0,
//           value: "0 min",
//           target: "30 min",
//           isCompleted: false,
//         ),
//       ],
//     );
//   }

//   Widget _buildActivityCard({
//     required IconData icon,
//     required String title,
//     required double progress,
//     required String value,
//     required String target,
//     required bool isCompleted,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 48,
//             height: 48,
//             decoration: BoxDecoration(
//               color: const Color(0xFFE0F2FE),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: const Color(0xFF0EA5E9)),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 LinearProgressIndicator(
//                   value: progress,
//                   backgroundColor: const Color(0xFFE2E8F0),
//                   color: isCompleted ? const Color(0xFF10B981) : const Color(0xFF0EA5E9),
//                   minHeight: 6,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 16),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 value,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               Text(
//                 "sur $target",
//                 style: const TextStyle(
//                   color: Color(0xFF64748B),
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeartRateAnalysis() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader("Analyse Cardiaque", Icons.insights),
//         const SizedBox(height: 16),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 10,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildHeartStat(
//                     title: "Repos",
//                     duration: "4h 45m",
//                     bpm: "76 bpm moy",
//                     color: const Color(0xFF6366F1),
//                   ),
//                   _buildHeartStat(
//                     title: "Actif",
//                     duration: "30m",
//                     bpm: "82 bpm moy",
//                     color: const Color(0xFFEC4899),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               Container(
//                 height: 150,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   color: const Color(0xFFF8FAFC),
//                 ),
//                 child: const Center(
//                   child: Text(
//                     "Graphique des fréquences cardiaques",
//                     style: TextStyle(color: Color(0xFF64748B)),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   _buildHealthTag("Fit", const Color(0xFFD1FAE5), const Color(0xFF065F46)),
//                   const SizedBox(width: 8),
//                   _buildHealthTag("Endurance", const Color(0xFFE0F2FE), const Color(0xFF0C4A6E)),
//                   const SizedBox(width: 8),
//                   _buildHealthTag("Normal", const Color(0xFFFEF3C7), const Color(0xFF92400E)),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildHeartStat({
//     required String title,
//     required String duration,
//     required String bpm,
//     required Color color,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             color: Color(0xFF64748B),
//             fontSize: 14,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           duration,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Row(
//           children: [
//             Container(
//               width: 12,
//               height: 12,
//               decoration: BoxDecoration(
//                 color: color,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Text(
//               bpm,
//               style: const TextStyle(
//                 color: Color(0xFF64748B),
//                 fontSize: 14,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildHealthTag(String label, Color bgColor, Color textColor) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: bgColor,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: textColor,
//           fontSize: 12,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medical/constants/app_colors.dart';
import 'package:medical/config.dart';
import 'package:medical/services/auth_service.dart';
import 'package:medical/services/api_service.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  _DevicesScreenState createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  String userName = "Utilisateur";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    print('Démarrage de _loadUserData');
    try {
      final user = await AuthService.getCurrentUser();
      if (user == null) {
        print('Aucun utilisateur connecté, redirection vers signin');
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/signin');
        }
        return;
      }
      final data = await ApiService.getUserProfile();
      setState(() {
        userName = data['fullName'] ?? data['email']?.split('@')[0] ?? "Utilisateur";
        print('Nom mis à jour: $userName');
      });
    } catch (e) {
      print('Erreur lors de la récupération du profil: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Construction de l\'interface avec userName: $userName');
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildHealthMetrics(),
            const SizedBox(height: 20),
            _buildMedicationSection(),
            const SizedBox(height: 20),
            _buildActivitySection(),
            const SizedBox(height: 20),
            _buildHeartRateAnalysis(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color(0xFF3366FF),
        elevation: 4,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Mon Tableau de Santé',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      backgroundColor: AppColors.primary,
      elevation: 0,
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bonjour, $userName',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Voici votre résumé santé',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 16),
        _buildDateSelector(),
      ],
    );
  }

  Widget _buildDateSelector() {
    final currentDate = DateTime.now();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(7, (index) {
          final date = currentDate.subtract(Duration(days: 3 - index));
          final isSelected = index == 3;
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF3366FF) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isSelected
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Column(
              children: [
                Text(
                  ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'][date.weekday - 1],
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF64748B),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date.day.toString(),
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF0F172A),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHealthMetrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildMetricCard(
            title: "Rythme cardiaque",
            value: "66",
            unit: "bpm",
            icon: Icons.favorite_outlined,
            color: const Color(0xFFFF4759),
            trend: Icons.trending_up,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildMetricCard(
            title: "Pression art.",
            value: "123/76",
            unit: "mmHg",
            icon: Icons.monitor_heart_outlined,
            color: const Color(0xFF3366FF),
            trend: Icons.trending_down,
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
    required IconData trend,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Icon(
                trend,
                color: trend == Icons.trending_up ? const Color(0xFFFF4759) : const Color(0xFF10B981),
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            unit,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Médicaments", Icons.medication_outlined),
        const SizedBox(height: 16),
        _buildMedicationItem(
          time: "6h-7h",
          name: "Metformine",
          dosage: "2 comprimés",
          isTaken: true,
          icon: Icons.medical_services,
        ),
        _buildMedicationItem(
          time: "Matin",
          name: "Trulicity",
          dosage: "1 injection",
          isTaken: false,
          icon: Icons.medical_services,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF3366FF)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
        const Spacer(),
        const Text(
          "Voir tout",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF3366FF),
          ),
        ),
      ],
    );
  }

  Widget _buildMedicationItem({
    required String time,
    required String name,
    required String dosage,
    required bool isTaken,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF3366FF)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dosage,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: isTaken ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isTaken ? "Pris" : "En attente",
                  style: TextStyle(
                    color: isTaken ? const Color(0xFF065F46) : const Color(0xFFB91C1C),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Activités", Icons.directions_run),
        const SizedBox(height: 16),
        _buildActivityCard(
          icon: Icons.directions_walk,
          title: "Marche",
          progress: 0.75,
          value: "750 pas",
          target: "1000 pas",
          isCompleted: true,
        ),
        const SizedBox(height: 12),
        _buildActivityCard(
          icon: Icons.pool,
          title: "Natation",
          progress: 0.0,
          value: "0 min",
          target: "30 min",
          isCompleted: false,
        ),
      ],
    );
  }

  Widget _buildActivityCard({
    required IconData icon,
    required String title,
    required double progress,
    required String value,
    required String target,
    required bool isCompleted,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F2FE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF0EA5E9)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFFE2E8F0),
                  color: isCompleted ? const Color(0xFF10B981) : const Color(0xFF0EA5E9),
                  minHeight: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "sur $target",
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeartRateAnalysis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("Analyse Cardiaque", Icons.insights),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHeartStat(
                    title: "Repos",
                    duration: "4h 45m",
                    bpm: "76 bpm moy",
                    color: const Color(0xFF6366F1),
                  ),
                  _buildHeartStat(
                    title: "Actif",
                    duration: "30m",
                    bpm: "82 bpm moy",
                    color: const Color(0xFFEC4899),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF8FAFC),
                ),
                child: const Center(
                  child: Text(
                    "Graphique des fréquences cardiaques",
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildHealthTag("Fit", const Color(0xFFD1FAE5), const Color(0xFF065F46)),
                  const SizedBox(width: 8),
                  _buildHealthTag("Endurance", const Color(0xFFE0F2FE), const Color(0xFF0C4A6E)),
                  const SizedBox(width: 8),
                  _buildHealthTag("Normal", const Color(0xFFFEF3C7), const Color(0xFF92400E)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeartStat({
    required String title,
    required String duration,
    required String bpm,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          duration,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              bpm,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHealthTag(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}