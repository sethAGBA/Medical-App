import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../screens/specialist_profile_screen.dart'; // Importez l'écran de profil des spécialistes

class PremiumSpecialistSection extends StatefulWidget {
  const PremiumSpecialistSection({Key? key}) : super(key: key);

  @override
  State<PremiumSpecialistSection> createState() => _PremiumSpecialistSectionState();
}

class _PremiumSpecialistSectionState extends State<PremiumSpecialistSection> {
  int _currentPage = 0;
  static const int _itemsPerPage = 3;

  final List<Map<String, dynamic>> premiumSpecialists = [
    {
      'id': 1,
      'name': 'Prof John Doe',
      'specialty': 'Dermatologue',
      'image': 'assets/images/infirmiere.jpeg',
      'rating': 4.5, // Added rating field
    },
    {
      'id': 2,
      'name': 'Dr John Smith',
      'specialty': 'Ophtalmologue',
      'image': 'assets/images/doctor.jpeg',
      'rating': 4.7, // Added rating field
    },
    {
      'id': 3,
      'name': 'Dr Michael Johnson',
      'specialty': 'Gynécologue',
      'image': 'assets/images/infirmier1.jpeg',
      'rating': 4.3, // Added rating field
    },
    {
      'id': 4,
      'name': 'Dr Emily Brown',
      'specialty': 'Cardiologue',
      'image': 'assets/images/nurse1.jpeg',
      'rating': 4.8, // Added rating field
    },
    {
      'id': 5,
      'name': 'Dr Emily Nerd',
      'specialty': 'Cardiologue',
      'image': 'assets/images/nurse2.jpeg',
      'rating': 4.6, // Added rating field
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int totalPages = (premiumSpecialists.length / _itemsPerPage).ceil();
    final int startIndex = _currentPage * _itemsPerPage;
    final int endIndex = (startIndex + _itemsPerPage) > premiumSpecialists.length
        ? premiumSpecialists.length
        : startIndex + _itemsPerPage;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Spécialistes Premium',
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
                    onPressed: _currentPage > 0
                        ? () => setState(() => _currentPage--)
                        : null,
                    color: _currentPage > 0 ? AppColors.primary : Colors.grey,
                  ),
                  Text(
                    '${_currentPage + 1}/$totalPages',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 20),
                    onPressed: _currentPage < totalPages - 1
                        ? () => setState(() => _currentPage++)
                        : null,
                    color: _currentPage < totalPages - 1
                        ? AppColors.primary
                        : Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 270,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: endIndex - startIndex,
              itemBuilder: (context, index) {
                final specialist = premiumSpecialists[startIndex + index];
                return GestureDetector(
                  onTap: () {
                    // Naviguer vers le profil du spécialiste
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpecialistProfileScreen(specialist: specialist),
                      ),
                    );
                  },
                  child: Container(
                    width: 185,
                    margin: const EdgeInsets.only(right: 16, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.asset(
                            specialist['image'],
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 120,
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: const Icon(Icons.person, size: 60, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                specialist['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                specialist['specialty'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    specialist['rating'].toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}