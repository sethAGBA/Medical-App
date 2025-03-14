import 'package:flutter/material.dart';
import 'messages_screen.dart';
import 'centers_screen.dart';
import 'devices_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MessagesScreen(),
    CentersScreen(),
    DevicesScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        centerTitle: false, // Mettre à false pour aligner à gauche
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PopupMenuButton(
                position: PopupMenuPosition.under,
                itemBuilder: (context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Text('Profile'),
                        onTap: (){
                          Navigator.pushNamed(context, '/profile');
                        },
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        child: Text('Déconnexion'),
                      ),
                    ],
                child: CircleAvatar(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/docteur.png'),
                      ),
                    ),
                  ),
                )),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 5,
        items: const <BottomNavigationBarItem>[
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
        ],
      ),
    );
  }
}
