import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, String> _userData = {
    'name': 'Nom Prenom',
    'birthdate': '15/03/1990',
    'email': 'email.example@gmail.com',
    'phone': '+228 XX XX XX XX',
    'address': 'Quartier X, Ville',
    'bloodType': 'Aucun Groupe Sanguin',
    'allergies': 'Aucune allergie',
    'emergencyContact': 'Aucun contact d\'urgence',
  };

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userData.forEach((key, value) {
        _userData[key] = prefs.getString(key) ?? value;
      });
    });
  }

  Future<void> _saveUserData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    setState(() {
      _userData[key] = value;
    });
  }

  Future<void> _editField(BuildContext context, String field, String currentValue) async {
    final controller = TextEditingController(text: currentValue);

    String? result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Modifier ${_getFieldTitle(field)}'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Entrez votre ${_getFieldTitle(field).toLowerCase()}',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Sauvegarder'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      await _saveUserData(field, result);
    }
  }

  String _getFieldTitle(String field) {
    switch (field) {
      case 'name': return 'Nom complet';
      case 'birthdate': return 'Date de naissance';
      case 'email': return 'Email';
      case 'phone': return 'Téléphone';
      case 'address': return 'Adresse';
      case 'bloodType': return 'Groupe sanguin';
      case 'allergies': return 'Allergies';
      case 'emergencyContact': return 'Contact d\'urgence';
      default: return field;
    }
  }
Widget _buildProfileHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(16, 30, 16, 60),
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            width: 250,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    ),
                  ),
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/nurse1.jpeg'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 65,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Hello',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _userData['name']!,
          style: const TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
  Widget _buildInfoCard(IconData icon, String field, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => _editField(context, field, value),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getFieldTitle(field),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.edit,
                color: AppColors.primary.withOpacity(0.5),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _generateQRCode(BuildContext context) {
    final qrData = _userData.entries.map((e) => '${_getFieldTitle(e.key)}: ${e.value}').join('\n');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Code QR'),
        content: SizedBox(
          width: 200,
          height: 250,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
                gapless: false,
                errorStateBuilder: (context, error) {
                  return const Center(
                    child: Text('Erreur de génération du QR code'),
                  );
                },
              ),
              const SizedBox(height: 10),
              const Text('Scannez ce code pour voir les informations.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Mon Profil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // TODO: Implémenter les paramètres
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoCard(Icons.person_outline, 'name', _userData['name']!),
                  _buildInfoCard(Icons.calendar_today_outlined, 'birthdate', _userData['birthdate']!),
                  _buildInfoCard(Icons.email_outlined, 'email', _userData['email']!),
                  _buildInfoCard(Icons.phone_outlined, 'phone', _userData['phone']!),
                  _buildInfoCard(Icons.location_on_outlined, 'address', _userData['address']!),
                  _buildInfoCard(Icons.bloodtype_outlined, 'bloodType', _userData['bloodType']!),
                  _buildInfoCard(Icons.warning_amber_outlined, 'allergies', _userData['allergies']!),
                  _buildInfoCard(Icons.emergency_outlined, 'emergencyContact', _userData['emergencyContact']!),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _generateQRCode(context),
                    icon: const Icon(Icons.qr_code, color: Colors.white),
                    label: const Text(
                      'Générer le code QR',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}