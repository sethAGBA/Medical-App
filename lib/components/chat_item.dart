import 'package:flutter/material.dart';
import 'package:medical/models/user_model.dart';

class ChatItem extends StatelessWidget {
  final UserModel user;
  final bool isLast;

  const ChatItem({Key? key, required this.user, this.isLast = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.profileUrl),
        ),
        title: Text(
          user.username,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          user.lastMessage ?? "Dites Bonjour 👋",
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: Text(
          user.lastMessageTime ?? "",
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        onTap: () {
          // Naviguer vers l'écran de chat
          Navigator.pushNamed(context, '/chatRoom', arguments: user);
        },
      ),
    );
  }
}