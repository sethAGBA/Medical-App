import 'package:flutter/material.dart';
import '../constants/app_colors.dart'; // Assurez-vous d'importer vos couleurs

class SpecialistProfileScreen extends StatefulWidget {
  final Map<String, dynamic> specialist;

  const SpecialistProfileScreen({Key? key, required this.specialist}) : super(key: key);

  @override
  State<SpecialistProfileScreen> createState() => _SpecialistProfileScreenState();
}

class _SpecialistProfileScreenState extends State<SpecialistProfileScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  String? appointmentType; // Type de rendez-vous : à domicile, à l'hôpital, en ligne
  final List<String> weekDays = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi'];

  // Prix des consultations par type
  final Map<String, String> consultationPrices = {
    'À domicile': '10 000 FCFA',
    'À l\'hôpital': '8 000 FCFA',
    'En ligne': '5 000 FCFA',
  };
   
  // Horaires disponibles par jour
  final Map<int, List<TimeOfDay>> availableHours = {
    DateTime.monday: [
      const TimeOfDay(hour: 8, minute: 0),
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 15, minute: 0),
      const TimeOfDay(hour: 16, minute: 0),
    ],
    DateTime.tuesday: [
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 11, minute: 0),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 15, minute: 0),
    ],
    DateTime.wednesday: [
      const TimeOfDay(hour: 8, minute: 0),
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 15, minute: 0),
    ],
    DateTime.thursday: [
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 11, minute: 0),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 15, minute: 0),
    ],
    DateTime.friday: [
      const TimeOfDay(hour: 8, minute: 0),
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 15, minute: 0),
    ],
  };

  List<TimeOfDay> getAvailableHoursForDate(DateTime date) {
    return availableHours[date.weekday] ?? [];
  }

  void _showTimeSelectionDialog(DateTime date) {
    final List<TimeOfDay> hours = getAvailableHoursForDate(date);

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Horaires disponibles',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (hours.isEmpty)
                const Text(
                  'Aucun horaire disponible pour cette date',
                  style: TextStyle(color: Colors.grey),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: hours.map((time) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedTime = time;
                          timeController.text = '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer le rendez-vous'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Médecin : ${widget.specialist['name']}'),
            Text('Date : ${dateController.text}'),
            Text('Heure : ${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}'),
            Text('Objet : ${subjectController.text}'),
            Text('Type : $appointmentType'),
            Text('Prix : ${consultationPrices[appointmentType]}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Rendez-vous confirmé !'),
                ),
              );
            },
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.specialist['name']),
        //backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // Action pour envoyer un message
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(widget.specialist['image']),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                widget.specialist['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                widget.specialist['specialty'],
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Action pour appeler
                  },
                  icon: const Icon(Icons.call, color: Colors.green),
                  label: const Text('Appeler', style: TextStyle(fontSize: 16, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Action pour message
                  },
                  icon: const Icon(Icons.message,color:  Colors.blueAccent ),
                  label: const Text('Message', style: TextStyle(fontSize: 16, color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            const Text(
              'Informations supplémentaires',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Prendre un rendez-vous',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: weekDays.map((day) {
                        return ElevatedButton(
                          onPressed: () {
                            final DateTime now = DateTime.now();
                            final DateTime nextDay = now.add(Duration(days: (DateTime.monday - now.weekday) % 7));
                            final DateTime selectedDay = nextDay.add(Duration(days: weekDays.indexOf(day)));

                            setState(() {
                              selectedDate = selectedDay;
                              dateController.text = '${selectedDay.day}/${selectedDay.month}/${selectedDay.year}';
                              selectedTime = null;
                              timeController.clear();
                            });
                            _showTimeSelectionDialog(selectedDay);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Text(
                            day,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: timeController,
                      decoration: const InputDecoration(
                        labelText: 'Heure du rendez-vous',
                        suffixIcon: Icon(Icons.access_time),
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                      onTap: () {
                        if (selectedDate != null) {
                          _showTimeSelectionDialog(selectedDate!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Veuillez d\'abord sélectionner une date'),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Objet du rendez-vous',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Type de rendez-vous',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: Text('À domicile - ${consultationPrices['À domicile']}'),
                          value: 'À domicile',
                          groupValue: appointmentType,
                          onChanged: (value) {
                            setState(() {
                              appointmentType = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('À l\'hôpital - ${consultationPrices['À l\'hôpital']}'),
                          value: 'À l\'hôpital',
                          groupValue: appointmentType,
                          onChanged: (value) {
                            setState(() {
                              appointmentType = value;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('En ligne - ${consultationPrices['En ligne']}'),
                          value: 'En ligne',
                          groupValue: appointmentType,
                          onChanged: (value) {
                            setState(() {
                              appointmentType = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: selectedDate != null && selectedTime != null && subjectController.text.isNotEmpty && appointmentType != null
        ? _showConfirmationDialog
        : null,
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary, // Couleur de fond
      padding: const EdgeInsets.symmetric(vertical: 16), // Padding uniforme
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Bordure arrondie
      ),
    ),
    child: const Text(
      'Confirmer le rendez-vous',
      style: TextStyle(fontSize: 16, color: Colors.white), // Texte en blanc
    ),
  ),
),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Avis des patients',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              'Patient ${index + 1}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Très bon spécialiste, je recommande !',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            5,
                            (starIndex) => Icon(
                              Icons.star,
                              color: starIndex < 4 ? Colors.amber : Colors.grey,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Action pour laisser un avis
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Laisser un avis',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}