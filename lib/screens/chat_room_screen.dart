import 'package:flutter/material.dart';
import 'package:medical/models/user_model.dart';
import 'package:medical/constants/app_colors.dart';

class ChatRoomScreen extends StatefulWidget {
  final UserModel user;

  const ChatRoomScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text,
        'isMe': true,
        'timestamp': DateTime.now(),
      });
    });

    // Simuler une réponse automatique
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add({
            'text': 'Message reçu ! Je vous réponds dès que possible.',
            'isMe': false,
            'timestamp': DateTime.now(),
          });
        });
      }
    });

    _messageController.clear();
  }

  void _deleteMessage(int index) {
    setState(() {
      _messages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.profileUrl),
              radius: 20,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.username,
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  'En ligne',
                  style: TextStyle(fontSize: 12, color: Colors.lightGreenAccent),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AppColors.textSecondary,
        elevation: 0,
        actions: [
          // Icône d'appel vidéo
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // TODO: Implémenter l'appel vidéo
              print("Appel vidéo avec ${widget.user.username}");
            },
          ),
          // Icône d'appel audio
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // TODO: Implémenter l'appel audio
              print("Appel audio avec ${widget.user.username}");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isMe = message['isMe'] as bool;

                return GestureDetector(
                  onLongPress: () {
                    // Afficher une boîte de dialogue pour confirmer la suppression
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Supprimer le message"),
                        content: const Text(
                            "Êtes-vous sûr de vouloir supprimer ce message ?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Fermer la boîte de dialogue
                            },
                            child: const Text("Annuler"),
                          ),
                          TextButton(
                            onPressed: () {
                              _deleteMessage(_messages.length - 1 - index); // Supprimer le message
                              Navigator.pop(context); // Fermer la boîte de dialogue
                            },
                            child: const Text(
                              "Supprimer",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment:
                          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isMe)
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.user.profileUrl),
                            radius: 16,
                          ),
                        const SizedBox(width: 8),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isMe ? AppColors.ophthalmology : Colors.grey[200],
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text(
                            message['text'] as String,
                            style: TextStyle(
                              color: isMe ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: () {
                      // TODO: Implémenter l'envoi de fichiers
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Écrivez votre message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: null,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: AppColors.primary,
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}