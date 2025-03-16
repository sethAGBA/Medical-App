// class UserModel {
//   final String uid;
//   final String email;
//   final String username;
//   final String profileUrl;
//   final String role;

//   UserModel({
//     required this.uid,
//     required this.email,
//     required this.username,
//     required this.profileUrl,
//     this.role = 'user',
//   });

//   factory UserModel.fromMap(Map<String, dynamic> data) {
//     return UserModel(
//       uid: data['uid'],
//       email: data['email'],
//       username: data['username'],
//       profileUrl: data['profileUrl'],
//       role: data['role'] ?? 'user',
//     );
//   }
// }



class UserModel {
  final String userId;
  final String username;
  final String profileUrl;
  final String? lastMessage;
  final String? lastMessageTime;

  UserModel({
    required this.userId,
    required this.username,
    required this.profileUrl,
    this.lastMessage,
    this.lastMessageTime,
  });
}