import 'package:flutter/material.dart';
import 'package:medical/models/user_model.dart';
import 'package:medical/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    try {
      final user = await AuthService.getCurrentUser();
      final token = await AuthService.getToken();
      print('SplashScreen: user=${user?.id}, token=${token != null ? "present" : "absent"}');
      if (user != null && token != null && user.id.isNotEmpty) {
        if (!mounted) return;
        // Validate role
        if (!['user', 'admin', 'professional'].contains(user.role)) {
          print('Invalid role: ${user.role}, redirecting to signin');
          Navigator.pushReplacementNamed(context, '/signin');
          return;
        }
        // Redirect based on role
        switch (user.role) {
          case 'admin':
            Navigator.pushReplacementNamed(context, '/admin', arguments: user);
            break;
          case 'professional':
            Navigator.pushReplacementNamed(context, '/redirect', arguments: user);
            break;
          case 'user':
          default:
            Navigator.pushReplacementNamed(context, '/home', arguments: user);
            break;
        }
      } else {
        if (!mounted) return;
        print('No valid session, redirecting to signin');
        Navigator.pushReplacementNamed(context, '/signin');
      }
    } catch (e) {
      print('Error checking session: $e');
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icon/icon.png", height: 100), // Add your app logo
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}