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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.teal),
          titleTextStyle: TextStyle(
            color: Colors.teal,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        title: Text('Centres de Santé'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.notifications),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barre de recherche
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher ...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: Colors.teal),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
            SizedBox(height: 24),

            // Catégories
            Text('Catégories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
            SizedBox(height: 8),
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: ChoiceChip(
                      label: Text(categories[index]),
                      selected: selectedCategory == categories[index],
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = categories[index];
                        });
                      },
                      selectedColor: Colors.teal,
                      labelStyle: TextStyle(color: selectedCategory == categories[index] ? Colors.white : Colors.teal),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            // Régions
            Text('Régions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
            SizedBox(height: 8),
            Container(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: regions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: ChoiceChip(
                      label: Text(regions[index]),
                      selected: selectedRegion == regions[index],
                      onSelected: (selected) {
                        setState(() {
                          selectedRegion = regions[index];
                        });
                      },
                      selectedColor: Colors.teal,
                      labelStyle: TextStyle(color: selectedRegion == regions[index] ? Colors.white : Colors.teal),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            // Résultats
            Text("Résultats :", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredCenters.length,
                itemBuilder: (context, index) {
                  final center = filteredCenters[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: Icon(Icons.local_hospital, color: Colors.teal, size: 32),
                      title: Text(center['name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      subtitle: Text(center['location'], style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
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
        iconTheme: IconThemeData(color: Colors.teal),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              center['name'] ?? 'Nom inconnu',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 16),

            // Adresse (Icône rouge)
            if (center.containsKey('location') && center['location'] != null)
              InkWell(
                onTap: () => _launchMaps(center['location']),
                child: _buildDetailRow(Icons.location_on, 'Adresse: ${center['location']}', Colors.red),
              ),

            // Description (Icône teal)
            if (center.containsKey('description') && center['description'] != null)
              _buildDetailRow(Icons.description, 'Description: ${center['description']}', Colors.teal),

            // Téléphone (Icône bleue)
            if (center.containsKey('phone') && center['phone'] != null)
              InkWell(
                onTap: () => _launchPhone(center['phone']),
                child: _buildDetailRow(Icons.phone, 'Téléphone: ${center['phone']}', Colors.blue),
              ),

            SizedBox(height: 16),

            // Boutons d'action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _launchMaps(center['location']),
                  icon: Icon(Icons.map, color: Colors.white),
                  label: Text('Ouvrir Maps', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _launchPhone(center['phone']),
                  icon: Icon(Icons.phone, color: Colors.white),
                  label: Text('Appeler', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 13),
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
          SizedBox(width: 10),
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