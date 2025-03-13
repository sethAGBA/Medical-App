import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isAuthenticated = false;

  UserModel? get user => _user;
  bool get isAuthenticated => _isAuthenticated;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        final userDoc = await _firestore.collection('users').doc(user.uid).get();
        _user = UserModel.fromMap(userDoc.data()!);
        _isAuthenticated = true;
      } else {
        _user = null;
        _isAuthenticated = false;
      }
      notifyListeners();
    });
  }

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String username,
    String profileUrl,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': username,
        'profileUrl': profileUrl,
        'role': 'user',
      });
      return {'success': true, 'data': userCredential.user};
    } catch (e) {
      String msg = e.toString();
      if (msg.contains('invalid-email')) msg = 'Adresse email invalide';
      if (msg.contains('email-already-in-use')) msg = 'Cette adresse email est déjà utilisée';
      return {'success': false, 'msg': msg};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {'success': true, 'data': userCredential.user};
    } catch (e) {
      String msg = e.toString();
      if (msg.contains('user-not-found')) msg = 'Utilisateur non trouvé';
      if (msg.contains('wrong-password')) msg = 'Mot de passe incorrect';
      return {'success': false, 'msg': msg};
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}