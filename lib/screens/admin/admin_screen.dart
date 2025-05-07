// import 'package:flutter/material.dart';
// import 'package:medical/constants/app_colors.dart';

// class AdminScreen extends StatefulWidget {
//   const AdminScreen({Key? key}) : super(key: key);

//   @override
//   State<AdminScreen> createState() => _AdminScreenState();
// }

// class _AdminScreenState extends State<AdminScreen> {
//   int _selectedIndex = 0;

//   final List<String> _statistiques = [
//     'Utilisateurs inscrits: 150',
//     'Rendez-vous aujourd\'hui: 25',
//     'Médecins actifs: 12',
//     'Pharmacies partenaires: 8',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Administration'),
//         backgroundColor: AppColors.primary,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.exit_to_app, color: Colors.white),
//             onPressed: () => Navigator.pushReplacementNamed(context, '/signin'),
//           ),
//         ],
//       ),
//       body: Row(
//         children: [
//           // Menu latéral
//           NavigationRail(
//             selectedIndex: _selectedIndex,
//             onDestinationSelected: (int index) {
//               setState(() {
//                 _selectedIndex = index;
//               });
//             },
//             labelType: NavigationRailLabelType.selected,
//             backgroundColor: Colors.grey[100],
//             destinations: const [
//               NavigationRailDestination(
//                 icon: Icon(Icons.dashboard),
//                 label: Text('Tableau de bord'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.people),
//                 label: Text('Utilisateurs'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.local_hospital),
//                 label: Text('Centres de santé'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.calendar_today),
//                 label: Text('Rendez-vous'),
//               ),
//             ],
//           ),
//           // Contenu principal
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               child: _buildContent(),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Action en fonction de la section sélectionnée
//           switch (_selectedIndex) {
//             case 1:
//               _showAddUserDialog();
//               break;
//             case 2:
//               _showAddCenterDialog();
//               break;
//             case 3:
//               _showAddAppointmentDialog();
//               break;
//           }
//         },
//         backgroundColor: AppColors.primary,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     switch (_selectedIndex) {
//       case 0:
//         return _buildDashboard();
//       case 1:
//         return _buildUsersList();
//       case 2:
//         return _buildCentersList();
//       case 3:
//         return _buildAppointmentsList();
//       default:
//         return const Center(child: Text('Section en construction'));
//     }
//   }

//   Widget _buildDashboard() {
//     return GridView.count(
//       crossAxisCount: 2,
//       crossAxisSpacing: 16,
//       mainAxisSpacing: 16,
//       children: _statistiques.map((stat) => Card(
//         elevation: 4,
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           child: Center(
//             child: Text(
//               stat,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       )).toList(),
//     );
//   }

//   Widget _buildUsersList() {
//     return ListView.builder(
//       itemCount: 10,
//       itemBuilder: (context, index) => ListTile(
//         leading: const CircleAvatar(
//           child: Icon(Icons.person),
//         ),
//         title: Text('Utilisateur ${index + 1}'),
//         subtitle: Text('user${index + 1}@example.com'),
//         trailing: IconButton(
//           icon: const Icon(Icons.more_vert),
//           onPressed: () {
//             // Menu d'actions pour l'utilisateur
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildCentersList() {
//     return ListView.builder(
//       itemCount: 5,
//       itemBuilder: (context, index) => Card(
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         child: ListTile(
//           leading: const Icon(Icons.local_hospital, color: AppColors.primary),
//           title: Text('Centre de santé ${index + 1}'),
//           subtitle: Text('Adresse du centre ${index + 1}'),
//           trailing: IconButton(
//             icon: const Icon(Icons.edit),
//             onPressed: () {
//               // Éditer le centre
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAppointmentsList() {
//     return ListView.builder(
//       itemCount: 8,
//       itemBuilder: (context, index) => Card(
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         child: ListTile(
//           leading: const Icon(Icons.calendar_today),
//           title: Text('Rendez-vous #${index + 1}'),
//           subtitle: Text('Patient: John Doe - Date: 20/03/2025'),
//           trailing: PopupMenuButton(
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: 'approve',
//                 child: Text('Approuver'),
//               ),
//               const PopupMenuItem(
//                 value: 'reject',
//                 child: Text('Rejeter'),
//               ),
//             ],
//             onSelected: (value) {
//               // Gérer l'action sélectionnée
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   void _showAddUserDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Ajouter un utilisateur'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               decoration: const InputDecoration(labelText: 'Nom complet'),
//             ),
//             TextField(
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Annuler'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Ajouter l'utilisateur
//               Navigator.pop(context);
//             },
//             child: const Text('Ajouter'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showAddCenterDialog() {
//     // Similaire à _showAddUserDialog mais pour les centres
//   }

//   void _showAddAppointmentDialog() {
//     // Similaire à _showAddUserDialog mais pour les rendez-vous
//   }
// }


// // lib/screens/admin/admin_screen.dart
// import 'package:flutter/material.dart';

// class AdminScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tableau de bord Administrateur'),
//       ),
//       body: ListView(
//         children: [
//           ListTile(
//             title: Text('Gérer les utilisateurs'),
//             onTap: () {
//               Navigator.pushNamed(context, '/admin/users');
//             },
//           ),
//           ListTile(
//             title: Text('Gérer les professionnels'),
//             onTap: () {
//               Navigator.pushNamed(context, '/admin/professionals');
//             },
//           ),
//           ListTile(
//             title: Text('Gérer les centres de santé'),
//             onTap: () {
//               Navigator.pushNamed(context, '/admin/health-centers');
//             },
//           ),
//           ListTile(
//             title: Text('Gérer les rendez-vous'),
//             onTap: () {
//               Navigator.pushNamed(context, '/admin/appointments');
//             },
//           ),
//           ListTile(
//             title: Text('Gérer les messages'),
//             onTap: () {
//               Navigator.pushNamed(context, '/admin/messages');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../services/auth_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final List<AdminMenuItem> menuItems = [
    AdminMenuItem(
      title: 'Tableau de bord',
      icon: Icons.dashboard,
      route: '/admin/dashboard',
      color: Colors.blue,
    ),
    AdminMenuItem(
      title: 'Utilisateurs',
      icon: Icons.people,
      route: '/admin/users',
      color: Colors.green,
    ),
    AdminMenuItem(
      title: 'Professionnels',
      icon: Icons.medical_services,
      route: '/admin/professionals',
      color: Colors.orange,
    ),
    AdminMenuItem(
      title: 'Centres de santé',
      icon: Icons.local_hospital,
      route: '/admin/health-centers',
      color: Colors.red,
    ),
    AdminMenuItem(
      title: 'Rendez-vous',
      icon: Icons.calendar_today,
      route: '/admin/appointments',
      color: Colors.purple,
    ),
    AdminMenuItem(
      title: 'Messages',
      icon: Icons.message,
      route: '/admin/messages',
      color: Colors.teal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administration'),
        backgroundColor: AppColors.primary,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[100]!,
              Colors.white,
            ],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return _buildMenuItem(context, item);
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, AdminMenuItem item) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, item.route),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                item.color.withOpacity(0.7),
                item.color,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                item.icon,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Voulez-vous vraiment vous déconnecter ?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Déconnexion'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await AuthService.logout();
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/signin',
          (route) => false,
        );
      }
    }
  }
}

class AdminMenuItem {
  final String title;
  final IconData icon;
  final String route;
  final Color color;

  AdminMenuItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
  });
}