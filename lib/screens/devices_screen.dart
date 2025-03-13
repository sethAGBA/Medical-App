import 'package:flutter/material.dart';

class DevicesScreen extends StatelessWidget {
  final List<Map<String, String>> devices = [
    {"name": "Montre Connectée", "status": "Connecté"},
    {"name": "Tensiomètre", "status": "Déconnecté"},
    {"name": "Glucomètre", "status": "Connecté"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appareils Connectés'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return ListTile(
            title: Text(device["name"]!),
            subtitle: Text('Statut: ${device["status"]}'),
            leading: Icon(Icons.devices),
            trailing: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Action pour configurer l'appareil
              },
            ),
          );
        },
      ),
    );
  }
}