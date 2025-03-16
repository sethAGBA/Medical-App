import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CenterCard extends StatelessWidget {
  final Map<String, dynamic> center;
  final VoidCallback onTap;

  const CenterCard({Key? key, required this.center, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color iconColor;
    String label;

    switch (center['type'] ?? '') {
      case 'hospital':
        iconData = Icons.local_hospital;
        iconColor = Colors.red;
        label = 'Hôpital';
        break;
      case 'pharmacy':
        iconData = Icons.local_pharmacy;
        iconColor = const Color.fromARGB(255, 22, 85, 36);
        label = 'Pharmacie';
        break;
      default:
        iconData = Icons.nightlight_round;
        iconColor = const Color.fromARGB(198, 241, 193, 3);
        label = 'De Garde';
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(iconData, color: iconColor, size: 40),
                    const SizedBox(height: 8),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        color: iconColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      center['name'] ?? 'Nom inconnu',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      center['location'] ?? 'Adresse non disponible',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    if (center.containsKey('rating') && center['rating'] != null)
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            center['rating'] ?? 'Non noté',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}