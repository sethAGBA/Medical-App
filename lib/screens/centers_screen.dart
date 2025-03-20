import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../data/hospitals_data.dart';
import '../data/pharmacies_data.dart';
import '../data/pharmacies_de_garde_data.dart';
import '../data/specialists_data.dart';
import 'center_detail_screen.dart';
import '../widgets/center_card.dart'; // Widget réutilisable pour afficher une carte de centre
import 'package:medical/widgets/premium_specialist_section.dart'; // Importez le composant
import 'specialist_profile_screen.dart'; // Importez l'écran de profil des spécialistes

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

  final List<String> categories = [
    '🏥 Hôpitaux',
    '💊 Pharmacies',
    '🌙 Pharmacies de Garde'
  ];
  final List<String> regions = [
    'Kara',
    'Centrale',
    'Plateaux',
    'Maritime',
    'Savane'
  ];

  // Pagination pour les spécialistes
  int _specialistsPage = 0;
  static const int _specialistsPerPage = 4;

  // Pagination pour les centres
  int _centersPage = 0;
  static const int _centersPerPage = 4;

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
      final categoryMatch = selectedCategory == '🏥 Hôpitaux' &&
              (center['type'] ?? '') == 'hospital' ||
          selectedCategory == '💊 Pharmacies' &&
              (center['type'] ?? '') == 'pharmacy' ||
          selectedCategory == '🌙 Pharmacies de Garde' &&
              (center['type'] ?? '') == 'pharmacy_de_garde';

      final regionMatch = (center['region'] ?? '') == selectedRegion;

      return categoryMatch && regionMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centres de Santé'),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            if (searchQuery.isNotEmpty) _buildSearchResults(),
            const PremiumSpecialistSection(), // Utilisez le composant avec pagination
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
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                  builder: (context) =>
                      CenterDetailScreen(center: filteredSuggestions[index]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialists() {
    final int totalSpecialists = specialistsData.length;
    final int totalPages = (totalSpecialists / _specialistsPerPage).ceil();
    final int startIndex = _specialistsPage * _specialistsPerPage;
    final int endIndex = (startIndex + _specialistsPerPage) > totalSpecialists
        ? totalSpecialists
        : (startIndex + _specialistsPerPage);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Spécialités',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    onPressed: _specialistsPage > 0
                        ? () => setState(() => _specialistsPage--)
                        : null,
                    color:
                        _specialistsPage > 0 ? AppColors.primary : Colors.grey,
                  ),
                  Text(
                    '${_specialistsPage + 1}/$totalPages',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 20),
                    onPressed: _specialistsPage < totalPages - 1
                        ? () => setState(() => _specialistsPage++)
                        : null,
                    color: _specialistsPage < totalPages - 1
                        ? AppColors.primary
                        : Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: endIndex - startIndex,
              itemBuilder: (context, index) {
                final specialist = specialistsData[startIndex + index];
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
                        setState(() {
                          selectedCategory = categories[index];
                          _centersPage = 0; // Réinitialiser la pagination
                        });
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
                        setState(() {
                          selectedRegion = regions[index];
                          _centersPage = 0; // Réinitialiser la pagination
                        });
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
    final int totalPages = (centers.length / _centersPerPage).ceil();
    final int startIndex = _centersPage * _centersPerPage;
    final int endIndex = (startIndex + _centersPerPage) > centers.length
        ? centers.length
        : (startIndex + _centersPerPage);

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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    size: 80,
                    color: AppColors.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Aucun centre trouvé pour cette région et catégorie.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: endIndex - startIndex,
              itemBuilder: (context, index) => CenterCard(
                center: centers[startIndex + index],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CenterDetailScreen(center: centers[startIndex + index]),
                  ),
                ),
              ),
            ),
          if (centers.length > _centersPerPage)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: _centersPage > 0
                      ? () => setState(() => _centersPage--)
                      : null,
                  color: _centersPage > 0 ? AppColors.primary : Colors.grey,
                ),
                Text(
                  '${_centersPage + 1}/$totalPages',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 20),
                  onPressed: _centersPage < totalPages - 1
                      ? () => setState(() => _centersPage++)
                      : null,
                  color: _centersPage < totalPages - 1
                      ? AppColors.primary
                      : Colors.grey,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
