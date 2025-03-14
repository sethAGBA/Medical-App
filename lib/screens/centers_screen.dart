import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Santé App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: CentersScreen(),
    );
  }
}

class CentersScreen extends StatefulWidget {
  @override
  _CentersScreenState createState() => _CentersScreenState();
}

class _CentersScreenState extends State<CentersScreen> {
  String selectedCategory = 'Hôpitaux';
  String selectedRegion = 'Kara';

  final List<String> categories = ['Hôpitaux', 'Pharmacies', 'Pharmacies de Garde', 'Spécialistes'];
  final List<String> regions = ['Kara', 'Centrale', 'Plateaux', 'Maritime', 'Savane'];

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
    // Ajoutez d'autres hôpitaux ici
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
      {
        "name": "Dépôt Niamtougou",
        "location": "Niamtougou, Togo",
        "phone": "26 65 01 44 / 30 04 85 15",
        "BP": "102-Niamtougou",
        "image": "assets/images/pharmas.jpg",
      },
      // Ajoutez d'autres pharmacies ici
    ],
    "Centrale": [
      {
        "name": "Pharmacie Tchaoudjo",
        "location": "Sokodé, Togo",
        "phone": "98 21 49 01",
        "BP": "295-Sokode",
        "image": "assets/images/pharmas.jpg",
      },
      // Ajoutez d'autres pharmacies ici
    ],
    // Ajoutez d'autres régions ici
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
    {
      "name": "Pharmacie KOZAH",
      "location": "Kara, Togo",
      "phone": "+22890014182",
      "region": "Kara",
      "image": "assets/images/pharmas.jpg",
      "rating": "4.3",
    },
    // Ajoutez d'autres pharmacies de garde ici
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
        title: Text('Centres de Santé', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey[100]),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barre de recherche
            TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher ...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                prefixIcon: Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
              style: TextStyle(color: Colors.grey[800]),
            ),
            SizedBox(height: 24),

            // Catégories
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        label: Text(category, style: TextStyle(color: selectedCategory == category ? Colors.white : Colors.teal)),
                        selected: selectedCategory == category,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: Colors.teal,
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: Colors.teal.withOpacity(0.2), width: 0.75),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Régions
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: regions.map((region) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        label: Text(region, style: TextStyle(color: selectedRegion == region ? Colors.white : Colors.teal)),
                        selected: selectedRegion == region,
                        onSelected: (selected) {
                          setState(() {
                            selectedRegion = region;
                          });
                        },
                        backgroundColor: Colors.white,
                        selectedColor: Colors.blueAccent,
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: Colors.teal.withOpacity(0.2), width: 0.75),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            SizedBox(height: 16),
            Text("Résultats :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey[800])),
            SizedBox(height: 8),

            // Liste des centres
            Expanded(
              child: ListView.builder(
                itemCount: filteredCenters.length,
                itemBuilder: (context, index) {
                  final center = filteredCenters[index];
                  IconData iconData;
                  if (selectedCategory == 'Hôpitaux') {
                    iconData = Icons.local_hospital;
                  } else if (selectedCategory == 'Pharmacies') {
                    iconData = Icons.local_pharmacy;
                  } else if (selectedCategory == 'Pharmacies de Garde') {
                    iconData = Icons.medical_services;
                  } else {
                    iconData = Icons.person;
                  }
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      leading: Icon(
                        iconData,
                        color: Colors.teal,
                        size: 28,
                      ),
                      title: Text(center['name'], style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.grey[800])),
                      subtitle: Text(
                        center['location'] ?? center['description'] ?? '',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: const Color.fromARGB(255, 189, 189, 189)),
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
            ),
          ],
        ),
      ),
    );
  }
}

class CenterDetailScreen extends StatelessWidget {
  final Map<String, dynamic> center;

  CenterDetailScreen({required this.center});

  // Fonction pour lancer Google Maps
  _launchMaps(String location) async {
    String query = Uri.encodeComponent(location);
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not open the map.';
    }
  }

  // Fonction pour lancer l'application Téléphone
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
        title: Text(center['name'] ?? 'Détails du centre', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              center['name'] ?? 'Nom inconnu',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.teal),
            ),
            SizedBox(height: 16),
            if (center.containsKey('location') && center['location'] != null)
              InkWell(
                onTap: () => _launchMaps(center['location']),
                child: _buildDetailRow(Icons.location_on, 'Adresse: ${center['location']}', Colors.black),
              ),
            if (center.containsKey('description') && center['description'] != null)
              _buildDetailRow(Icons.description, 'Description: ${center['description']}', Colors.grey[800]!),
            if (center.containsKey('phone') && center['phone'] != null)
              InkWell(
                onTap: () => _launchPhone(center['phone']),
                child: _buildDetailRow(Icons.phone, 'Téléphone: ${center['phone']}', Colors.grey[800]!),
              ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _launchMaps(center['location']),
                  icon: Icon(Icons.map),
                  label: Text('Ouvrir Maps'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _launchPhone(center['phone']),
                  icon: Icon(Icons.phone),
                  label: Text('Appeler'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 9, 164, 241),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: textColor.withOpacity(0.7), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}