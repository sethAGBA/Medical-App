import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../data/hospitals_data.dart'; // Import des hôpitaux
import '../data/pharmacies_data.dart'; // Import des pharmacies
import '../data/pharmacies_de_garde_data.dart'; // Import des pharmacies de garde
import '../data/specialists_data.dart'; // Import des spécialistes

class CentersScreen extends StatefulWidget {
  const CentersScreen({Key? key}) : super(key: key);

  @override
  _CentersScreenState createState() => _CentersScreenState();
}

class _CentersScreenState extends State<CentersScreen> {
  String selectedCategory = '🏥 Hôpitaux'; // Catégorie sélectionnée par défaut
  String selectedRegion = 'Kara'; // Région sélectionnée par défaut
  final TextEditingController _searchController = TextEditingController(); // Contrôleur pour la barre de recherche
  String searchQuery = ''; // Requête de recherche

  final List<String> categories = ['🏥 Hôpitaux', '💊 Pharmacies', '🌙 Pharmacies de Garde'];
  final List<String> regions = ['Kara', 'Centrale', 'Plateaux', 'Maritime', 'Savane'];

  @override
  void dispose() {
    _searchController.dispose(); // Nettoyer le contrôleur
    super.dispose();
  }

  // Méthode pour obtenir toutes les données combinées
  List<Map<String, dynamic>> get allData {
    return [
      ...hospitalsData,
      ...pharmaciesData.values.expand((element) => element),
      ...pharmaciesDeGardeData,
    ];
  }

  // Méthode pour filtrer les données en fonction de la recherche
  List<Map<String, dynamic>> get filteredSuggestions {
    if (searchQuery.isEmpty) {
      return []; // Ne rien afficher si la recherche est vide
    }
    return allData.where((center) {
      final name = center['name'].toString().toLowerCase();
      final location = center['location'].toString().toLowerCase();
      final query = searchQuery.toLowerCase();
      return name.contains(query) || location.contains(query);
    }).toList();
  }

  // Méthode pour filtrer les centres par région et catégorie
  List<Map<String, dynamic>> get filteredCenters {
    return allData.where((center) {
      // Vérifiez la catégorie
      final categoryMatch = selectedCategory == '🏥 Hôpitaux' && center['type'] == 'hospital' ||
          selectedCategory == '💊 Pharmacies' && center['type'] == 'pharmacy' ||
          selectedCategory == '🌙 Pharmacies de Garde' && center['type'] == 'pharmacy_de_garde';

      // Vérifiez la région
      final regionMatch = center['region'] == selectedRegion;

      return categoryMatch && regionMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centres de Santé'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            // child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barre de recherche
            _buildSearchBar(),

            // Afficher les suggestions de recherche
            if (searchQuery.isNotEmpty) _buildSearchSuggestions(),

            // Spécialistes
            _buildSpecialists(),

            // Catégories
            _buildCategories(),

            // Régions
            _buildRegions(),

            // Afficher les centres filtrés par région et catégorie
            _buildFilteredCenters(),
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
          controller: _searchController, // Associer le contrôleur
          decoration: InputDecoration(
            hintText: 'Rechercher ...',
            hintStyle: TextStyle(color: AppColors.textDark),
            prefixIcon: const Icon(Icons.search, color: AppColors.primary),
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, color: AppColors.primary),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        searchQuery = '';
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value; // Mettre à jour la requête de recherche
            });
          },
        ),
      ),
    );
  }

  Widget _buildSearchSuggestions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suggestions',
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
            itemCount: filteredSuggestions.length,
            itemBuilder: (context, index) {
              final center = filteredSuggestions[index];
              return ListTile(
                leading: Icon(Icons.location_on, color: AppColors.primary),
                title: Text(center['name']),
                subtitle: Text(center['location']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CenterDetailScreen(center: center),
                    ),
                  );
                },
              );
            },
          ),
        ],
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
            'Spécialités',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 22),
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
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF333333),
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
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

  Widget _buildRegions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Régions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: regions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(
                      regions[index],
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
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

  Widget _buildFilteredCenters() {
    final centers = filteredCenters; // Utilisez la méthode filtrée

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Centres',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          if (centers.isEmpty)
            const Text(
              'Aucun centre trouvé pour cette région et catégorie.',
              style: TextStyle(color: Colors.grey),
            ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: centers.length,
            itemBuilder: (context, index) {
              final center = centers[index];
              // Déterminer l'icône et le label en fonction de la catégorie
              IconData iconData;
              Color iconColor;
              String label;
              if (center['type'] == 'hospital') {
                iconData = Icons.local_hospital; // Icône pour les hôpitaux
                iconColor = Colors.red;
                label = 'Hôpital';
              } else if (center['type'] == 'pharmacy') {
                iconData = Icons.local_pharmacy; // Icône pour les pharmacies
                iconColor = Colors.blue;
                label = 'Pharmacie';
              } else {
                iconData = Icons.nightlight_round; // Icône pour les pharmacies de garde
                iconColor = Colors.purple;
                label = 'Pharmacie de Garde';
              }

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CenterDetailScreen(center: center),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Icône et label
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
                        // Informations du centre
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                center['name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                center['location'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              
                              if (center.containsKey('rating'))
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      center['rating'],
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
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