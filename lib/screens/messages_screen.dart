import 'package:flutter/material.dart';
// import 'package:medical/widgets/center_card.dart';
// import 'package:medical/widgets/chat_item.dart';
import 'package:medical/models/user_model.dart';
import 'package:medical/constants/app_colors.dart';
import 'package:medical/components/chat_item.dart';
class MessagesScreen extends StatelessWidget {
  // Données statiques pour simuler une liste d'utilisateurs
  final List<UserModel> users = [
    UserModel(
      userId: "1",
      username: "MEDICAL AI",
      profileUrl: "https://i.imgur.com/7k12EPD.png",
      lastMessage: "Bonjour, comment puis-je vous aider ?",
      lastMessageTime: "10:00",
    ),
    UserModel(
      userId: "2",
      username: "Dr. Dupont",
      profileUrl: "https://i.imgur.com/7k12EPD.png",
      lastMessage: "Rappel: Consultation demain à 10h.",
      lastMessageTime: "Hier",
    ),
    UserModel(
      userId: "3",
      username: "Dr. Martin",
      profileUrl: "https://i.imgur.com/7k12EPD.png",
      lastMessage: "Votre ordonnance est prête.",
      lastMessageTime: "12/10/2023",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ChatItem(
            user: users[index],
            isLast: index == users.length - 1,
          );
        },
      ),
    );
  }
}