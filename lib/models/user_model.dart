// // class UserModel {
// //   final String uid;
// //   final String email;
// //   final String username;
// //   final String profileUrl;
// //   final String role;

// //   UserModel({
// //     required this.uid,
// //     required this.email,
// //     required this.username,
// //     required this.profileUrl,
// //     this.role = 'user',
// //   });

// //   factory UserModel.fromMap(Map<String, dynamic> data) {
// //     return UserModel(
// //       uid: data['uid'],
// //       email: data['email'],
// //       username: data['username'],
// //       profileUrl: data['profileUrl'],
// //       role: data['role'] ?? 'user',
// //     );
// //   }
// // }



// // class UserModel {
// //   final String userId;
// //   final String username;
// //   final String profileUrl;
// //   final String? lastMessage;
// //   final String? lastMessageTime;

// //   UserModel({
// //     required this.userId,
// //     required this.username,
// //     required this.profileUrl,
// //     this.lastMessage,
// //     this.lastMessageTime,
// //   });
// // }


// // class UserModel {
// //   final String uid;
// //   final String email;
// //   final String username;
// //   final String profileUrl;
// //   final String? phoneNumber;
// //   final String role;
// //   final String? dateOfBirth;
// //   final String? gender;
// //   final String? lastMessage;
// //   final String? lastMessageTime;
// //   final bool isOnline;

// //   UserModel({
// //     required this.uid,
// //     required this.email,
// //     required this.username,
// //     required this.profileUrl,
// //     this.phoneNumber,
// //     this.role = 'user',
// //     this.dateOfBirth,
// //     this.gender,
// //     this.lastMessage,
// //     this.lastMessageTime,
// //     this.isOnline = false,
// //   });

// //   // Convertir les données du serveur en objet UserModel
// //   factory UserModel.fromMap(Map<String, dynamic> data) {
// //     return UserModel(
// //       uid: data['uid'] ?? '',
// //       email: data['email'] ?? '',
// //       username: data['username'] ?? '',
// //       profileUrl: data['profileUrl'] ?? 'https://via.placeholder.com/150',
// //       phoneNumber: data['phoneNumber'],
// //       role: data['role'] ?? 'user',
// //       dateOfBirth: data['dateOfBirth'],
// //       gender: data['gender'],
// //       lastMessage: data['lastMessage'],
// //       lastMessageTime: data['lastMessageTime'],
// //       isOnline: data['isOnline'] ?? false,
// //     );
// //   }

// //   // Convertir l'objet UserModel en Map pour l'envoyer au serveur
// //   Map<String, dynamic> toMap() {
// //     return {
// //       'uid': uid,
// //       'email': email,
// //       'username': username,
// //       'profileUrl': profileUrl,
// //       'phoneNumber': phoneNumber,
// //       'role': role,
// //       'dateOfBirth': dateOfBirth,
// //       'gender': gender,
// //       'lastMessage': lastMessage,
// //       'lastMessageTime': lastMessageTime,
// //       'isOnline': isOnline,
// //     };
// //   }

// //   // Créer une copie de l'utilisateur avec des modifications
// //   UserModel copyWith({
// //     String? uid,
// //     String? email,
// //     String? username,
// //     String? profileUrl,
// //     String? phoneNumber,
// //     String? role,
// //     String? dateOfBirth,
// //     String? gender,
// //     String? lastMessage,
// //     String? lastMessageTime,
// //     bool? isOnline,
// //   }) {
// //     return UserModel(
// //       uid: uid ?? this.uid,
// //       email: email ?? this.email,
// //       username: username ?? this.username,
// //       profileUrl: profileUrl ?? this.profileUrl,
// //       phoneNumber: phoneNumber ?? this.phoneNumber,
// //       role: role ?? this.role,
// //       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
// //       gender: gender ?? this.gender,
// //       lastMessage: lastMessage ?? this.lastMessage,
// //       lastMessageTime: lastMessageTime ?? this.lastMessageTime,
// //       isOnline: isOnline ?? this.isOnline,
// //     );
// //   }

// //   // Vérifier si l'utilisateur est un administrateur
// //   bool get isAdmin => role == 'admin';

// //   // Vérifier si l'utilisateur est un médecin
// //   bool get isDoctor => role == 'professional';

// //   // Obtenir l'âge de l'utilisateur
// //   int? get age {
// //     if (dateOfBirth == null) return null;
// //     final birthDate = DateTime.tryParse(dateOfBirth!);
// //     if (birthDate == null) return null;
    
// //     final today = DateTime.now();
// //     var age = today.year - birthDate.year;
// //     if (today.month < birthDate.month || 
// //         (today.month == birthDate.month && today.day < birthDate.day)) {
// //       age--;
// //     }
// //     return age;
// //   }
// // }


// class UserModel {
//   final String uid;
//   final String email;
//   final String username;
//   final String profileUrl;
//   final String? phoneNumber;
//   final String role;
//   final String? dateOfBirth;
//   final String? gender;
//   final String? lastMessage;
//   final String? lastMessageTime;
//   final bool isOnline;
//   final String? speciality; // Pour les professionnels de santé
//   final String? license;    // Numéro de licence pour les professionnels
//   final List<String>? certificates; // Certifications professionnelles
//   final double? rating;    // Note moyenne des avis
//   final int? reviewCount; // Nombre d'avis

//   UserModel({
//     required this.uid,
//     required this.email,
//     required this.username,
//     required this.profileUrl,
//     this.phoneNumber,
//     this.role = 'user',
//     this.dateOfBirth,
//     this.gender,
//     this.lastMessage,
//     this.lastMessageTime,
//     this.isOnline = false,
//     this.speciality,
//     this.license,
//     this.certificates,
//     this.rating,
//     this.reviewCount,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       uid: data['uid'] ?? '',
//       email: data['email'] ?? '',
//       username: data['username'] ?? '',
//       profileUrl: data['profileUrl'] ?? 'https://via.placeholder.com/150',
//       phoneNumber: data['phoneNumber'],
//       role: data['role'] ?? 'user',
//       dateOfBirth: data['dateOfBirth'],
//       gender: data['gender'],
//       lastMessage: data['lastMessage'],
//       lastMessageTime: data['lastMessageTime'],
//       isOnline: data['isOnline'] ?? false,
//       speciality: data['speciality'],
//       license: data['license'],
//       certificates: data['certificates'] != null 
//           ? List<String>.from(data['certificates'])
//           : null,
//       rating: data['rating']?.toDouble(),
//       reviewCount: data['reviewCount'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'uid': uid,
//       'email': email,
//       'username': username,
//       'profileUrl': profileUrl,
//       'phoneNumber': phoneNumber,
//       'role': role,
//       'dateOfBirth': dateOfBirth,
//       'gender': gender,
//       'lastMessage': lastMessage,
//       'lastMessageTime': lastMessageTime,
//       'isOnline': isOnline,
//       'speciality': speciality,
//       'license': license,
//       'certificates': certificates,
//       'rating': rating,
//       'reviewCount': reviewCount,
//     };
//   }

//   UserModel copyWith({
//     String? uid,
//     String? email,
//     String? username,
//     String? profileUrl,
//     String? phoneNumber,
//     String? role,
//     String? dateOfBirth,
//     String? gender,
//     String? lastMessage,
//     String? lastMessageTime,
//     bool? isOnline,
//     String? speciality,
//     String? license,
//     List<String>? certificates,
//     double? rating,
//     int? reviewCount,
//   }) {
//     return UserModel(
//       uid: uid ?? this.uid,
//       email: email ?? this.email,
//       username: username ?? this.username,
//       profileUrl: profileUrl ?? this.profileUrl,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       role: role ?? this.role,
//       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//       gender: gender ?? this.gender,
//       lastMessage: lastMessage ?? this.lastMessage,
//       lastMessageTime: lastMessageTime ?? this.lastMessageTime,
//       isOnline: isOnline ?? this.isOnline,
//       speciality: speciality ?? this.speciality,
//       license: license ?? this.license,
//       certificates: certificates ?? this.certificates,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//     );
//   }

//   // Vérification des rôles
//   bool get isAdmin => role == 'admin';
//   bool get isDoctor => role == 'doctor';
//   bool get isPharmacist => role == 'pharmacist';
//   bool get isUser => role == 'user';
//   bool get isProfessional => role == 'doctor' || role == 'pharmacist';

//   // Getters utiles
//   String get roleDisplay {
//     switch (role) {
//       case 'admin':
//         return 'Administrateur';
//       case 'professionnell':
//         return 'Médecin';
//       case 'pharmacist':
//         return 'Pharmacien';
//       default:
//         return 'Utilisateur';
//     }
//   }

//   String get fullTitle {
//     if (isDoctor) {
//       return 'Dr. $username${speciality != null ? ' - $speciality' : ''}';
//     }
//     return username;
//   }

//   String? get ratingDisplay {
//     if (rating == null) return null;
//     return '${rating!.toStringAsFixed(1)}/5.0 (${reviewCount ?? 0} avis)';
//   }

//   // Obtenir l'âge de l'utilisateur
//   int? get age {
//     if (dateOfBirth == null) return null;
//     final birthDate = DateTime.tryParse(dateOfBirth!);
//     if (birthDate == null) return null;
    
//     final today = DateTime.now();
//     var age = today.year - birthDate.year;
//     if (today.month < birthDate.month || 
//         (today.month == birthDate.month && today.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
// }


// class UserModel {
//   final String id;
//   final String email;
//   final String fullName;
//   final String profilePhoto;
//   final String? phoneNumber;
//   final String role;
//   final String? dateOfBirth;
//   final String? gender;
//   final String? lastMessage;
//   final String? lastMessageTime;
//   final bool isOnline;
//   final String? speciality;
//   final String? license;
//   final List<String>? certificates;
//   final double? rating;
//   final int? reviewCount;

//   UserModel({
//     required this.id,
//     required this.email,
//     required this.fullName,
//     required this.profilePhoto,
//     this.phoneNumber,
//     this.role = 'user',
//     this.dateOfBirth,
//     this.gender,
//     this.lastMessage,
//     this.lastMessageTime,
//     this.isOnline = false,
//     this.speciality,
//     this.license,
//     this.certificates,
//     this.rating,
//     this.reviewCount,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       id: data['id'] ?? '',
//       email: data['email'] ?? '',
//       fullName: data['fullName'] ?? '',
//       profilePhoto: data['profilePhoto'] ?? 'https://via.placeholder.com/150',
//       phoneNumber: data['phoneNumber'],
//       role: data['role'] ?? 'user',
//       dateOfBirth: data['dateOfBirth'] != null
//           ? data['dateOfBirth'].split('T')[0]
//           : null,
//       gender: data['gender'],
//       lastMessage: data['lastMessage'],
//       lastMessageTime: data['lastMessageTime'],
//       isOnline: data['isOnline'] ?? false,
//       speciality: data['speciality'],
//       license: data['license'],
//       certificates: data['certificates'] != null
//           ? List<String>.from(data['certificates'])
//           : null,
//       rating: data['rating']?.toDouble(),
//       reviewCount: data['reviewCount'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'fullName': fullName,
//       'profilePhoto': profilePhoto,
//       'phoneNumber': phoneNumber,
//       'role': role,
//       'dateOfBirth': dateOfBirth,
//       'gender': gender,
//       'lastMessage': lastMessage,
//       'lastMessageTime': lastMessageTime,
//       'isOnline': isOnline,
//       'speciality': speciality,
//       'license': license,
//       'certificates': certificates,
//       'rating': rating,
//       'reviewCount': reviewCount,
//     };
//   }

//   UserModel copyWith({
//     String? id,
//     String? email,
//     String? fullName,
//     String? profilePhoto,
//     String? phoneNumber,
//     String? role,
//     String? dateOfBirth,
//     String? gender,
//     String? lastMessage,
//     String? lastMessageTime,
//     bool? isOnline,
//     String? speciality,
//     String? license,
//     List<String>? certificates,
//     double? rating,
//     int? reviewCount,
//   }) {
//     return UserModel(
//       id: id ?? this.id,
//       email: email ?? this.email,
//       fullName: fullName ?? this.fullName,
//       profilePhoto: profilePhoto ?? this.profilePhoto,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       role: role ?? this.role,
//       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//       gender: gender ?? this.gender,
//       lastMessage: lastMessage ?? this.lastMessage,
//       lastMessageTime: lastMessageTime ?? this.lastMessageTime,
//       isOnline: isOnline ?? this.isOnline,
//       speciality: speciality ?? this.speciality,
//       license: license ?? this.license,
//       certificates: certificates ?? this.certificates,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//     );
//   }

//   bool get isAdmin => role == 'admin';
//   bool get isProfessional => role == 'professional';
//   bool get isUser => role == 'user';

//   String get roleDisplay {
//     switch (role) {
//       case 'admin':
//         return 'Administrateur';
//       case 'professional':
//         return 'Professionnel';
//       default:
//         return 'Utilisateur';
//     }
//   }

//   String get fullTitle {
//     if (isProfessional) {
//       return 'Dr. $fullName${speciality != null ? ' - $speciality' : ''}';
//     }
//     return fullName;
//   }

//   String? get ratingDisplay {
//     if (rating == null) return null;
//     return '${rating!.toStringAsFixed(1)}/5.0 (${reviewCount ?? 0} avis)';
//   }

//   int? get age {
//     if (dateOfBirth == null) return null;
//     final birthDate = DateTime.tryParse(dateOfBirth!);
//     if (birthDate == null) return null;
//     final today = DateTime.now();
//     var age = today.year - birthDate.year;
//     if (today.month < birthDate.month ||
//         (today.month == birthDate.month && today.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
// }




// // lib/models/user_model.dart
// class UserModel {
//   final String id;
//   final String email;
//   final String fullName;
//   final String profilePhoto;
//   final String? phoneNumber;
//   final String role;
//   final String? dateOfBirth;
//   final String? gender;
//   final String? lastMessage;
//   final String? lastMessageTime;
//   final bool isOnline;
//   final String? speciality;
//   final String? license;
//   final List<String>? certificates;
//   final double? rating;
//   final int? reviewCount;

//   UserModel({
//     required this.id,
//     required this.email,
//     required this.fullName,
//     required this.profilePhoto,
//     this.phoneNumber,
//     this.role = 'user',
//     this.dateOfBirth,
//     this.gender,
//     this.lastMessage,
//     this.lastMessageTime,
//     this.isOnline = false,
//     this.speciality,
//     this.license,
//     this.certificates,
//     this.rating,
//     this.reviewCount,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       id: data['id'] ?? data['_id'] ?? '',
//       email: data['email'] ?? '',
//       fullName: data['fullName'] ?? '',
//       profilePhoto: data['profilePhoto'] ?? 'https://via.placeholder.com/150',
//       phoneNumber: data['phoneNumber'],
//       role: data['role'] ?? 'user',
//       dateOfBirth: data['dateOfBirth'] != null
//           ? data['dateOfBirth'].split('T')[0]
//           : null,
//       gender: data['gender'],
//       lastMessage: data['lastMessage'],
//       lastMessageTime: data['lastMessageTime'],
//       isOnline: data['isOnline'] ?? false,
//       speciality: data['speciality'],
//       license: data['license'],
//       certificates: data['certificates'] != null
//           ? List<String>.from(data['certificates'])
//           : null,
//       rating: data['rating']?.toDouble(),
//       reviewCount: data['reviewCount'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'fullName': fullName,
//       'profilePhoto': profilePhoto,
//       'phoneNumber': phoneNumber,
//       'role': role,
//       'dateOfBirth': dateOfBirth,
//       'gender': gender,
//       'lastMessage': lastMessage,
//       'lastMessageTime': lastMessageTime,
//       'isOnline': isOnline,
//       'speciality': speciality,
//       'license': license,
//       'certificates': certificates,
//       'rating': rating,
//       'reviewCount': reviewCount,
//     };
//   }

//   UserModel copyWith({
//     String? id,
//     String? email,
//     String? fullName,
//     String? profilePhoto,
//     String? phoneNumber,
//     String? role,
//     String? dateOfBirth,
//     String? gender,
//     String? lastMessage,
//     String? lastMessageTime,
//     bool? isOnline,
//     String? speciality,
//     String? license,
//     List<String>? certificates,
//     double? rating,
//     int? reviewCount,
//   }) {
//     return UserModel(
//       id: id ?? this.id,
//       email: email ?? this.email,
//       fullName: fullName ?? this.fullName,
//       profilePhoto: profilePhoto ?? this.profilePhoto,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       role: role ?? this.role,
//       dateOfBirth: dateOfBirth ?? this.dateOfBirth,
//       gender: gender ?? this.gender,
//       lastMessage: lastMessage ?? this.lastMessage,
//       lastMessageTime: lastMessageTime ?? this.lastMessageTime,
//       isOnline: isOnline ?? this.isOnline,
//       speciality: speciality ?? this.speciality,
//       license: license ?? this.license,
//       certificates: certificates ?? this.certificates,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//     );
//   }

//   bool get isAdmin => role == 'admin';
//   bool get isProfessional => role == 'professional';
//   bool get isUser => role == 'user';

//   String get roleDisplay {
//     switch (role) {
//       case 'admin':
//         return 'Administrateur';
//       case 'professional':
//         return 'Professionnel';
//       default:
//         return 'Utilisateur';
//     }
//   }

//   String get fullTitle {
//     if (isProfessional) {
//       return 'Dr. $fullName${speciality != null ? ' - $speciality' : ''}';
//     }
//     return fullName;
//   }

//   String? get ratingDisplay {
//     if (rating == null) return null;
//     return '${rating!.toStringAsFixed(1)}/5.0 (${reviewCount ?? 0} avis)';
//   }

//   int? get age {
//     if (dateOfBirth == null) return null;
//     final birthDate = DateTime.tryParse(dateOfBirth!);
//     if (birthDate == null) return null;
//     final today = DateTime.now();
//     var age = today.year - birthDate.year;
//     if (today.month < birthDate.month ||
//         (today.month == birthDate.month && today.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
// }




// // lib/models/user_model.dart
// class UserModel {
//   final String id;
//   final String email;
//   final String fullName;
//   final String profilePhoto;
//   final String? phoneNumber;
//   final String role;
//   final String? dateOfBirth;
//   final String? gender;
//   final String? address;
//   final String? bloodType;
//   final String? allergies;
//   final String? emergencyContact;
//   final String? lastMessage;
//   final String? lastMessageTime;
//   final bool isOnline;
//   final String? speciality;
//   final String? license;
//   final List<String>? certificates;
//   final double? rating;
//   final int? reviewCount;

//   UserModel({
//     required this.id,
//     required this.email,
//     required this.fullName,
//     required this.profilePhoto,
//     this.phoneNumber,
//     this.role = 'user',
//     this.dateOfBirth,
//     this.gender,
//     this.address,
//     this.bloodType,
//     this.allergies,
//     this.emergencyContact,
//     this.lastMessage,
//     this.lastMessageTime,
//     this.isOnline = false,
//     this.speciality,
//     this.license,
//     this.certificates,
//     this.rating,
//     this.reviewCount,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       id: data['id'] ?? data['_id'] ?? '',
//       email: data['email'] ?? '',
//       fullName: data['fullName'] ?? '',
//       profilePhoto: data['profilePhoto'] ?? 'https://via.placeholder.com/150',
//       phoneNumber: data['phoneNumber'],
//       role: data['role'] ?? 'user',
//       dateOfBirth: data['dateOfBirth'] != null
//           ? data['dateOfBirth'].split('T')[0]
//           : null,
//       gender: data['gender'],
//       address: data['address'],
//       bloodType: data['bloodType'],
//       allergies: data['allergies'],
//       emergencyContact: data['emergencyContact'],
//       lastMessage: data['lastMessage'],
//       lastMessageTime: data['lastMessageTime'],
//       isOnline: data['isOnline'] ?? false,
//       speciality: data['speciality'],
//       license: data['license'],
//       certificates: data['certificates'] != null
//           ? List<String>.from(data['certificates'])
//           : null,
//       rating: data['rating']?.toDouble(),
//       reviewCount: data['reviewCount'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'fullName': fullName,
//       'profilePhoto': profilePhoto,
//       'phoneNumber': phoneNumber,
//       'role': role,
//       'dateOfBirth': dateOfBirth,
//       'gender': gender,
//       'address': address,
//       'bloodType': bloodType,
//       'allergies': allergies,
//       'emergencyContact': emergencyContact,
//       'lastMessage': lastMessage,
//       'lastMessageTime': lastMessageTime,
//       'isOnline': isOnline,
//       'speciality': speciality,
//       'license': license,
//       'certificates': certificates,
//       'rating': rating,
//       'reviewCount': reviewCount,
//     };
//   }

//   UserModel copyWith({
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
//     String? speciality,
//     String? license,
//     List<String>? certificates,
//     double? rating,
//     int? reviewCount,
//   }) {
//     return UserModel(
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
//       speciality: speciality ?? this.speciality,
//       license: license ?? this.license,
//       certificates: certificates ?? this.certificates,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//     );
//   }

//   bool get isAdmin => role == 'admin';
//   bool get isProfessional => role == 'professional';
//   bool get isUser => role == 'user';

//   String get roleDisplay {
//     switch (role) {
//       case 'admin':
//         return 'Administrateur';
//       case 'professional':
//         return 'Professionnel';
//       default:
//         return 'Utilisateur';
//     }
//   }

//   String get fullTitle {
//     if (isProfessional) {
//       return 'Dr. $fullName${speciality != null ? ' - $speciality' : ''}';
//     }
//     return fullName;
//   }

//   String? get ratingDisplay {
//     if (rating == null) return null;
//     return '${rating!.toStringAsFixed(1)}/5.0 (${reviewCount ?? 0} avis)';
//   }

//   int? get age {
//     if (dateOfBirth == null) return null;
//     final birthDate = DateTime.tryParse(dateOfBirth!);
//     if (birthDate == null) return null;
//     final today = DateTime.now();
//     var age = today.year - birthDate.year;
//     if (today.month < birthDate.month ||
//         (today.month == birthDate.month && today.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
// }


// // lib/models/user_model.dart
// import 'dart:convert';

// class UserModel {
//   final String id;
//   final String email;
//   final String fullName;
//   final String profilePhoto;
//   final String? phoneNumber;
//   final String role;
//   final String? dateOfBirth;
//   final String? gender;
//   final String? address;
//   final String? bloodType;
//   final String? allergies;
//   final String? emergencyContact;
//   final String? lastMessage;
//   final String? lastMessageTime;
//   final bool isOnline;
//   final String? speciality;
//   final String? license;
//   final List<String>? certificates;
//   final double? rating;
//   final int? reviewCount;

//   UserModel({
//     required this.id,
//     required this.email,
//     required this.fullName,
//     required this.profilePhoto,
//     this.phoneNumber,
//     this.role = 'user',
//     this.dateOfBirth,
//     this.gender,
//     this.address,
//     this.bloodType,
//     this.allergies,
//     this.emergencyContact,
//     this.lastMessage,
//     this.lastMessageTime,
//     this.isOnline = false,
//     this.speciality,
//     this.license,
//     this.certificates,
//     this.rating,
//     this.reviewCount,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       id: data['id'] ?? data['_id'] ?? '',
//       email: data['email'] ?? '',
//       fullName: data['fullName'] ?? '',
//       profilePhoto: data['profilePhoto'] ?? 'https://via.placeholder.com/150',
//       phoneNumber: data['phoneNumber'],
//       role: data['role'] ?? 'user',
//       dateOfBirth: data['dateOfBirth'] != null
//           ? data['dateOfBirth'].split('T')[0]
//           : null,
//       gender: data['gender'],
//       address: data['address'],
//       bloodType: data['bloodType'],
//       allergies: data['allergies'],
//       emergencyContact: data['emergencyContact'],
//       lastMessage: data['lastMessage'],
//       lastMessageTime: data['lastMessageTime'],
//       isOnline: data['isOnline'] ?? false,
//       speciality: data['speciality'],
//       license: data['license'],
//       certificates: data['certificates'] != null
//           ? List<String>.from(data['certificates'])
//           : null,
//       rating: data['rating']?.toDouble(),
//       reviewCount: data['reviewCount'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'fullName': fullName,
//       'profilePhoto': profilePhoto,
//       'phoneNumber': phoneNumber,
//       'role': role,
//       'dateOfBirth': dateOfBirth,
//       'gender': gender,
//       'address': address,
//       'bloodType': bloodType,
//       'allergies': allergies,
//       'emergencyContact': emergencyContact,
//       'lastMessage': lastMessage,
//       'lastMessageTime': lastMessageTime,
//       'isOnline': isOnline,
//       'speciality': speciality,
//       'license': license,
//       'certificates': certificates,
//       'rating': rating,
//       'reviewCount': reviewCount,
//     };
//   }

//   String toJsonString() => json.encode(toJson());

//   factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

//   UserModel copyWith({
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
//     String? speciality,
//     String? license,
//     List<String>? certificates,
//     double? rating,
//     int? reviewCount,
//   }) {
//     return UserModel(
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
//       speciality: speciality ?? this.speciality,
//       license: license ?? this.license,
//       certificates: certificates ?? this.certificates,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//     );
//   }

//   bool get isAdmin => role == 'admin';
//   bool get isProfessional => role == 'professional';
//   bool get isUser => role == 'user';

//   String get roleDisplay {
//     switch (role) {
//       case 'admin':
//         return 'Administrateur';
//       case 'professional':
//         return 'Professionnel';
//       default:
//         return 'Utilisateur';
//     }
//   }

//   String get fullTitle {
//     if (isProfessional) {
//       return 'Dr. $fullName${speciality != null ? ' - $speciality' : ''}';
//     }
//     return fullName;
//   }

//   String? get ratingDisplay {
//     if (rating == null) return null;
//     return '${rating!.toStringAsFixed(1)}/5.0 (${reviewCount ?? 0} avis)';
//   }

//   int? get age {
//     if (dateOfBirth == null) return null;
//     final birthDate = DateTime.tryParse(dateOfBirth!);
//     if (birthDate == null) return null;
//     final today = DateTime.now();
//     var age = today.year - birthDate.year;
//     if (today.month < birthDate.month ||
//         (today.month == birthDate.month && today.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
// }





// import 'dart:convert';

// class UserModel {
//   final String id;
//   final String email;
//   final String fullName;
//   final String profilePhoto;
//   final String? phoneNumber;
//   final String role;
//   final String? dateOfBirth;
//   final String? gender;
//   final String? address;
//   final String? bloodType;
//   final String? allergies;
//   final String? emergencyContact;
//   final String? lastMessage;
//   final String? lastMessageTime;
//   final bool isOnline;
//   final String? speciality;
//   final String? license;
//   final List<String>? certificates;
//   final double? rating;
//   final int? reviewCount;

//   UserModel({
//     required this.id,
//     required this.email,
//     required this.fullName,
//     required this.profilePhoto,
//     this.phoneNumber,
//     this.role = 'user',
//     this.dateOfBirth,
//     this.gender,
//     this.address,
//     this.bloodType,
//     this.allergies,
//     this.emergencyContact,
//     this.lastMessage,
//     this.lastMessageTime,
//     this.isOnline = false,
//     this.speciality,
//     this.license,
//     this.certificates,
//     this.rating,
//     this.reviewCount,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       id: data['id']?.toString() ?? data['_id']?.toString() ?? '',
//       email: data['email']?.toString() ?? '',
//       fullName: data['fullName']?.toString() ?? '',
//       profilePhoto: data['profilePhoto']?.toString() ?? 'https://via.placeholder.com/150',
//       phoneNumber: data['phoneNumber']?.toString(),
//       role: data['role']?.toString() ?? 'user',
//       dateOfBirth: data['dateOfBirth']?.toString().split('T')[0],
//       gender: data['gender']?.toString(),
//       address: data['address']?.toString(),
//       bloodType: data['bloodType']?.toString(),
//       allergies: data['allergies']?.toString(),
//       emergencyContact: data['emergencyContact']?.toString(),
//       lastMessage: data['lastMessage']?.toString(),
//       lastMessageTime: data['lastMessageTime']?.toString(),
//       isOnline: data['isOnline'] == true,
//       speciality: data['speciality']?.toString(),
//       license: data['license']?.toString(),
//       certificates: data['certificates'] != null
//           ? List<String>.from(data['certificates'].map((x) => x.toString()))
//           : null,
//       rating: data['rating'] != null ? double.tryParse(data['rating'].toString()) : null,
//       reviewCount: data['reviewCount'] != null ? int.tryParse(data['reviewCount'].toString()) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'fullName': fullName,
//       'profilePhoto': profilePhoto,
//       'phoneNumber': phoneNumber,
//       'role': role,
//       'dateOfBirth': dateOfBirth,
//       'gender': gender,
//       'address': address,
//       'bloodType': bloodType,
//       'allergies': allergies,
//       'emergencyContact': emergencyContact,
//       'lastMessage': lastMessage,
//       'lastMessageTime': lastMessageTime,
//       'isOnline': isOnline,
//       'speciality': speciality,
//       'license': license,
//       'certificates': certificates,
//       'rating': rating,
//       'reviewCount': reviewCount,
//     };
//   }

//   String toJsonString() => json.encode(toJson());

//   factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

//   UserModel copyWith({
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
//     String? speciality,
//     String? license,
//     List<String>? certificates,
//     double? rating,
//     int? reviewCount,
//   }) {
//     return UserModel(
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
//       speciality: speciality ?? this.speciality,
//       license: license ?? this.license,
//       certificates: certificates ?? this.certificates,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//     );
//   }

//   bool get isAdmin => role == 'admin';
//   bool get isProfessional => role == 'professional';
//   bool get isUser => role == 'user';

//   String get roleDisplay {
//     switch (role) {
//       case 'admin':
//         return 'Administrateur';
//       case 'professional':
//         return 'Professionnel';
//       default:
//         return 'Utilisateur';
//     }
//   }

//   String get fullTitle {
//     if (isProfessional) {
//       return 'Dr. $fullName${speciality != null ? ' - $speciality' : ''}';
//     }
//     return fullName;
//   }

//   String? get ratingDisplay {
//     if (rating == null) return null;
//     return '${rating!.toStringAsFixed(1)}/5.0 (${reviewCount ?? 0} avis)';
//   }

//   int? get age {
//     if (dateOfBirth == null) return null;
//     final birthDate = DateTime.tryParse(dateOfBirth!);
//     if (birthDate == null) return null;
//     final today = DateTime.now();
//     var age = today.year - birthDate.year;
//     if (today.month < birthDate.month ||
//         (today.month == birthDate.month && today.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
// }




// import 'dart:convert';

// class UserModel {
//   final String id;
//   final String? email;
//   final String fullName;
//   final String profilePhoto;
//   final String? phoneNumber;
//   final String role;
//   final String? dateOfBirth;
//   final String? gender;
//   final String? address;
//   final String? bloodType;
//   final String? allergies;
//   final String? emergencyContact;
//   final String? lastMessage;
//   final String? lastMessageTime;
//   final bool isOnline;
//   final String? speciality;
//   final String? license;
//   final List<String>? certificates;
//   final double? rating;
//   final int? reviewCount;

//   UserModel({
//     required this.id,
//     this.email,
//     required this.fullName,
//     required this.profilePhoto,
//     this.phoneNumber,
//     this.role = 'user',
//     this.dateOfBirth,
//     this.gender,
//     this.address,
//     this.bloodType,
//     this.allergies,
//     this.emergencyContact,
//     this.lastMessage,
//     this.lastMessageTime,
//     this.isOnline = false,
//     this.speciality,
//     this.license,
//     this.certificates,
//     this.rating,
//     this.reviewCount,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       id: data['id']?.toString() ?? data['_id']?.toString() ?? '',
//       email: data['email']?.toString(),
//       fullName: data['fullName']?.toString() ?? '',
//       profilePhoto: data['profilePhoto']?.toString() ?? 'https://via.placeholder.com/150',
//       phoneNumber: data['phoneNumber']?.toString(),
//       role: data['role']?.toString() ?? 'user',
//       dateOfBirth: data['dateOfBirth']?.toString()?.split('T')[0],
//       gender: data['gender']?.toString(),
//       address: data['address']?.toString(),
//       bloodType: data['bloodType']?.toString(),
//       allergies: data['allergies']?.toString(),
//       emergencyContact: data['emergencyContact']?.toString(),
//       lastMessage: data['lastMessage']?.toString(),
//       lastMessageTime: data['lastMessageTime']?.toString(),
//       isOnline: data['isOnline'] == true,
//       speciality: data['speciality']?.toString(),
//       license: data['license']?.toString(),
//       certificates: data['certificates'] != null
//           ? List<String>.from(data['certificates'].map((x) => x.toString()))
//           : null,
//       rating: data['rating'] != null ? double.tryParse(data['rating'].toString()) : null,
//       reviewCount: data['reviewCount'] != null ? int.tryParse(data['reviewCount'].toString()) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'fullName': fullName,
//       'profilePhoto': profilePhoto,
//       'phoneNumber': phoneNumber,
//       'role': role,
//       'dateOfBirth': dateOfBirth,
//       'gender': gender,
//       'address': address,
//       'bloodType': bloodType,
//       'allergies': allergies,
//       'emergencyContact': emergencyContact,
//       'lastMessage': lastMessage,
//       'lastMessageTime': lastMessageTime,
//       'isOnline': isOnline,
//       'speciality': speciality,
//       'license': license,
//       'certificates': certificates,
//       'rating': rating,
//       'reviewCount': reviewCount,
//     };
//   }

//   String toJsonString() => json.encode(toJson());

//   factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

//   UserModel copyWith({
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
//     String? speciality,
//     String? license,
//     List<String>? certificates,
//     double? rating,
//     int? reviewCount,
//   }) {
//     return UserModel(
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
//       speciality: speciality ?? this.speciality,
//       license: license ?? this.license,
//       certificates: certificates ?? this.certificates,
//       rating: rating ?? this.rating,
//       reviewCount: reviewCount ?? this.reviewCount,
//     );
//   }

//   bool get isAdmin => role == 'admin';
//   bool get isProfessional => role == 'professional';
//   bool get isUser => role == 'user';

//   String get roleDisplay {
//     switch (role) {
//       case 'admin':
//         return 'Administrateur';
//       case 'professional':
//         return 'Professionnel';
//       default:
//         return 'Utilisateur';
//     }
//   }

//   String get fullTitle {
//     if (isProfessional) {
//       return 'Dr. $fullName${speciality != null ? ' - $speciality' : ''}';
//     }
//     return fullName;
//   }

//   String? get ratingDisplay {
//     if (rating == null) return null;
//     return '${rating!.toStringAsFixed(1)}/5.0 (${reviewCount ?? 0} avis)';
//   }

//   int? get age {
//     if (dateOfBirth == null) return null;
//     final birthDate = DateTime.tryParse(dateOfBirth!);
//     if (birthDate == null) return null;
//     final today = DateTime.now();
//     var age = today.year - birthDate.year;
//     if (today.month < birthDate.month ||
//         (today.month == birthDate.month && today.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
// }



// import 'dart:convert';

// class UserModel {
//   final String id;
//   final String? email;
//   final String fullName;
//   final String profilePhoto;
//   final String? phoneNumber;
//   final String role;
//   final String? dateOfBirth;
//   final String? gender;
//   final String? address;
//   final String? bloodType;
//   final String? allergies;
//   final String? emergencyContact;
//   final String? lastMessage;
//   final String? lastMessageTime;
//   final bool isOnline;
//   final String? specialty;
//   final String? license;
//   final List<String>? certificates;
//   final double? rating;
//   final int? reviewCount;
//   final String? about;
//   final String? location;
//   final Map<String, Map<int, List<Map<String, int>>>>? availabilities;
//   final Map<String, String>? consultationPrices;

//   UserModel({
//     required this.id,
//     this.email,
//     required this.fullName,
//     required this.profilePhoto,
//     this.phoneNumber,
//     this.role = 'user',
//     this.dateOfBirth,
//     this.gender,
//     this.address,
//     this.bloodType,
//     this.allergies,
//     this.emergencyContact,
//     this.lastMessage,
//     this.lastMessageTime,
//     this.isOnline = false,
//     this.specialty,
//     this.license,
//     this.certificates,
//     this.rating,
//     this.reviewCount,
//     this.about,
//     this.location,
//     this.availabilities,
//     this.consultationPrices,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       id: data['id']?.toString() ?? data['_id']?.toString() ?? '',
//       email: data['email']?.toString(),
//       fullName: data['fullName']?.toString() ?? '',
//       profilePhoto: data['profilePhoto']?.toString() ?? 'https://via.placeholder.com/150',
//       phoneNumber: data['phoneNumber']?.toString(),
//       role: data['role']?.toString() ?? 'user',
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
//           ? Map<String, String>.from(data['consultationPrices'])
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'fullName': fullName,
//       'profilePhoto': profilePhoto,
//       'phoneNumber': phoneNumber,
//       'role': role,
//       'dateOfBirth': dateOfBirth,
//       'gender': gender,
//       'address': address,
//       'bloodType': bloodType,
//       'allergies': allergies,
//       'emergencyContact': emergencyContact,
//       'lastMessage': lastMessage,
//       'lastMessageTime': lastMessageTime,
//       'isOnline': isOnline,
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

//   factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

//   UserModel copyWith({
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
//     Map<String, String>? consultationPrices,
//   }) {
//     return UserModel(
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

//   bool get isAdmin => role == 'admin';
//   bool get isProfessional => role == 'professional';
//   bool get isUser => role == 'user';

//   String get roleDisplay {
//     switch (role) {
//       case 'admin':
//         return 'Administrateur';
//       case 'professional':
//         return 'Professionnel';
//       default:
//         return 'Utilisateur';
//     }
//   }

//   String get fullTitle {
//     if (isProfessional) {
//       return 'Dr. $fullName${specialty != null ? ' - $specialty' : ''}';
//     }
//     return fullName;
//   }

//   String? get ratingDisplay {
//     if (rating == null) return null;
//     return '${rating!.toStringAsFixed(1)}/5.0 (${reviewCount ?? 0} avis)';
//   }

//   int? get age {
//     if (dateOfBirth == null) return null;
//     final birthDate = DateTime.tryParse(dateOfBirth!);
//     if (birthDate == null) return null;
//     final today = DateTime.now();
//     var age = today.year - birthDate.year;
//     if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
//       age--;
//     }
//     return age;
//   }
// }





import 'dart:convert';

class UserModel {
  final String id;
  final String? email;
  final String fullName;
  final String profilePhoto;
  final String? phoneNumber;
  final String role;
  final String? dateOfBirth;
  final String? gender;
  final String? address;
  final String? bloodType;
  final String? allergies;
  final String? emergencyContact;
  final String? lastMessage;
  final String? lastMessageTime;
  final bool isOnline;

  UserModel({
    required this.id,
    this.email,
    required this.fullName,
    required this.profilePhoto,
    this.phoneNumber,
    this.role = 'user',
    this.dateOfBirth,
    this.gender,
    this.address,
    this.bloodType,
    this.allergies,
    this.emergencyContact,
    this.lastMessage,
    this.lastMessageTime,
    this.isOnline = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id']?.toString() ?? data['_id']?.toString() ?? '',
      email: data['email']?.toString(),
      fullName: data['fullName']?.toString() ?? '',
      profilePhoto: data['profilePhoto']?.toString() ?? 'https://via.placeholder.com/150',
      phoneNumber: data['phoneNumber']?.toString(),
      role: data['role']?.toString() ?? 'user',
      dateOfBirth: data['dateOfBirth']?.toString()?.split('T')[0],
      gender: data['gender']?.toString(),
      address: data['address']?.toString(),
      bloodType: data['bloodType']?.toString(),
      allergies: data['allergies']?.toString(),
      emergencyContact: data['emergencyContact']?.toString(),
      lastMessage: data['lastMessage']?.toString(),
      lastMessageTime: data['lastMessageTime']?.toString(),
      isOnline: data['isOnline'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullName': fullName,
      'profilePhoto': profilePhoto,
      'phoneNumber': phoneNumber,
      'role': role,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'address': address,
      'bloodType': bloodType,
      'allergies': allergies,
      'emergencyContact': emergencyContact,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'isOnline': isOnline,
    };
  }

  String toJsonString() => json.encode(toJson());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  UserModel copyWith({
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
  }) {
    return UserModel(
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
    );
  }

  bool get isAdmin => role == 'admin';
  bool get isUser => role == 'user';

  String get roleDisplay {
    switch (role) {
      case 'admin':
        return 'Administrateur';
      default:
        return 'Utilisateur';
    }
  }

  String get fullTitle => fullName;

  int? get age {
    if (dateOfBirth == null) return null;
    final birthDate = DateTime.tryParse(dateOfBirth!);
    if (birthDate == null) return null;
    final today = DateTime.now();
    var age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}