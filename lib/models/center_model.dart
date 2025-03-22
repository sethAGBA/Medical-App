class CenterModel {
  final String id;
  final String name;
  final String type; // "pharmacy", "hospital", "pharmacy_garde"
  final String region; // "Maritime", "Centrale", "Plateaux", "Savane", "Kara"
  final String? address;
  final String? phone;
  final String? specialty; // Pour les spécialistes

  CenterModel({
    required this.id,
    required this.name,
    required this.type,
    required this.region,
    this.address,
    this.phone,
    this.specialty,
  });
}