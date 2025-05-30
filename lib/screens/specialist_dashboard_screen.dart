
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:medical/widgets/app_colors.dart' show AppColors;
import 'package:shimmer/shimmer.dart';
import 'package:image_picker/image_picker.dart';
import '../config.dart';
import '../services/auth_service.dart';

class StyledCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool isHoverable;

  const StyledCard({
    required this.child,
    this.onTap,
    this.isHoverable = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 0,
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Color(0xFFF8FAFF),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.35, size.width * 0.5, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.25, size.width, size.height * 0.3);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SpecialistDashboardScreen extends StatefulWidget {
  final Map<String, dynamic> specialist;

  const SpecialistDashboardScreen({super.key, required this.specialist});

  @override
  State<SpecialistDashboardScreen> createState() => _SpecialistDashboardScreenState();
}

class _SpecialistDashboardScreenState extends State<SpecialistDashboardScreen> {
  late String specialty;
  late String profilePhoto;
  late String about;
  late String location;
  late Map<String, Map<int, List<TimeOfDay>>> availabilitiesByType;
  late List<Map<String, dynamic>> consultationPrices;
  List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> comments = [];
  File? _selectedImage;
  bool _isAppointmentsLoading = true;
  bool _isCommentsLoading = true;

  @override
  void initState() {
    super.initState();
    specialty = widget.specialist['specialty'] ?? 'Médecin généraliste';
    profilePhoto = widget.specialist['image'] ?? 'https://via.placeholder.com/150';
    about = widget.specialist['about'] ?? 'Pas de description pour le moment.';
    location = widget.specialist['location'] ?? 'Non spécifié';

    consultationPrices = widget.specialist['consultationPrices'] != null
        ? (widget.specialist['consultationPrices'] as Map)
            .entries
            .map((entry) => {
                  'type': entry.key,
                  'price': entry.value,
                  'isActive': true,
                })
            .toList()
        : [
            {'type': 'À domicile', 'price': '10 000 FCFA', 'isActive': true},
            {'type': 'À l\'hôpital', 'price': '8 000 FCFA', 'isActive': true},
            {'type': 'En ligne', 'price': '5 000 FCFA', 'isActive': true},
          ];

    // Initialize availabilities from server data or default
    final serverAvailabilities = widget.specialist['availabilities'] as Map<String, dynamic>?;
    availabilitiesByType = {};
    for (var price in consultationPrices.where((p) => p['isActive'])) {
      final type = price['type'];
      final typeAvailabilities = serverAvailabilities?[type] as Map<String, dynamic>? ?? {};
      availabilitiesByType[type] = {
        for (int day = DateTime.monday; day <= DateTime.friday; day++)
          day: (typeAvailabilities[day.toString()] as List<dynamic>?)?.map((t) {
                final time = t as Map<String, dynamic>;
                return TimeOfDay(hour: time['hour'] as int, minute: time['minute'] as int);
              }).toList() ?? [],
      };
    }

    fetchAppointments();
    fetchComments();
  }

  Future<void> fetchAppointments() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Utilisateur non authentifié');

      final response = await http.get(
        Uri.parse('${Config.usersUrl}/${widget.specialist['id']}/appointments'),
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      ).timeout(Config.timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          appointments = List<Map<String, dynamic>>.from(data);
          _isAppointmentsLoading = false;
        });
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      setState(() => _isAppointmentsLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement des rendez-vous: $e')),
        );
      }
    }
  }

  Future<void> fetchComments() async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Utilisateur non authentifié');

      final response = await http.get(
        Uri.parse('${Config.usersUrl}/${widget.specialist['id']}/reviews'),
        headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'},
      ).timeout(Config.timeoutDuration);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          comments = List<Map<String, dynamic>>.from(data);
          _isCommentsLoading = false;
        });
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      setState(() => _isCommentsLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors du chargement des avis: $e')),
        );
      }
    }
  }

  Future<void> updateProfile() async {
    try {
      // Validate availabilities
      for (var type in availabilitiesByType.keys) {
        if (!consultationPrices.any((p) => p['type'] == type && p['isActive'])) {
          throw Exception('Type de consultation $type non actif');
        }
      }

      final updatedData = {
        'specialty': specialty,
        'profilePhoto': profilePhoto,
        'about': about,
        'location': location,
        'availabilities': availabilitiesByType.map(
          (type, hours) => MapEntry(
            type,
            hours.map(
              (day, times) => MapEntry(
                day.toString(),
                times.map((t) => {'hour': t.hour, 'minute': t.minute}).toList(),
              ),
            ),
          ),
        ),
        'consultationPrices': consultationPrices
            .map((e) => {e['type']: e['price']})
            .reduce((a, b) => {...a, ...b}),
      };

      final token = await AuthService.getToken();
      if (token == null) throw Exception('Utilisateur non authentifié');

      // Upload image if selected
      if (_selectedImage != null) {
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('${Config.usersUrl}/${widget.specialist['id']}/upload-image'),
        );
        request.headers['Authorization'] = 'Bearer $token';
        request.files.add(await http.MultipartFile.fromPath('image', _selectedImage!.path));
        final response = await request.send();
        if (response.statusCode == 200) {
          final data = jsonDecode(await response.stream.bytesToString());
          updatedData['profilePhoto'] = data['url'];
          setState(() {
            profilePhoto = data['url'];
            _selectedImage = null;
          });
        } else {
          throw Exception('Erreur lors du téléchargement de l\'image');
        }
      }

      final response = await http.put(
        Uri.parse('${Config.usersUrl}/${widget.specialist['id']}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(updatedData),
      ).timeout(Config.timeoutDuration);

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profil mis à jour avec succès !')),
          );
        }
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la mise à jour du profil: $e')),
        );
      }
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      final token = await AuthService.getToken();
      if (token == null) throw Exception('Utilisateur non authentifié');

      final response = await http.delete(
        Uri.parse('${Config.usersUrl}/${widget.specialist['id']}/reviews/$commentId'),
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(Config.timeoutDuration);

      if (response.statusCode == 200) {
        setState(() {
          comments.removeWhere((comment) => comment['id'] == commentId);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Avis supprimé avec succès !')),
          );
        }
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la suppression de l\'avis: $e')),
        );
      }
    }
  }

  Future<void> _showUpdateConfirmationDialog() async {
    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.cardBackground,
        title: const Text('Confirmer les modifications',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        content: const Text('Voulez-vous enregistrer les modifications apportées à votre profil ?',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler', style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await updateProfile();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text('Enregistrer', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image sélectionnée, enregistrez pour confirmer')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final hasUnsavedChanges = specialty != (widget.specialist['specialty'] ?? 'Médecin généraliste') ||
            location != (widget.specialist['location'] ?? 'Non spécifié') ||
            about != (widget.specialist['about'] ?? 'Pas de description pour le moment.') ||
            _selectedImage != null ||
            availabilitiesByType.entries.any((entry) => entry.value.entries.any((day) => day.value.isNotEmpty)) ||
            consultationPrices !=
                (widget.specialist['consultationPrices'] != null
                    ? (widget.specialist['consultationPrices'] as Map)
                        .entries
                        .map((entry) => {
                              'type': entry.key,
                              'price': entry.value,
                              'isActive': true,
                            })
                        .toList()
                    : [
                        {'type': 'À domicile', 'price': '10 000 FCFA', 'isActive': true},
                        {'type': 'À l\'hôpital', 'price': '8 000 FCFA', 'isActive': true},
                        {'type': 'En ligne', 'price': '5 000 FCFA', 'isActive': true},
                      ]);

        return await showDialog<bool>(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                backgroundColor: AppColors.cardBackground,
                title: const Text(
                  'Quitter l\'application',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                content: Text(
                  hasUnsavedChanges
                      ? 'Vous avez des modifications non enregistrées. Voulez-vous vraiment quitter l\'application ?'
                      : 'Voulez-vous vraiment quitter l\'application ?',
                  style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
                ),
                actions: [
                  Semantics(
                    label: 'Annuler la fermeture de l\'application',
                    child: TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        'Annuler',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      ),
                    ),
                  ),
                  Semantics(
                    label: 'Confirmer la fermeture de l\'application',
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Quitter',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          slivers: [
            _buildModernHeader(),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                delegate: SliverChildListDelegate([
                  _buildProfileCard(),
                  _buildStatsOverview(),
                  _buildUpcomingAppointments(),
                  _buildReviews(),
                  _buildAvailabilityManager(),
                  _buildPricesCard(),
                ]),
              ),
            ),
          ],
        ),
        floatingActionButton: _buildGlassyFAB(),
      ),
    );
  }

  Widget _buildModernHeader() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: BackgroundPatternPainter(),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : profilePhoto.isNotEmpty
                                  ? CachedNetworkImageProvider(profilePhoto)
                                  : null,
                          backgroundColor: AppColors.inputFill,
                          child: _selectedImage == null && profilePhoto.isEmpty
                              ? const Icon(Icons.person, size: 40, color: AppColors.textSecondary)
                              : null,
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.specialist['name'] ?? 'Dr.',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      specialty,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                title: const Text('Déconnexion',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                content: const Text('Voulez-vous vraiment vous déconnecter ?',
                    style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Annuler', style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: TextButton.styleFrom(foregroundColor: AppColors.error),
                    child: const Text('Déconnexion', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            );
            if (confirmed == true) {
              await AuthService.logout();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/signin', (route) => false);
              }
            }
          },
          tooltip: 'Déconnexion',
        ),
      ],
    );
  }

  Widget _buildGlassyFAB() {
    return FloatingActionButton.extended(
      onPressed: _showUpdateConfirmationDialog,
      label: const Text('Sauvegarder', style: TextStyle(fontSize: 16, color: Colors.white)),
      icon: const Icon(Icons.save, color: Colors.white),
      backgroundColor: AppColors.primary.withOpacity(0.9),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  Widget _buildProfileCard() {
    return StyledCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Spécialité',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                ),
                filled: true,
                fillColor: AppColors.inputFill,
                prefixIcon: const Icon(Icons.medical_services, color: AppColors.primary),
                labelStyle: const TextStyle(color: AppColors.textSecondary),
              ),
              controller: TextEditingController(text: specialty),
              onChanged: (value) => setState(() => specialty = value),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Localisation',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                ),
                filled: true,
                fillColor: AppColors.inputFill,
                prefixIcon: const Icon(Icons.location_on, color: AppColors.primary),
                labelStyle: const TextStyle(color: AppColors.textSecondary),
              ),
              controller: TextEditingController(text: location),
              onChanged: (value) => setState(() => location = value),
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'À propos',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.inputBorder),
                ),
                filled: true,
                fillColor: AppColors.inputFill,
                prefixIcon: const Icon(Icons.info, color: AppColors.primary),
                labelStyle: const TextStyle(color: AppColors.textSecondary),
              ),
              controller: TextEditingController(text: about),
              maxLines: 3,
              onChanged: (value) => setState(() => about = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsOverview() {
    return StyledCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Rendez-vous', appointments.length.toString(), Icons.calendar_today),
            _buildStatItem('Avis', comments.length.toString(), Icons.star),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 32, color: AppColors.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingAppointments() {
    return StyledCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rendez-vous à venir',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            _isAppointmentsLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: List.generate(
                        3,
                        (_) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          height: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : appointments.isEmpty
                    ? Text(
                        'Aucun rendez-vous',
                        style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                      )
                    : Column(
                        children: [
                          ...appointments.take(3).map((apt) => Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: AppColors.divider),
                                ),
                                child: ListTile(
                                  leading: const Icon(Icons.event, color: AppColors.primary),
                                  title: Text(
                                    '${apt['patient']} - ${apt['type']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${apt['date']} à ${apt['time']}',
                                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.chat, color: AppColors.primary),
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Chat non implémenté')),
                                      );
                                    },
                                  ),
                                ),
                              )),
                          if (appointments.length > 3)
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AppointmentsListScreen(appointments: appointments),
                                  ),
                                );
                              },
                              child: const Text('Voir plus', style: TextStyle(color: AppColors.primary)),
                            ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviews() {
    final averageRating = comments.isEmpty
        ? 0.0
        : comments.map((c) => (c['rating'] as num).toDouble()).reduce((a, b) => a + b) / comments.length;

    return StyledCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Avis des patients',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Note moyenne: ${averageRating.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                ),
                const SizedBox(width: 8),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < averageRating.floor() ? Icons.star : Icons.star_border,
                      color: index < averageRating.floor() ? AppColors.warning : AppColors.divider,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _isCommentsLoading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: List.generate(
                        3,
                        (_) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          height: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : comments.isEmpty
                    ? Text(
                        'Aucun avis',
                        style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                      )
                    : Column(
                        children: [
                          ...comments.take(3).map((comment) => Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: AppColors.divider),
                                ),
                                child: ListTile(
                                  leading: const Icon(Icons.comment, color: AppColors.primary),
                                  title: Text(
                                    comment['patient'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  subtitle: Text(
                                    comment['text'],
                                    style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete, color: AppColors.error),
                                    onPressed: () => deleteComment(comment['id']),
                                  ),
                                ),
                              )),
                          if (comments.length > 3)
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommentsListScreen(comments: comments),
                                  ),
                                );
                              },
                              child: const Text('Voir plus', style: TextStyle(color: AppColors.primary)),
                            ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityManager() {
    final activePrices = consultationPrices.where((p) => p['isActive']).toList();
    return StyledCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Disponibilités par type de consultation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            if (activePrices.isEmpty)
              const Center(
                child: Text(
                  'Aucun type de consultation actif',
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
              )
            else
              Expanded(
                child: DefaultTabController(
                  length: activePrices.length,
                  child: Column(
                    children: [
                      TabBar(
                        isScrollable: true,
                        labelColor: AppColors.primary,
                        unselectedLabelColor: AppColors.textSecondary,
                        indicatorColor: AppColors.primary,
                        tabs: activePrices.map((price) => Tab(text: price['type'])).toList(),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TabBarView(
                          children: activePrices.map((price) => _buildAvailabilityTab(price['type'])).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityTab(String consultationType) {
    final availabilities = availabilitiesByType[consultationType] ?? {};

    return SingleChildScrollView(
      child: Column(
        children: [
          ...availabilities.entries.map((entry) {
            final dayName = [
              'Lundi',
              'Mardi',
              'Mercredi',
              'Jeudi',
              'Vendredi',
              'Samedi',
              'Dimanche'
            ][entry.key - 1];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(
                  dayName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                subtitle: Text(
                  entry.value.isEmpty
                      ? 'Aucun horaire défini'
                      : entry.value
                          .map((t) => '${t.hour}:${t.minute.toString().padLeft(2, '0')}')
                          .join(', '),
                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit, color: AppColors.primary),
                  onPressed: () => _showAddAvailabilityDialog(consultationType, entry.key, entry.value),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _showAddAvailabilityDialog(String type, int day, List<TimeOfDay> currentHours) async {
    List<TimeOfDay> newHours = List.from(currentHours);

    final result = await showDialog<List<TimeOfDay>>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: AppColors.cardBackground,
          title: Text(
            'Horaires pour $type',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (newHours.isEmpty)
                  const Text(
                    'Aucun horaire défini',
                    style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                ...newHours.map(
                  (time) => ListTile(
                    title: Text(
                      '${time.hour}:${time.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: AppColors.error),
                      onPressed: () => setDialogState(() => newHours.remove(time)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: const TimeOfDay(hour: 9, minute: 0),
                      builder: (context, child) => Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(primary: AppColors.primary),
                        ),
                        child: child!,
                      ),
                    );
                    if (time != null) {
                      if (newHours.any((t) => t.hour == time.hour && t.minute == time.minute)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cet horaire existe déjà')),
                        );
                        return;
                      }
                      if (time.hour < 8 || time.hour > 18) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Veuillez sélectionner un horaire entre 8h et 18h')),
                        );
                        return;
                      }
                      setDialogState(() {
                        newHours.add(time);
                        newHours.sort((a, b) => a.hour * 60 + a.minute - (b.hour * 60 + b.minute));
                      });
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Ajouter un horaire', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Annuler', style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, newHours),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Enregistrer', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      setState(() {
        availabilitiesByType[type]![day] = result;
      });
    }
  }

  Widget _buildPricesCard() {
    final newTypeController = TextEditingController();
    final newPriceController = TextEditingController();

    return StyledCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Types de consultations et Prix',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: AppColors.primary),
                  onPressed: () => _showAddPriceDialog(newTypeController, newPriceController),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: consultationPrices.isEmpty
                  ? const Center(
                      child: Text(
                        'Aucun tarif défini',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      itemCount: consultationPrices.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final price = consultationPrices[index];
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.inputFill,
                            border: Border.all(
                              color: price['isActive'] ? AppColors.primary.withOpacity(0.2) : AppColors.divider,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      price['type'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: price['isActive'] ? AppColors.textPrimary : AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      price['price'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: price['isActive'] ? AppColors.primary : AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Switch(
                                    value: price['isActive'],
                                    onChanged: (value) => setState(() {
                                      consultationPrices[index]['isActive'] = value;
                                      if (!value) {
                                        availabilitiesByType.remove(price['type']);
                                      } else {
                                        availabilitiesByType[price['type']] = {
                                          for (int day = DateTime.monday; day <= DateTime.friday; day++) day: [],
                                        };
                                      }
                                    }),
                                    activeColor: AppColors.primary,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 20),
                                    color: AppColors.primary,
                                    onPressed: () => _showEditPriceDialog(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20),
                                    color: AppColors.error,
                                    onPressed: () => _showDeletePriceDialog(index),
                                  ),
                                ],
                              ),
                            ],
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

  void _showAddPriceDialog(TextEditingController typeController, TextEditingController priceController) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un tarif'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                labelText: 'Type de consultation',
                prefixIcon: Icon(Icons.medical_services),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Prix',
                prefixIcon: Icon(Icons.payments),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (typeController.text.isNotEmpty && priceController.text.isNotEmpty) {
                setState(() {
                  consultationPrices.add({
                    'type': typeController.text,
                    'price': '${priceController.text} FCFA',
                    'isActive': true,
                  });
                  availabilitiesByType[typeController.text] = {
                    for (int day = DateTime.monday; day <= DateTime.friday; day++) day: [],
                  };
                });
                Navigator.pop(context);
                typeController.clear();
                priceController.clear();
              }
            },
            icon: const Icon(Icons.add),
            label: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  void _showEditPriceDialog(int index) {
    final price = consultationPrices[index];
    final typeController = TextEditingController(text: price['type']);
    final priceController = TextEditingController(text: price['price'].toString().replaceAll(' FCFA', ''));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le tarif'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: typeController,
              decoration: const InputDecoration(
                labelText: 'Type de consultation',
                prefixIcon: Icon(Icons.medical_services),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Prix',
                prefixIcon: Icon(Icons.payments),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              final oldType = consultationPrices[index]['type'];
              setState(() {
                consultationPrices[index] = {
                  'type': typeController.text,
                  'price': '${priceController.text} FCFA',
                  'isActive': price['isActive'],
                };
                if (oldType != typeController.text) {
                  availabilitiesByType[typeController.text] = availabilitiesByType.remove(oldType) ?? {
                    for (int day = DateTime.monday; day <= DateTime.friday; day++) day: [],
                  };
                }
              });
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
            label: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  void _showDeletePriceDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le tarif'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce tarif ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                final type = consultationPrices[index]['type'];
                consultationPrices.removeAt(index);
                availabilitiesByType.remove(type);
              });
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
            label: const Text('Supprimer'),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
          ),
        ],
      ),
    );
  }
}

class AppointmentsListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  const AppointmentsListScreen({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tous les rendez-vous'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: appointments.isEmpty
            ? Center(
                child: Text('Aucun rendez-vous', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)))
            : ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final apt = appointments[index];
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.divider),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.event, color: AppColors.primary),
                      title: Text(
                        '${apt['patient']} - ${apt['type']}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                      ),
                      subtitle: Text(
                        '${apt['date']} à ${apt['time']}',
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.chat, color: AppColors.primary),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Chat non implémenté')),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class CommentsListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> comments;

  const CommentsListScreen({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tous les avis'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: comments.isEmpty
            ? Center(child: Text('Aucun avis', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)))
            : ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  final comment = comments[index];
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.divider),
                    ),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: const Icon(Icons.comment, color: AppColors.primary),
                      title: Text(
                        comment['patient'],
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                      ),
                      subtitle: Text(
                        comment['text'],
                        style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: AppColors.error),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Suppression non implémentée dans cette vue')),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
