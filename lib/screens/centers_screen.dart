import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/hospitals_data.dart';
import '../data/pharmacies_data.dart';
import '../data/pharmacies_de_garde_data.dart';
import '../data/specialists_data.dart';
import 'center_detail_screen.dart';
import '../widgets/center_card.dart'; // Widget réutilisable pour afficher une carte de centre

class CentersScreen extends StatefulWidget {
  const CentersScreen({Key? key}) : super(key: key);

  @override
  _CentersScreenState createState() => _CentersScreenState();
}

class _CentersScreenState extends State<CentersScreen> {
  String selectedCategory = '🏥 Hôpitaux';
  String selectedRegion = 'Kara';
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  final List<String> categories = ['🏥 Hôpitaux', '💊 Pharmacies', '🌙 Pharmacies de Garde'];
  final List<String> regions = ['Kara', 'Centrale', 'Plateaux', 'Maritime', 'Savane'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get allData {
    return [
      ...hospitalsData,
      ...pharmaciesData.values.expand((element) => element),
      ...pharmaciesDeGardeData,
    ];
  }

  List<Map<String, dynamic>> get filteredSuggestions {
    if (searchQuery.isEmpty) return [];
    return allData.where((center) {
      final name = center['name']?.toString().toLowerCase() ?? '';
      final location = center['location']?.toString().toLowerCase() ?? '';
      final query = searchQuery.toLowerCase();
      return name.contains(query) || location.contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get filteredCenters {
    return allData.where((center) {
      final categoryMatch = selectedCategory == '🏥 Hôpitaux' && (center['type'] ?? '') == 'hospital' ||
          selectedCategory == '💊 Pharmacies' && (center['type'] ?? '') == 'pharmacy' ||
          selectedCategory == '🌙 Pharmacies de Garde' && (center['type'] ?? '') == 'pharmacy_de_garde';

      final regionMatch = (center['region'] ?? '') == selectedRegion;

      return categoryMatch && regionMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centres de Santé'),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            if (searchQuery.isNotEmpty) _buildSearchResults(),
            _buildSpecialists(),
            _buildCategories(),
            _buildRegions(),
            _buildCentersList(),
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
          controller: _searchController,
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
          onChanged: (value) => setState(() => searchQuery = value),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
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
            itemCount: filteredSuggestions.length,
            itemBuilder: (context, index) => CenterCard(
              center: filteredSuggestions[index],
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CenterDetailScreen(center: filteredSuggestions[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialists() {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                            onTap: () {},
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
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                      style: const TextStyle(fontSize: 18),
                    ),
                    selected: selectedCategory == categories[index],
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => selectedCategory = categories[index]);
                      }
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: selectedCategory == categories[index] 
                          ? Colors.white 
                          : AppColors.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegions() {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                      style: const TextStyle(fontSize: 18),
                    ),
                    selected: selectedRegion == regions[index],
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => selectedRegion = regions[index]);
                      }
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: selectedRegion == regions[index] 
                          ? Colors.white 
                          : AppColors.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCentersList() {
    final centers = filteredCenters;
    return Padding(
      padding: const EdgeInsets.all(16),
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
            const Center(
              child: Text(
                'Aucun centre trouvé pour cette région et catégorie.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: centers.length > 3 ? 3 : centers.length,
              itemBuilder: (context, index) => CenterCard(
                center: centers[index],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CenterDetailScreen(center: centers[index]),
                  ),
                ),
              ),
            ),
          if (centers.length > 3)
            Center(
              child: TextButton(
                onPressed: () => _showAllCenters(context, centers),
                child: const Text(
                  'Voir plus',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showAllCenters(BuildContext context, List<Map<String, dynamic>> centers) {
    int currentPage = 0; // Page actuelle
    final int itemsPerPage = 10; // Nombre de centres par page

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          final int totalPages = (centers.length / itemsPerPage).ceil(); // Nombre total de pages
          final int startIndex = currentPage * itemsPerPage; // Index de début
          final int endIndex = (startIndex + itemsPerPage) > centers.length
              ? centers.length
              : (startIndex + itemsPerPage); // Index de fin

          return Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                const Text(
                  'Tous les centres',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: endIndex - startIndex,
                    itemBuilder: (context, index) {
                      final center = centers[startIndex + index];
                      return CenterCard(
                        center: center,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CenterDetailScreen(center: center),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Pagination
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: currentPage > 0
                          ? () {
                              setState(() {
                                currentPage--;
                              });
                            }
                          : null,
                    ),
                    Text(
                      'Page ${currentPage + 1} sur $totalPages',
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: currentPage < totalPages - 1
                          ? () {
                              setState(() {
                                currentPage++;
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}