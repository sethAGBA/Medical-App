// import 'dart:convert';
// import 'user_model.dart';

// class ProfessionalModel extends UserModel {
//   final String? specialty;
//   final String? license;
//   final List<String>? certificates;
//   final double? rating;
//   final int? reviewCount;
//   final String? about;
//   final String? location;
//   final Map<String, Map<int, List<Map<String, int>>>>? availabilities;
//   final Map<String, dynamic>? consultationPrices;

//   ProfessionalModel({
//     required String id,
//     String? email,
//     required String fullName,
//     required String profilePhoto,
//     String? phoneNumber,
//     String role = 'professional',
//     String? dateOfBirth,
//     String? gender,
//     String? address,
//     String? bloodType,
//     String? allergies,
//     String? emergencyContact,
//     String? lastMessage,
//     String? lastMessageTime,
//     bool isOnline = false,
//     this.specialty,
//     this.license,
//     this.certificates,
//     this.rating,
//     this.reviewCount,
//     this.about,
//     this.location,
//     this.availabilities,
//     this.consultationPrices,
//   }) : super(
//           id: id,
//           email: email,
//           fullName: fullName,
//           profilePhoto: profilePhoto,
//           phoneNumber: phoneNumber,
//           role: role,
//           dateOfBirth: dateOfBirth,
//           gender: gender,
//           address: address,
//           bloodType: bloodType,
//           allergies: allergies,
//           emergencyContact: emergencyContact,
//           lastMessage: lastMessage,
//           lastMessageTime: lastMessageTime,
//           isOnline: isOnline,
//         );

//   factory ProfessionalModel.fromMap(Map<String, dynamic> data) {
//     return ProfessionalModel(
//       id: data['id']?.toString() ?? data['_id']?.toString() ?? '',
//       email: data['email']?.toString(),
//       fullName: data['fullName']?.toString() ?? '',
//       profilePhoto: data['profilePhoto']?.toString() ?? 'https://via.placeholder.com/150',
//       phoneNumber: data['phoneNumber']?.toString(),
//       role: data['role']?.toString() ?? 'professional',
//       dateOfBirth: data['dateOfBirth']?.toString()?.split('T')[0],
//       gender: data['gender']?.toString(),
//       address: data['address']?.toString(),
//       bloodType: data['bloodType']?.toString(),
//       allergies: data['allergies']?.toString(),
//       emergencyContact: data['emergencyContact']?.toString(),
//       lastMessage: data['lastMessage']?.toString(),
//       lastMessageTime: data['lastMessageTime']?.toString(),
//       isOnline: data['isOnline'] == true,
//       specialty: data['specialty']?.toString() ?? data['speciality']?.toString(),
//       license: data['license']?.toString(),
//       certificates: data['certificates'] != null
//           ? List<String>.from(data['certificates'].map((x) => x.toString()))
//           : null,
//       rating: data['rating'] != null ? double.tryParse(data['rating'].toString()) : null,
//       reviewCount: data['reviewCount'] != null ? int.tryParse(data['reviewCount'].toString()) : null,
//       about: data['about']?.toString(),
//       location: data['location']?.toString(),
//       availabilities: data['availabilities'] != null
//           ? (data['availabilities'] as Map<String, dynamic>).map(
//               (type, hours) => MapEntry(
//                 type,
//                 (hours as Map<String, dynamic>).map(
//                   (day, times) => MapEntry(
//                     int.parse(day),
//                     (times as List<dynamic>).map((t) => {
//                           'hour': t['hour'] as int,
//                           'minute': t['minute'] as int,
//                         }).toList(),
//                   ),
//                 ),
//               ),
//             )
//           : null,
//       consultationPrices: data['consultationPrices'] != null
//           ? Map<String, dynamic>.from(data['consultationPrices'])
//           : null,
//     );
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       ...super.toJson(),
//       'specialty': specialty,
//       'license': license,
//       'certificates': certificates,
//       'rating': rating,
//       'reviewCount': reviewCount,
//       'about': about,
//       'location': location,
//       'availabilities': availabilities?.map(
//         (type, hours) => MapEntry(
//           type,
//           hours.map(
//             (day, times) => MapEntry(
//               day.toString(),
//               times.map((t) => {'hour': t['hour'], 'minute': t['minute']}).toList(),
//             ),
//           ),
//         ),
//       ),
//       'consultationPrices': consultationPrices,
//     };
//   }

//   String toJsonString() => json.encode(toJson());

//   factory ProfessionalModel.fromJson(String source) => ProfessionalModel.fromMap(json.decode(source));

//   @override
//   ProfessionalModel copyWith({
//     String? id,
//     String? email,
//     String? fullName,
//     String? profilePhoto,
//     String? phoneNumber,
//     String? role,
//     String? dateOfBirth,
//     String? gender,
//     String? address,
//     String? bloodType,
//     String? allergies,
//     String? emergencyContact,
//     String? lastMessage,
//     String? lastMessageTime,
//     bool? isOnline,
//     String? specialty,
//     String? license,
//     List<String>? certificates,
//     double? rating,
//     int? reviewCount,
//     String? about,
//     String? location,
//     Map<String, Map<int, List<Map<String, int>>>>? availabilities,
//     Map<String, dynamic>? consultationPrices,
//   }) {
//     return ProfessionalModel(
//       id: id ?? this.id,
//       email: email ?? this.email,
//       fullName: fullName ?? this.fullName,
//       profilePhoto: profilePhoto ?? this.profilePhoto,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       role: role ?? this.role,
//       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//       gender: gender ?? this.gender,
//       address: address ?? this.address,
//       bloodType: bloodType ?? this.bloodType,
//       allergies: allergies ?? this.allergies,
//       emergencyContact: emergencyContact ?? this.emergencyContact,
//       lastMessage: lastMessage ?? this.lastMessage,
//       lastMessageTime: lastMessageTime ?? this.lastMessageTime,
//       isOnline: isOnline ?? this.isOnline,
//       specialty: specialty ?? this.specialty,
//       license: license ?? this.license,
//       certificates: certificates ?? this.certificates,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//       about: about ?? this.about,
//       location: location ?? this.location,
//       availabilities: availabilities ?? this.availabilities,
//       consultationPrices: consultationPrices ?? this.consultationPrices,
//     );
//   }

//   @override
//   bool get isProfessional => role == 'professional';

//   @override
//   String get fullTitle {
//     if (isProfessional) {
//       return 'Dr. $fullName${specialty != null ? ' - $specialty' : ''}';
//     }
//     return fullName;
//   }

//   @override
//   String? get ratingDisplay {
//     if (rating == null) return null;
//     return '${rating!.toStringAsFixed(1)}/5.0 (${reviewCount ?? 0} avis)';
//   }
// }






import 'dart:convert';
import 'user_model.dart';

class ProfessionalModel extends UserModel {
  final String? specialty;
  final String? license;
  final List<String>? certificates;
  final double? rating;
  final int? reviewCount;
  final String? about;
  final String? location;
  final Map<String, Map<int, List<Map<String, int>>>>? availabilities;
  final Map<String, dynamic>? consultationPrices;

  ProfessionalModel({
    required String id,
    String? email,
    required String fullName,
    required String profilePhoto,
    String? phoneNumber,
    String role = 'professional',
    String? dateOfBirth,
    String? gender,
    String? address,
    String? bloodType,
    String? allergies,
    String? emergencyContact,
    String? lastMessage,
    String? lastMessageTime,
    bool isOnline = false,
    this.specialty,
    this.license,
    this.certificates,
    this.rating,
    this.reviewCount,
    this.about,
    this.location,
    this.availabilities,
    this.consultationPrices,
  }) : super(
          id: id,
          email: email,
          fullName: fullName,
          profilePhoto: profilePhoto,
          phoneNumber: phoneNumber,
          role: role,
          dateOfBirth: dateOfBirth,
          gender: gender,
          address: address,
          bloodType: bloodType,
          allergies: allergies,
          emergencyContact: emergencyContact,
          lastMessage: lastMessage,
          lastMessageTime: lastMessageTime,
          isOnline: isOnline,
        );

  factory ProfessionalModel.fromMap(Map<String, dynamic> data) {
    // Extract professional data if nested, default to empty map if absent
    final professionalData = data['professional'] as Map<String, dynamic>? ?? {};
    // Merge root and professional data, prioritizing root-level fields
    final mergedData = {...professionalData, ...data};
    
    // Log the specialty for debugging truncation issue
    print('ProfessionalModel.fromMap specialty: ${mergedData['specialty']}');

    return ProfessionalModel(
      id: mergedData['id']?.toString() ?? mergedData['_id']?.toString() ?? '',
      email: mergedData['email']?.toString(),
      fullName: mergedData['fullName']?.toString() ?? '',
      profilePhoto: mergedData['profilePhoto']?.toString() ?? 'https://via.placeholder.com/150',
      phoneNumber: mergedData['phoneNumber']?.toString(),
      role: mergedData['role']?.toString() ?? 'professional',
      dateOfBirth: mergedData['dateOfBirth']?.toString()?.split('T')[0],
      gender: mergedData['gender']?.toString(),
      address: mergedData['address']?.toString(),
      bloodType: mergedData['bloodType']?.toString(),
      allergies: mergedData['allergies']?.toString(),
      emergencyContact: mergedData['emergencyContact']?.toString(),
      lastMessage: mergedData['lastMessage']?.toString(),
      lastMessageTime: mergedData['lastMessageTime']?.toString(),
      isOnline: mergedData['isOnline'] == true,
      specialty: mergedData['specialty']?.toString() ?? mergedData['speciality']?.toString(),
      license: mergedData['license']?.toString(),
      certificates: mergedData['certificates'] != null
          ? List<String>.from(mergedData['certificates'].map((x) => x.toString()))
          : null,
      rating: mergedData['rating'] != null ? double.tryParse(mergedData['rating'].toString()) : null,
      reviewCount: mergedData['reviewCount'] != null ? int.tryParse(mergedData['reviewCount'].toString()) : null,
      about: mergedData['about']?.toString(),
      location: mergedData['location']?.toString(),
      availabilities: mergedData['availabilities'] != null
          ? (mergedData['availabilities'] as Map<String, dynamic>).map(
              (type, hours) => MapEntry(
                type,
                (hours as Map<String, dynamic>).map(
                  (day, times) => MapEntry(
                    int.parse(day),
                    (times as List<dynamic>).map((t) => {
                          'hour': t['hour'] as int,
                          'minute': t['minute'] as int,
                        }).toList(),
                  ),
                ),
              ),
            )
          : null,
      consultationPrices: mergedData['consultationPrices'] != null
          ? Map<String, dynamic>.from(mergedData['consultationPrices'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'specialty': specialty,
      'license': license,
      'certificates': certificates,
      'rating': rating,
      'reviewCount': reviewCount,
      'about': about,
      'location': location,
      'availabilities': availabilities?.map(
        (type, hours) => MapEntry(
          type,
          hours.map(
            (day, times) => MapEntry(
              day.toString(),
              times.map((t) => {'hour': t['hour'], 'minute': t['minute']}).toList(),
            ),
          ),
        ),
      ),
      'consultationPrices': consultationPrices,
    };
  }

  String toJsonString() => json.encode(toJson());

  factory ProfessionalModel.fromJson(String source) => ProfessionalModel.fromMap(json.decode(source));

  @override
  ProfessionalModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? profilePhoto,
    String? phoneNumber,
    String? role,
    String? dateOfBirth,
    String? gender,
    String? address,
    String? bloodType,
    String? allergies,
    String? emergencyContact,
    String? lastMessage,
    String? lastMessageTime,
    bool? isOnline,
    String? specialty,
    String? license,
    List<String>? certificates,
    double? rating,
    int? reviewCount,
    String? about,
    String? location,
    Map<String, Map<int, List<Map<String, int>>>>? availabilities,
    Map<String, dynamic>? consultationPrices,
  }) {
    return ProfessionalModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      isOnline: isOnline ?? this.isOnline,
      specialty: specialty ?? this.specialty,
      license: license ?? this.license,
      certificates: certificates ?? this.certificates,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      about: about ?? this.about,
      location: location ?? this.location,
      availabilities: availabilities ?? this.availabilities,
      consultationPrices: consultationPrices ?? this.consultationPrices,
    );
  }

  @override
  bool get isProfessional => role == 'professional';

  @override
  String get fullTitle {
    if (isProfessional) {
      return 'Dr. $fullName${specialty != null ? ' - $specialty' : ''}';
    }
    return fullName;
  }

  @override
  String? get ratingDisplay {
    if (rating == null) return null;
    return '${rating!.toStringAsFixed(1)}/5.0 (${reviewCount ?? 0} avis)';
  }
}