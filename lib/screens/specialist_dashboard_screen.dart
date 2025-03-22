import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:medical/constants/app_colors.dart';
import 'package:medical/config.dart';

class SpecialistDashboardScreen extends StatefulWidget {
  final Map<String, dynamic> specialist;

  const SpecialistDashboardScreen({super.key, required this.specialist});

  @override
  State<SpecialistDashboardScreen> createState() => _SpecialistDashboardScreenState();
}

class _SpecialistDashboardScreenState extends State<SpecialistDashboardScreen> {
  late String specialty;
  late String profilePhoto;
  late String about;
  late Map<int, List<TimeOfDay>> availableHours;
  late Map<String, String> consultationPrices;
  List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> comments = [];

  @override
  void initState() {
    super.initState();
    specialty = widget.specialist['specialty'] ?? 'Médecin généraliste';
    profilePhoto = widget.specialist['image'] ?? 'https://via.placeholder.com/150';
    about = widget.specialist['about'] ?? 'Pas de description pour le moment.';
    availableHours = widget.specialist['availableHours'] ?? {
      DateTime.monday: [const TimeOfDay(hour: 9, minute: 0)],
      DateTime.tuesday: [const TimeOfDay(hour: 9, minute: 0)],
      DateTime.wednesday: [const TimeOfDay(hour: 9, minute: 0)],
      DateTime.thursday: [const TimeOfDay(hour: 9, minute: 0)],
      DateTime.friday: [const TimeOfDay(hour: 9, minute: 0)],
    };
    consultationPrices = widget.specialist['consultationPrices'] ?? {
      'À domicile': '10 000 FCFA',
      'À l\'hôpital': '8 000 FCFA',
      'En ligne': '5 000 FCFA',
    };
    fetchAppointments();
    fetchComments();
  }

  Future<void> fetchAppointments() async {
    setState(() {
      appointments = [
        {'id': '1', 'patient': 'Patient 1', 'date': '2025-03-24', 'time': '09:00', 'type': 'En ligne'},
        {'id': '2', 'patient': 'Patient 2', 'date': '2025-03-25', 'time': '14:00', 'type': 'À l\'hôpital'},
      ];
    });
  }

  Future<void> fetchComments() async {
    setState(() {
      comments = [
        {'id': '1', 'patient': 'Patient 1', 'text': 'Très bon médecin !', 'rating': 4},
        {'id': '2', 'patient': 'Patient 2', 'text': 'Pas mal.', 'rating': 3},
      ];
    });
  }

  Future<void> updateProfile() async {
    final updatedData = {
      'specialty': specialty,
      'profilePhoto': profilePhoto,
      'about': about,
      'availableHours': availableHours.map((k, v) => MapEntry(k.toString(), v.map((t) => {'hour': t.hour, 'minute': t.minute}).toList())),
      'consultationPrices': consultationPrices,
    };
    print('Updating profile: $updatedData');
    final response = await http.put(
      Uri.parse('${Config.baseUrl}/users/${widget.specialist['id']}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profil mis à jour !')));
    }
  }

  void deleteComment(String commentId) async {
    setState(() => comments.removeWhere((comment) => comment['id'] == commentId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Tableau de Bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () => setState(() => profilePhoto = 'https://via.placeholder.com/200'), // Add image picker later
                child: CircleAvatar(radius: 60, backgroundImage: NetworkImage(profilePhoto)),
              ),
            ),
            const SizedBox(height: 16),
            Center(child: Text(widget.specialist['name'] ?? 'Spécialiste', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(labelText: 'Spécialité', border: OutlineInputBorder()),
              controller: TextEditingController(text: specialty),
              onChanged: (value) => setState(() => specialty = value),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'À propos', border: OutlineInputBorder()),
              controller: TextEditingController(text: about),
              maxLines: 3,
              onChanged: (value) => setState(() => about = value),
            ),
            const SizedBox(height: 24),
            const Text('Mes Rendez-vous', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final apt = appointments[index];
                return Card(
                  child: ListTile(
                    title: Text('${apt['patient']} - ${apt['type']}'),
                    subtitle: Text('${apt['date']} à ${apt['time']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.chat),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text('Disponibilité hebdomadaire', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...availableHours.entries.map((entry) {
              return Row(
                children: [
                  Expanded(child: Text(DateTime.now().add(Duration(days: entry.key - DateTime.now().weekday)).toString().split(' ')[0])),
                  ElevatedButton(
                    onPressed: () async {
                      final hours = await _editAvailability(entry.value);
                      if (hours != null) setState(() => availableHours[entry.key] = hours);
                    },
                    child: const Text('Modifier'),
                  ),
                ],
              );
            }),
            const SizedBox(height: 24),
            const Text('Prix des consultations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...consultationPrices.entries.map((entry) {
              return TextField(
                decoration: InputDecoration(labelText: entry.key, border: const OutlineInputBorder()),
                controller: TextEditingController(text: entry.value),
                onChanged: (value) => setState(() => consultationPrices[entry.key] = value),
              );
            }),
            const SizedBox(height: 24),
            const Text('Avis des patients', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return Card(
                  child: ListTile(
                    title: Text(comment['patient']),
                    subtitle: Text(comment['text']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteComment(comment['id']),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: updateProfile,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Enregistrer les modifications', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<TimeOfDay>?> _editAvailability(List<TimeOfDay> currentHours) async {
    List<TimeOfDay> newHours = List.from(currentHours);
    return await showDialog<List<TimeOfDay>>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Modifier les horaires'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...newHours.map((time) => Row(
                    children: [
                      Text('${time.hour}:${time.minute.toString().padLeft(2, '0')}'),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => setDialogState(() => newHours.remove(time)),
                      ),
                    ],
                  )),
              TextButton(
                onPressed: () async {
                  final time = await showTimePicker(context: context, initialTime: const TimeOfDay(hour: 9, minute: 0));
                  if (time != null) setDialogState(() => newHours.add(time));
                },
                child: const Text('Ajouter un horaire'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, null), child: const Text('Annuler')),
            ElevatedButton(onPressed: () => Navigator.pop(context, newHours), child: const Text('Enregistrer')),
          ],
        ),
      ),
    );
  }
}