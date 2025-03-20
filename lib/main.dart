import 'package:flutter/material.dart';
import 'package:medical/constants/app_colors.dart';
import 'package:medical/screens/home_screen.dart';
import 'package:medical/screens/profile_screen.dart';
import 'package:medical/screens/signin_screen.dart'; // Importation de SignInScreen
import 'package:medical/screens/signup_screen.dart'; // Importation de SignUpScreen
import 'package:medical/screens/specialist_profile_screen.dart';
import 'package:medical/screens/chat_room_screen.dart';
import 'package:medical/models/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.primary),
          titleTextStyle: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Routes nommées
      routes: {
        '/': (context) => SignInScreen(),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(), // Référence correcte à SignUpScreen
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/chatRoom': (context) => ChatRoomScreen(
              user: ModalRoute.of(context)!.settings.arguments as UserModel,
            ),
        '/specialistProfile': (context) {
          final specialist =
              ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return SpecialistProfileScreen(specialist: specialist);
        },
      },
    );
  }
}