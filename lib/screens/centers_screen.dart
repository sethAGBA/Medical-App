import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primary),
          titleTextStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const CentersScreen(),
    );
  }
}

class CentersScreen extends StatefulWidget {
  const CentersScreen({Key? key}) : super(key: key);

  @override
  _CentersScreenState createState() => _CentersScreenState();
}

class _CentersScreenState extends State<CentersScreen> {
  String selectedCategory = 'Hôpitaux';
  String selectedRegion = 'Kara';

  final List<String> categories = ['Hôpitaux', 'Pharmacies', 'Pharmacies de Garde', 'Spécialistes'];
  final List<String> regions = ['Kara', 'Centrale', 'Plateaux', 'Maritime', 'Savane'];

  // Données des spécialistes
  final List<Map<String, dynamic>> specialistsData = [
    {
      "name": "Cardiologie",
      "icon": Icons.favorite,
      "color": Colors.red[400],
      "image": "assets/images/cardio.png",
    },
    {
      "name": "Pédiatrie",
      "icon": Icons.child_care,
      "color": Colors.blue[400],
      "image": "assets/images/pediatrie.png",
    },
    {
      "name": "Dentaire",
      "icon": Icons.medical_services,
      "color": Colors.purple[400],
      "image": "assets/images/dentaire.png",
    },
    {
      "name": "Ophtalmologie",
      "icon": Icons.remove_red_eye,
      "color": Colors.green[400],
      "image": "assets/images/ophtalmo.png",
    },
    {
      "name": "Gynécologie",
      "icon": Icons.pregnant_woman,
      "color": Colors.pink[400],
      "image": "assets/images/gyneco.png",
    },
  ];

  // Données réelles des hôpitaux
  final List<Map<String, dynamic>> hospitalsData = [
    {
      "name": "Agou Centre Hospitalier Préfectoral",
      "location": "Agou, Togo",
      "coordinates": {"latitude": 6.85315, "longitude": 0.716066},
      "region": "Plateaux",
      "description": "Centre Hospitalier Préfectoral d'Agou, offrant des services de soins de santé de base et spécialisés.",
      "image": "assets/images/hospital.jpeg",
      "rating": "3.5",
    },
    {
      "name": "Amlame Centre Hospitalier Préfectoral",
      "location": "Amlame, Togo",
      "coordinates": {"latitude": 7.45615, "longitude": 0.903277},
      "region": "Plateaux",
      "description": "Centre Hospitalier Préfectoral d'Amlame, fournissant des soins médicaux essentiels à la population locale.",
      "image": "assets/images/hospital.jpeg",
      "rating": "3.2",
    },
  ];

  // Données réelles des pharmacies
  final Map<String, List<Map<String, dynamic>>> pharmaciesData = {
    "Kara": [
      {
        "name": "Pharmacie LAFIA",
        "location": "Kara, Togo",
        "phone": "26 60 04 34",
        "BP": "500-Kara",
        "image": "assets/images/pharmas.jpg",
      },
    ],
    "Centrale": [
      {
        "name": "Pharmacie Tchaoudjo",
        "location": "Sokodé, Togo",
        "phone": "98 21 49 01",
        "BP": "295-Sokode",
        "image": "assets/images/pharmas.jpg",
      },
    ],
  };

  // Données réelles des pharmacies de garde
  final List<Map<String, dynamic>> pharmaciesDeGardeData = [
    {
      "name": "Pharmacie NOUVEAU MARCHE KARA",
      "location": "Kara, Togo",
      "phone": "+22893277777",
      "region": "Kara",
      "image": "assets/images/pharmas.jpg",
      "rating": "4.5",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredCenters = [];
    if (selectedCategory == 'Hôpitaux') {
      filteredCenters = hospitalsData.where((hospital) => hospital['region'] == selectedRegion).toList();
    } else if (selectedCategory == 'Pharmacies') {
      filteredCenters = pharmaciesData[selectedRegion] ?? [];
    } else if (selectedCategory == 'Pharmacies de Garde') {
      filteredCenters = pharmaciesDeGardeData.where((pharmacy) => pharmacy['region'] == selectedRegion).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Centres de Santé'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barre de recherche
            _buildSearchBar(),
            
            // Spécialistes
            _buildSpecialists(),

            // Catégories existantes
            _buildCategories(),

            // Régions existantes
            _buildRegions(),

            // Liste des résultats
            _buildResults(filteredCenters),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Rechercher ...',
            hintStyle: TextStyle(color: AppColors.textLight),
            prefixIcon: const Icon(Icons.search, color: AppColors.primary),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialists() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Spécialistes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specialistsData.length,
              itemBuilder: (context, index) {
                final specialist = specialistsData[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: specialist['color']?.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              // Action lors du tap
                            },
                            child: Icon(
                              specialist['icon'] as IconData,
                              color: specialist['color'],
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        specialist['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Catégories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(categories[index]),
                    selected: selectedCategory == categories[index],
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = categories[index];
                      });
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: selectedCategory == categories[index] ? Colors.white : AppColors.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildRegions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Régions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: regions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(regions[index]),
                    selected: selectedRegion == regions[index],
                    onSelected: (selected) {
                      setState(() {
                        selectedRegion = regions[index];
                      });
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: selectedRegion == regions[index] ? Colors.white : AppColors.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildResults(List<Map<String, dynamic>> filteredCenters) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Résultats',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredCenters.length,
            itemBuilder: (context, index) {
              final center = filteredCenters[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Icon(Icons.local_hospital, color: AppColors.primary, size: 32),
                  title: Text(
                    center['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    center['location'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.primary),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CenterDetailScreen(center: center),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              center['name'] ?? 'Nom inconnu',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),

            // Adresse (Icône rouge)
            if (center.containsKey('location') && center['location'] != null)
              InkWell(
                onTap: () => _launchMaps(center['location']),
                child: _buildDetailRow(Icons.location_on, 'Adresse: ${center['location']}', Colors.red),
              ),

            // Description (Icône teal)
            if (center.containsKey('description') && center['description'] != null)
              _buildDetailRow(Icons.description, 'Description: ${center['description']}', AppColors.primary),

            // Téléphone (Icône bleue)
            if (center.containsKey('phone') && center['phone'] != null)
              InkWell(
                onTap: () => _launchPhone(center['phone']),
                child: _buildDetailRow(Icons.phone, 'Téléphone: ${center['phone']}', Colors.blue),
              ),

            const SizedBox(height: 16),

            // Boutons d'action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _launchMaps(center['location']),
                  icon: const Icon(Icons.map, color: Colors.white),
                  label: const Text('Ouvrir Maps', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _launchPhone(center['phone']),
                  icon: const Icon(Icons.phone, color: Colors.white),
                  label: const Text('Appeler', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  ),
                ),
              ],
            ),
          ],
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
              text,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}