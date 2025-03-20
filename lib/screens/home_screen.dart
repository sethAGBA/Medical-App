import 'package:flutter/material.dart';
import 'package:medical/screens/centers_screen.dart';
import 'package:medical/screens/devices_screen.dart';
import 'package:medical/screens/messages_screen.dart';
import '../constants/app_colors.dart';
import 'signin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MessagesScreen(),
    const CentersScreen(),
    DevicesScreen(),
  ];

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
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/nurse1.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
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
        onTap: () {
          Future.delayed(
            const Duration(seconds: 0),
            () => Navigator.pushNamed(context, '/profile'),
          );
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