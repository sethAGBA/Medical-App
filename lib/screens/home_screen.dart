// import 'package:flutter/material.dart';
// import 'package:medical/screens/centers_screen.dart';
// import 'package:medical/screens/devices_screen.dart';
// import 'package:medical/screens/messages_screen.dart';
// import '../constants/app_colors.dart';
// import 'signin_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     MessagesScreen(),
//     const CentersScreen(),
//     DevicesScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   void _handleLogout() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Déconnexion'),
//         content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Annuler'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => SignInScreen()),
//                 (Route<dynamic> route) => false,
//               );
//             },
//             child: const Text('Déconnexion', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAppBarTitle() {
//     return const Text(
//       'Medical',
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 29,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget _buildProfileAvatar() {
//     return CircleAvatar(
//       backgroundColor: Colors.white,
//       radius: 20,
//       child: ClipOval(
//         child: Container(
//           width: 40,
//           height: 40,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/nurse1.jpeg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<PopupMenuEntry> _buildPopupMenuItems() {
//     return [
//       PopupMenuItem(
//         child: const ListTile(
//           leading: Icon(Icons.person, color: AppColors.primary),
//           title: Text(
//             'Profile',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         onTap: () {
//           Future.delayed(
//             const Duration(seconds: 0),
//             () => Navigator.pushNamed(context, '/profile'),
//           );
//         },
//       ),
//       const PopupMenuDivider(),
//       PopupMenuItem(
//         child: ListTile(
//           leading: const Icon(Icons.logout, color: Colors.red),
//           title: const Text(
//             'Déconnexion',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               color: Colors.red,
//             ),
//           ),
//           onTap: _handleLogout,
//         ),
//       ),
//     ];
//   }

//   List<BottomNavigationBarItem> _buildNavigationItems() {
//     return const [
//       BottomNavigationBarItem(
//         icon: Icon(Icons.message),
//         label: 'Messages',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.local_hospital),
//         label: 'Centres',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.devices),
//         label: 'Appareils',
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: _buildAppBarTitle(),
//         backgroundColor: AppColors.primary,
//         centerTitle: false,
//         elevation: 0,
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications, color: Colors.white),
//             onPressed: () {
//               // TODO: Implémenter la logique des notifications
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: PopupMenuButton(
//               position: PopupMenuPosition.under,
//               itemBuilder: (context) => _buildPopupMenuItems(),
//               child: _buildProfileAvatar(),
//             ),
//           ),
//         ],
//       ),
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         selectedItemColor: AppColors.primary,
//         unselectedItemColor: AppColors.textSecondary,
//         backgroundColor: Colors.white,
//         elevation: 5,
//         items: _buildNavigationItems(),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:medical/screens/centers_screen.dart';
import 'package:medical/screens/devices_screen.dart';
import 'package:medical/screens/messages_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants/app_colors.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import 'signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  UserModel? _currentUser;

  final List<Widget> _pages = [
    MessagesScreen(),
    const CentersScreen(),
    DevicesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      _currentUser = await AuthService.getCurrentUser(forceRefresh: true);
      if (_currentUser == null || _currentUser!.id.isEmpty) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/signin');
        }
        return;
      }
      setState(() {});
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement du profil: $e')),
        );
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text('Déconnexion', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Medical',
      style: TextStyle(
        color: Colors.white,
        fontSize: 29,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 20,
      child: ClipOval(
        child: _currentUser?.profilePhoto != null
            ? CachedNetworkImage(
                imageUrl: _currentUser!.profilePhoto!,
                cacheKey: '${_currentUser!.profilePhoto}_${DateTime.now().millisecondsSinceEpoch}',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) {
                  print('CachedNetworkImage error in HomeScreen: $error, URL: $url');
                  return Image.asset(
                    'assets/images/nurse1.jpeg',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  );
                },
              )
            : Image.asset(
                'assets/images/nurse1.jpeg',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  List<PopupMenuEntry> _buildPopupMenuItems() {
    return [
      PopupMenuItem(
        child: const ListTile(
          leading: Icon(Icons.person, color: AppColors.primary),
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        onTap: () async {
          await Navigator.pushNamed(context, '/profile');
          // Recharger les données utilisateur après le retour de ProfileScreen
          await _loadUserData();
        },
      ),
      const PopupMenuDivider(),
      PopupMenuItem(
        child: ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text(
            'Déconnexion',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
          onTap: _handleLogout,
        ),
      ),
    ];
  }

  List<BottomNavigationBarItem> _buildNavigationItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.message),
        label: 'Messages',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.local_hospital),
        label: 'Centres',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.devices),
        label: 'Appareils',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(),
        backgroundColor: AppColors.primary,
        centerTitle: false,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // TODO: Implémenter la logique des notifications
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (context) => _buildPopupMenuItems(),
              child: _buildProfileAvatar(),
            ),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: Colors.white,
        elevation: 5,
        items: _buildNavigationItems(),
      ),
    );
  }
}