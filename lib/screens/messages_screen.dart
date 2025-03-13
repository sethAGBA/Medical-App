import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  final List<String> messages = [
    "Rappel: Consultation demain à 10h.",
    "Nouveau message du Dr. Dupont.",
    "Votre ordonnance est prête.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(messages[index]),
            subtitle: Text('12/10/2023'), // Date du message
            leading: Icon(Icons.message),
          );
        },
      ),
    );
  }
}