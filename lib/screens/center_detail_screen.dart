import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';

class CenterDetailScreen extends StatelessWidget {
  final Map<String, dynamic> center;

  const CenterDetailScreen({Key? key, required this.center}) : super(key: key);

  _launchMaps(String location) async {
    String query = Uri.encodeComponent(location);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  _launchPhone(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(center['name'] ?? 'Détails du centre'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (center.containsKey('image') && center['image'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  center['image'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 20),

            Text(
              center['name'] ?? 'Nom inconnu',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),

            _buildSectionTitle('Informations générales'),
            _buildDetailRow(Icons.location_on, 'Adresse: ${center['location'] ?? 'Non disponible'}', Colors.red),
            if (center.containsKey('description') && center['description'] != null)
              _buildDetailRow(Icons.description, 'Description: ${center['description']}', AppColors.primary),

            const SizedBox(height: 20),

            _buildSectionTitle('Contact'),
            if (center.containsKey('phone') && center['phone'] != null && center['phone'].isNotEmpty)
              _buildDetailRow(Icons.phone, 'Téléphone: ${center['phone']}', Colors.blue),

            const SizedBox(height: 20),

            _buildSectionTitle('Actions'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.map,
                  label: 'Ouvrir Maps',
                  color: Colors.redAccent,
                  onPressed: () {
                    if (center['location'] != null) {
                      _launchMaps(center['location']);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Adresse non disponible')),
                      );
                    }
                  },
                ),
                _buildActionButton(
                  icon: Icons.phone,
                  label: 'Appeler',
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (center['phone'] != null && center['phone'].isNotEmpty) {
                      _launchPhone(center['phone']);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Numéro de téléphone non disponible')),
                      );
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (center.containsKey('rating') && center['rating'] != null)
              _buildSectionTitle('Évaluation'),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    center['rating'] ?? 'Non noté',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text.isNotEmpty ? text : 'Non disponible',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}