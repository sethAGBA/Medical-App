// // lib/screens/admin/user_management_screen.dart
// import 'package:flutter/material.dart';
// import '../../services/api_service.dart';

// class UserManagementScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gestion des utilisateurs'),
//       ),
//       body: FutureBuilder(
//         future: ApiService.getUsers(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Erreur: ${snapshot.error}'));
//           } else {
//             final users = snapshot.data as List;
//             return ListView.builder(
//               itemCount: users.length,
//               itemBuilder: (context, index) {
//                 final user = users[index];
//                 return ListTile(
//                   title: Text(user['fullName']),
//                   subtitle: Text(user['email']),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () async {
//                       await ApiService.deleteUser(user['id']);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Utilisateur supprimé')),
//                       );
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../models/user_model.dart';

// class UserManagementScreen extends StatefulWidget {
//   const UserManagementScreen({super.key});

//   @override
//   State<UserManagementScreen> createState() => _UserManagementScreenState();
// }

// class _UserManagementScreenState extends State<UserManagementScreen> {
//   List<UserModel> users = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUsers();
//   }

//   Future<String?> _getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('access_token');
//   }

//   Future<void> _fetchUsers() async {
//     final token = await _getToken();
//     if (token == null) {
//       Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
//       return;
//     }

//     try {
//       final response = await http.get(
//         Uri.parse('http://localhost:3000/admin/users'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List<dynamic> data = jsonDecode(response.body);
//         setState(() {
//           users = data.map((user) => UserModel.fromMap(user)).toList();
//           _isLoading = false;
//         });
//       } else {
//         throw Exception('Erreur ${response.statusCode}: ${response.body}');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
//       }
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _deleteUser(String id) async {
//     final token = await _getToken();
//     if (token == null) return;

//     try {
//       final response = await http.delete(
//         Uri.parse('http://localhost:3000/admin/users/$id'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         setState(() => users.removeWhere((user) => user.id == id));
//       } else {
//         throw Exception('Erreur ${response.statusCode}: ${response.body}');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gestion des Utilisateurs'),
//         backgroundColor: const Color.fromARGB(255, 7, 56, 9),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: users.length,
//               itemBuilder: (context, index) {
//                 final user = users[index];
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: NetworkImage(user.profilePhoto),
//                   ),
//                   title: Text(user.fullName),
//                   subtitle: Text(user.email ?? user.phoneNumber ?? 'N/A'),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => _deleteUser(user.id),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';
import '../../constants/app_colors.dart';
import '../../config.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<UserModel> users = [];
  bool _isLoading = true;
  final _searchController = TextEditingController();
  List<UserModel> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  void _filterUsers(String query) {
    setState(() {
      _filteredUsers = users.where((user) {
        final usernameLower = user.fullName.toLowerCase();
        final emailLower = user.email.toLowerCase();
        final searchLower = query.toLowerCase();
        return usernameLower.contains(searchLower) || 
               emailLower.contains(searchLower);
      }).toList();
    });
  }

  Future<void> _fetchUsers() async {
    final token = await _getToken();
    if (token == null) {
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('${Config.baseUrl}/admin/users'),
        headers: {
          ...Config.defaultHeaders,
          'Authorization': 'Bearer $token',
        },
      ).timeout(Config.timeoutDuration);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (!mounted) return;
        setState(() {
          users = data.map((user) => UserModel.fromMap(user)).toList();
          _filteredUsers = users;
          _isLoading = false;
        });
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
      setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteUser(String uid) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Voulez-vous vraiment supprimer cet utilisateur ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final token = await _getToken();
    if (token == null) return;

    try {
      final response = await http.delete(
        Uri.parse('${Config.baseUrl}/admin/users/$uid'),
        headers: {
          ...Config.defaultHeaders,
          'Authorization': 'Bearer $token',
        },
      ).timeout(Config.timeoutDuration);

      if (response.statusCode == 200) {
        setState(() {
          users.removeWhere((user) => user.id == uid);
          _filteredUsers = List.from(users);
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Utilisateur supprimé avec succès')),
        );
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Utilisateurs'),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterUsers,
              decoration: InputDecoration(
                labelText: 'Rechercher un utilisateur',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredUsers.isEmpty
                    ? const Center(child: Text('Aucun utilisateur trouvé'))
                    : ListView.builder(
                        itemCount: _filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = _filteredUsers[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.profilePhoto),
                              ),
                              title: Text(user.fullName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user.email),
                                  Text('Rôle: ${user.roleDisplay}'),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteUser(user.id),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}