// import 'package:flutter/material.dart';
// // import 'package:medical/widgets/center_card.dart';
// // import 'package:medical/widgets/chat_item.dart';
// import 'package:medical/models/user_model.dart';
// import 'package:medical/constants/app_colors.dart';
// import 'package:medical/components/chat_item.dart';
// class MessagesScreen extends StatelessWidget {
//   // Données statiques pour simuler une liste d'utilisateurs
//   final List<UserModel> users = [
//     UserModel(
//       userId: "1",
//       username: "MEDICAL AI",
//       profileUrl: "https://i.imgur.com/7k12EPD.png",
//       lastMessage: "Bonjour, comment puis-je vous aider ?",
//       lastMessageTime: "10:00",
//     ),
//     UserModel(
//       userId: "2",
//       username: "Dr. Dupont",
//       profileUrl: "https://i.imgur.com/7k12EPD.png",
//       lastMessage: "Rappel: Consultation demain à 10h.",
//       lastMessageTime: "Hier",
//     ),
//     UserModel(
//       userId: "3",
//       username: "Dr. Martin",
//       profileUrl: "https://i.imgur.com/7k12EPD.png",
//       lastMessage: "Votre ordonnance est prête.",
//       lastMessageTime: "12/10/2023",
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Messages'),
//         backgroundColor: AppColors.cardBackground,
//         elevation: 0,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           return ChatItem(
//             user: users[index],
//             isLast: index == users.length - 1,
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:medical/models/user_model.dart';
import 'package:medical/constants/app_colors.dart';
import 'package:medical/components/chat_item.dart';

class MessagesScreen extends StatelessWidget {
  // Données statiques pour simuler une liste d'utilisateurs
  final List<UserModel> users = [
    UserModel(
      id: "1",
      email: "ai@medical.com",
      fullName: "MEDICAL AI",
      profilePhoto: "https://i.imgur.com/7k12EPD.png",
      role: "ai",
      lastMessage: "Bonjour, comment puis-je vous aider ?",
      lastMessageTime: "10:00",
      isOnline: true,
    ),
    UserModel(
      id: "2",
      email: "dupont@medical.com",
      fullName: "Dr. Dupont",
      profilePhoto: "https://i.imgur.com/7k12EPD.png",
      role: "doctor",
      lastMessage: "Rappel: Consultation demain à 10h.",
      lastMessageTime: "Hier",
      isOnline: false,
    ),
    UserModel(
      id: "3",
      email: "martin@medical.com",
      fullName: "Dr. Martin",
      profilePhoto: "https://i.imgur.com/7k12EPD.png",
      role: "doctor",
      lastMessage: "Votre ordonnance est prête.",
      lastMessageTime: "12/10/2023",
      isOnline: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: Implémenter la recherche de messages
            },
          ),
        ],
      ),
      body: users.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.message_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Aucun message',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ChatItem(
                  user: user,
                  isLast: index == users.length - 1,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implémenter la création d'une nouvelle conversation
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.message, color: Colors.white),
      ),
    );
  }
}