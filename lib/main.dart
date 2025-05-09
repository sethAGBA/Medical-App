// // import 'package:flutter/material.dart';
// // import 'package:medical/constants/app_colors.dart';
// // import 'package:medical/screens/home_screen.dart';
// // import 'package:medical/screens/profile_screen.dart';
// // import 'package:medical/screens/signin_screen.dart'; // Importation de SignInScreen
// // import 'package:medical/screens/signup_screen.dart'; // Importation de SignUpScreen
// // import 'package:medical/screens/specialist_profile_screen.dart';
// // import 'package:medical/screens/chat_room_screen.dart';
// // import 'package:medical/models/user_model.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Medical',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primaryColor: Colors.white,
// //         scaffoldBackgroundColor: Colors.white,
// //         appBarTheme: const AppBarTheme(
// //           backgroundColor: Colors.white,
// //           elevation: 0,
// //           iconTheme: IconThemeData(color: AppColors.primary),
// //           titleTextStyle: TextStyle(
// //             color: AppColors.primary,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //       // Routes nommées
// //       routes: {
// //         '/': (context) => SignInScreen(),
// //         '/signin': (context) => SignInScreen(),
// //         '/signup': (context) => SignUpScreen(), // Référence correcte à SignUpScreen
// //         '/home': (context) => HomeScreen(),
// //         '/profile': (context) => ProfileScreen(),
// //         '/chatRoom': (context) => ChatRoomScreen(
// //               user: ModalRoute.of(context)!.settings.arguments as UserModel,
// //             ),
// //         '/specialistProfile': (context) {
// //           final specialist =
// //               ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
// //           return SpecialistProfileScreen(specialist: specialist);
// //         },
// //       },
// //     );
// //   }
// // }




// // import 'package:flutter/material.dart';
// // import 'package:medical/constants/app_colors.dart';
// // import 'package:medical/screens/home_screen.dart';
// // import 'package:medical/screens/profile_screen.dart';
// // import 'package:medical/screens/signin_screen.dart';
// // import 'package:medical/screens/signup_screen.dart';
// // import 'package:medical/screens/specialist_profile_screen.dart';
// // import 'package:medical/screens/chat_room_screen.dart';
// // import 'package:medical/screens/admin/admin_screen.dart'; // Importez l'écran d'administration
// // import 'package:medical/models/user_model.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Medical',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primaryColor: Colors.white,
// //         scaffoldBackgroundColor: Colors.white,
// //         appBarTheme: const AppBarTheme(
// //           backgroundColor: Colors.white,
// //           elevation: 0,
// //           iconTheme: IconThemeData(color: AppColors.primary),
// //           titleTextStyle: TextStyle(
// //             color: AppColors.primary,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //       // Routes nommées
// //       routes: {
// //         '/': (context) => SignInScreen(),
// //         '/signin': (context) => SignInScreen(),
// //         '/signup': (context) => SignUpScreen(),
// //         '/home': (context) => HomeScreen(),
// //         '/profile': (context) => ProfileScreen(),
// //         '/chatRoom': (context) => ChatRoomScreen(
// //               user: ModalRoute.of(context)!.settings.arguments as UserModel,
// //             ),
// //         '/specialistProfile': (context) {
// //           final specialist =
// //               ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
// //           return SpecialistProfileScreen(specialist: specialist);
// //         },
// //         '/admin': (context) => AdminScreen(), // Ajoutez la route pour l'écran d'administration
// //       },
// //       // Redirection après connexion en fonction du rôle
// //       onGenerateRoute: (settings) {
// //         if (settings.name == '/redirect') {
// //           final UserModel user = settings.arguments as UserModel;

// //           switch (user.role) {
// //             case 'admin':
// //               return MaterialPageRoute(
// //                 builder: (context) => AdminScreen(),
// //               );
// //             case 'professional':
// //               return MaterialPageRoute(
// //                 builder: (context) => SpecialistProfileScreen(
// //                   specialist: {
// //                     'id': user.id,
// //                     'name': user.fullName,
// //                     'specialty': 'Médecin généraliste', // Exemple de spécialité
// //                   },
// //                 ),
// //               );
// //             case 'user':
// //             default:
// //               return MaterialPageRoute(
// //                 builder: (context) => HomeScreen(),
// //               );
// //           }
// //         }
// //         return null;
// //       },
// //     );
// //   }
// // }


// // import 'package:flutter/material.dart';
// // import 'package:medical/constants/app_colors.dart';
// // import 'package:medical/screens/home_screen.dart';
// // import 'package:medical/screens/profile_screen.dart';
// // import 'package:medical/screens/signin_screen.dart';
// // import 'package:medical/screens/signup_screen.dart';
// // import 'package:medical/screens/specialist_profile_screen.dart';
// // import 'package:medical/screens/chat_room_screen.dart';
// // import 'package:medical/screens/admin/admin_screen.dart';
// // import 'package:medical/models/user_model.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Medical',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         useMaterial3: true,
// //         primaryColor: AppColors.primary,
// //         scaffoldBackgroundColor: Colors.white,
// //         appBarTheme: const AppBarTheme(
// //           backgroundColor: AppColors.primary,
// //           elevation: 0,
// //           centerTitle: true,
// //           iconTheme: IconThemeData(color: Colors.white),
// //           titleTextStyle: TextStyle(
// //             color: Colors.white,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         elevatedButtonTheme: ElevatedButtonThemeData(
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: AppColors.primary,
// //             foregroundColor: Colors.white,
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //           ),
// //         ),
// //       ),
// //       initialRoute: '/signin',
// //       routes: {
// //         '/': (context) => const SignInScreen(),
// //         '/signin': (context) => const SignInScreen(),
// //         '/signup': (context) => const SignUpScreen(),
// //         '/home': (context) => const HomeScreen(),
// //         '/profile': (context) => const ProfileScreen(),
// //         '/admin': (context) => AdminScreen(),
// //         '/chatRoom': (context) {
// //           final user = ModalRoute.of(context)!.settings.arguments as UserModel;
// //           return ChatRoomScreen(user: user);
// //         },
// //         '/specialistProfile': (context) {
// //           final user = ModalRoute.of(context)!.settings.arguments as UserModel;
// //           return SpecialistProfileScreen(
// //             specialist: user.toJson(), // Convert UserModel to Map<String, dynamic>
// //           );
// //         },
// //       },
// //       onGenerateRoute: (settings) {
// //         if (settings.name == '/redirect') {
// //           final user = settings.arguments as UserModel;
// //           return MaterialPageRoute(
// //             builder: (context) {
// //               switch (user.role) {
// //                 case 'admin':
// //                   return AdminScreen();
// //                 case 'professional':
// //                   return SpecialistProfileScreen(
// //                     specialist: user.toJson(), // Convert UserModel to Map<String, dynamic>
// //                   );
// //                 case 'user':
// //                 default:
// //                   return const HomeScreen();
// //               }
// //             },
// //           );
// //         }
// //         return null;
// //       },
// //     );
// //   }
// // }



// // import 'package:flutter/material.dart';
// // import 'package:medical/constants/app_colors.dart';
// // import 'package:medical/screens/home_screen.dart';
// // import 'package:medical/screens/profile_screen.dart';
// // import 'package:medical/screens/signin_screen.dart';
// // import 'package:medical/screens/signup_screen.dart';
// // import 'package:medical/screens/specialist_profile_screen.dart';
// // import 'package:medical/screens/chat_room_screen.dart';
// // import 'package:medical/screens/admin/admin_screen.dart';
// // import 'package:medical/models/user_model.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Medical',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         useMaterial3: true,
// //         primaryColor: AppColors.primary,
// //         scaffoldBackgroundColor: Colors.white,
// //         appBarTheme: const AppBarTheme(
// //           backgroundColor: AppColors.primary,
// //           elevation: 0,
// //           centerTitle: true,
// //           iconTheme: IconThemeData(color: Colors.white),
// //           titleTextStyle: TextStyle(
// //             color: Colors.white,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         elevatedButtonTheme: ElevatedButtonThemeData(
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: AppColors.primary,
// //             foregroundColor: Colors.white,
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //           ),
// //         ),
// //       ),
// //       initialRoute: '/signin',
// //       routes: {
// //         '/': (context) => const SignInScreen(),
// //         '/signin': (context) => const SignInScreen(),
// //         '/signup': (context) => const SignUpScreen(),
// //         '/home': (context) => const HomeScreen(),
// //         '/profile': (context) => const ProfileScreen(),
// //         '/admin': (context) =>  AdminScreen(),
// //         '/chatRoom': (context) {
// //           final user = ModalRoute.of(context)!.settings.arguments as UserModel;
// //           return ChatRoomScreen(user: user);
// //         },
// //         '/specialistProfile': (context) {
// //           final user = ModalRoute.of(context)!.settings.arguments as UserModel;
// //           return SpecialistProfileScreen(
// //             specialist: user.toJson(),
// //           );
// //         },
// //       },
// //       onGenerateRoute: (settings) {
// //         if (settings.name == '/redirect') {
// //           final user = settings.arguments as UserModel;
// //           print('Redirecting user with role: ${user.role}, data: ${user.toJson()}');
// //           return MaterialPageRoute(
// //             builder: (context) {
// //               switch (user.role) {
// //                 case 'admin':
// //                   return  AdminScreen();
// //                 case 'professional':
// //                   final specialistData = user.toJson();
// //                   specialistData['specialty'] ??= 'Médecin généraliste'; // Default if null
// //                   return SpecialistProfileScreen(
// //                     specialist: specialistData,
// //                   );
// //                 case 'user':
// //                 default:
// //                   return const HomeScreen();
// //               }
// //             },
// //           );
// //         }
// //         return null;
// //       },
// //     );
// //   }
// // }



// // import 'package:flutter/material.dart';
// // import 'package:medical/constants/app_colors.dart';
// // import 'package:medical/screens/home_screen.dart';
// // import 'package:medical/screens/profile_screen.dart';
// // import 'package:medical/screens/signin_screen.dart';
// // import 'package:medical/screens/signup_screen.dart';
// // import 'package:medical/screens/specialist_profile_screen.dart';
// // import 'package:medical/screens/chat_room_screen.dart';
// // import 'package:medical/screens/admin/admin_screen.dart';
// // import 'package:medical/models/user_model.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Medical',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         useMaterial3: true,
// //         primaryColor: AppColors.primary,
// //         scaffoldBackgroundColor: Colors.white,
// //         appBarTheme: const AppBarTheme(
// //           backgroundColor: AppColors.primary,
// //           elevation: 0,
// //           centerTitle: true,
// //           iconTheme: IconThemeData(color: Colors.white),
// //           titleTextStyle: TextStyle(
// //             color: Colors.white,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         elevatedButtonTheme: ElevatedButtonThemeData(
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: AppColors.primary,
// //             foregroundColor: Colors.white,
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //           ),
// //         ),
// //       ),
// //       initialRoute: '/signin',
// //       routes: {
// //         '/': (context) => const SignInScreen(),
// //         '/signin': (context) => const SignInScreen(),
// //         '/signup': (context) => const SignUpScreen(),
// //         '/home': (context) => const HomeScreen(),
// //         '/profile': (context) => const ProfileScreen(),
// //         '/admin': (context) =>  AdminScreen(),
// //         '/chatRoom': (context) {
// //           final user = ModalRoute.of(context)!.settings.arguments as UserModel;
// //           return ChatRoomScreen(user: user);
// //         },
// //         '/specialistProfile': (context) {
// //           final user = ModalRoute.of(context)!.settings.arguments as UserModel;
// //           return SpecialistProfileScreen(
// //             specialist: user.toJson(),
// //           );
// //         },
// //       },
// //       onGenerateRoute: (settings) {
// //         if (settings.name == '/redirect') {
// //           final user = settings.arguments as UserModel;
// //           print('Redirecting user with role: ${user.role}, data: ${user.toJson()}');
// //           return MaterialPageRoute(
// //             builder: (context) {
// //               switch (user.role) {
// //                 case 'admin':
// //                   return  AdminScreen();
// //                 case 'professional':
// //                   final specialistData = user.toJson();
// //                   specialistData['name'] = specialistData['fullName'] ?? 'Spécialiste inconnu';
// //                   specialistData['specialty'] ??= 'Médecin généraliste'; // Default if null
// //                   specialistData['image'] = specialistData['profilePhoto'] ?? 'assets/images/default_profile.png';
// //                   return SpecialistProfileScreen(
// //                     specialist: specialistData,
// //                   );
// //                 case 'user':
// //                 default:
// //                   return const HomeScreen();
// //               }
// //             },
// //           );
// //         }
// //         return null;
// //       },
// //     );
// //   }
// // }



// // import 'package:flutter/material.dart';
// // import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// // import 'package:medical/constants/app_colors.dart';
// // import 'package:medical/screens/home_screen.dart';
// // import 'package:medical/screens/profile_screen.dart' hide TextStyle;
// // import 'package:medical/screens/signin_screen.dart';
// // import 'package:medical/screens/signup_screen.dart';
// // import 'package:medical/screens/specialist_profile_screen.dart';
// // import 'package:medical/screens/chat_room_screen.dart';
// // import 'package:medical/screens/admin/admin_screen.dart';
// // import 'package:medical/screens/specialist_dashboard_screen.dart'; // New dashboard screen
// // import 'package:medical/models/user_model.dart';

// // Future<void> main() async {
// //   runApp(const MyApp());
// //   WidgetsFlutterBinding.ensureInitialized();

// //   // Configuration du cache
// //   await DefaultCacheManager().emptyCache();
  
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Medical',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         useMaterial3: true,
// //         primaryColor: AppColors.primary,
// //         scaffoldBackgroundColor: Colors.white,
// //         appBarTheme: AppBarTheme(
// //           backgroundColor: AppColors.primary,
// //           elevation: 0,
// //           centerTitle: true,
// //           iconTheme: const IconThemeData(color: Colors.white),
// //           titleTextStyle: TextStyle(
// //             color: Colors.white,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         elevatedButtonTheme: ElevatedButtonThemeData(
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: AppColors.primary,
// //             foregroundColor: Colors.white,
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //           ),
// //         ),
// //       ),
// //       initialRoute: '/signin',
// //       routes: {
// //         '/': (context) => const SignInScreen(),
// //         '/signin': (context) => const SignInScreen(),
// //         '/signup': (context) => const SignUpScreen(),
// //         '/home': (context) => const HomeScreen(),
// //         '/profile': (context) => const ProfileScreen(),
// //         '/admin': (context) =>  AdminScreen(),
// //         '/chatRoom': (context) {
// //           final user = ModalRoute.of(context)!.settings.arguments as UserModel;
// //           return ChatRoomScreen(user: user);
// //         },
// //         '/specialistProfile': (context) {
// //           final specialist = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
// //           return SpecialistProfileScreen(specialist: specialist); // Read-only for users
// //         },
// //       },
// //       onGenerateRoute: (settings) {
// //         if (settings.name == '/redirect') {
// //           final user = settings.arguments as UserModel;
// //           print('Redirecting user with role: ${user.role}, data: ${user.toJson()}');
// //           return MaterialPageRoute(
// //             builder: (context) {
// //               switch (user.role) {
// //                 case 'admin':
// //                   return  AdminScreen();
// //                 case 'professional':
// //                   final specialistData = user.toJson();
// //                   specialistData['name'] = specialistData['fullName'] ?? 'Spécialiste inconnu';
// //                   specialistData['specialty'] ??= 'Médecin généraliste';
// //                   specialistData['image'] = specialistData['profilePhoto'] ?? 'https://via.placeholder.com/150';
// //                   specialistData['availableHours'] ??= {
// //                     DateTime.monday: [const TimeOfDay(hour: 9, minute: 0)],
// //                     DateTime.tuesday: [const TimeOfDay(hour: 9, minute: 0)],
// //                     DateTime.wednesday: [const TimeOfDay(hour: 9, minute: 0)],
// //                     DateTime.thursday: [const TimeOfDay(hour: 9, minute: 0)],
// //                     DateTime.friday: [const TimeOfDay(hour: 9, minute: 0)],
// //                   };
// //                   specialistData['consultationPrices'] ??= {
// //                     'À domicile': '10 000 FCFA',
// //                     'À l\'hôpital': '8 000 FCFA',
// //                     'En ligne': '5 000 FCFA',
// //                   };
// //                   return SpecialistDashboardScreen(specialist: specialistData); // Editable for specialists
// //                 case 'user':
// //                 default:
// //                   return const HomeScreen();
// //               }
// //             },
// //           );
// //         }
// //         return null;
// //       },
// //     );
// //   }
// // }





// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:medical/constants/app_colors.dart';
// import 'package:medical/screens/home_screen.dart';
// import 'package:medical/screens/profile_screen.dart' hide TextStyle;
// import 'package:medical/screens/signin_screen.dart';
// import 'package:medical/screens/signup_screen.dart';
// import 'package:medical/screens/specialist_profile_screen.dart';
// import 'package:medical/screens/chat_room_screen.dart';
// import 'package:medical/screens/admin/admin_screen.dart';
// import 'package:medical/screens/specialist_dashboard_screen.dart';
// import 'package:medical/models/user_model.dart';
// import 'package:medical/widgets/splash_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Configuration du cache
//   await DefaultCacheManager().emptyCache();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Medical',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         primaryColor: AppColors.primary,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           backgroundColor: AppColors.primary,
//           elevation: 0,
//           centerTitle: true,
//           iconTheme: const IconThemeData(color: Colors.white),
//           titleTextStyle: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.primary,
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ),
//       home: const SplashScreen(),
//       routes: {
//         '/signin': (context) => const SignInScreen(),
//         '/signup': (context) => const SignUpScreen(),
//         '/home': (context) => const HomeScreen(),
//         '/profile': (context) => const ProfileScreen(),
//         '/admin': (context) => AdminScreen(),
//         '/chatRoom': (context) {
//           final user = ModalRoute.of(context)!.settings.arguments as UserModel;
//           return ChatRoomScreen(user: user);
//         },
//         '/specialistProfile': (context) {
//           final specialist = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//           return SpecialistProfileScreen(specialist: specialist);
//         },
//       },
//       onGenerateRoute: (settings) {
//         if (settings.name == '/redirect') {
//           final user = settings.arguments as UserModel;
//           print('Redirecting user with role: ${user.role}, data: ${user.toJson()}');
//           return MaterialPageRoute(
//             builder: (context) {
//               switch (user.role) {
//                 case 'admin':
//                   return AdminScreen();
//                 case 'professional':
//                   final specialistData = user.toJson();
//                   specialistData['name'] = specialistData['fullName'] ?? 'Spécialiste inconnu';
//                   specialistData['specialty'] ??= 'Médecin généraliste';
//                   specialistData['image'] = specialistData['profilePhoto'] ?? 'https://via.placeholder.com/150';
//                   specialistData['availableHours'] ??= {
//                     DateTime.monday: [const TimeOfDay(hour: 9, minute: 0)],
//                     DateTime.tuesday: [const TimeOfDay(hour: 9, minute: 0)],
//                     DateTime.wednesday: [const TimeOfDay(hour: 9, minute: 0)],
//                     DateTime.thursday: [const TimeOfDay(hour: 9, minute: 0)],
//                     DateTime.friday: [const TimeOfDay(hour: 9, minute: 0)],
//                   };
//                   specialistData['consultationPrices'] ??= {
//                     'À domicile': '10 000 FCFA',
//                     'À l\'hôpital': '8 000 FCFA',
//                     'En ligne': '5 000 FCFA',
//                   };
//                   return SpecialistDashboardScreen(specialist: specialistData);
//                 case 'user':
//                 default:
//                   return const HomeScreen();
//               }
//             },
//           );
//         }
//         return null;
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:medical/constants/app_colors.dart';
// import 'package:medical/models/professional_model.dart';
// import 'package:medical/screens/home_screen.dart';
// import 'package:medical/screens/profile_screen.dart' hide TextStyle;
// import 'package:medical/screens/signin_screen.dart';
// import 'package:medical/screens/signup_screen.dart';
// import 'package:medical/screens/specialist_profile_screen.dart';
// import 'package:medical/screens/chat_room_screen.dart';
// import 'package:medical/screens/admin/admin_screen.dart';
// import 'package:medical/screens/specialist_dashboard_screen.dart';
// import 'package:medical/models/user_model.dart';
// import 'package:medical/widgets/splash_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Configuration du cache
//   await DefaultCacheManager().emptyCache();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Medical',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         primaryColor: AppColors.primary,
//         scaffoldBackgroundColor: Colors.white,
//         appBarTheme: AppBarTheme(
//           backgroundColor: AppColors.primary,
//           elevation: 0,
//           centerTitle: true,
//           iconTheme: const IconThemeData(color: Colors.white),
//           titleTextStyle: TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: AppColors.primary,
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//         ),
//       ),
//       home: const SplashScreen(),
//       routes: {
//         '/signin': (context) => const SignInScreen(),
//         '/signup': (context) => const SignUpScreen(),
//         '/home': (context) => const HomeScreen(),
//         '/profile': (context) => const ProfileScreen(),
//         '/admin': (context) => AdminScreen(),
//         '/chatRoom': (context) {
//           final user = ModalRoute.of(context)!.settings.arguments as UserModel;
//           return ChatRoomScreen(user: user);
//         },
//         '/specialistProfile': (context) {
//           final specialist = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//           return SpecialistProfileScreen(specialist: specialist);
//         },
//       },
//       onGenerateRoute: (settings) {
//         if (settings.name == '/redirect') {
//           final user = settings.arguments as UserModel;
//           print('Redirecting user with role: ${user.role}, data: ${user.toJson()}');
//           return MaterialPageRoute(
//             builder: (context) {
//               switch (user.role) {
//                 case 'admin':
//                   return AdminScreen();
//                 case 'professional':
//                   final specialistData = user.toJson();
//                   specialistData['name'] = specialistData['fullName'] ?? 'Spécialiste inconnu';
//                   specialistData['specialty'] ??= 'Médecin généraliste';
//                   specialistData['image'] = specialistData['profilePhoto'] ?? 'https://via.placeholder.com/150';
//                   specialistData['availableHours'] ??= {
//                     DateTime.monday: [const TimeOfDay(hour: 9, minute: 0)],
//                     DateTime.tuesday: [const TimeOfDay(hour: 9, minute: 0)],
//                     DateTime.wednesday: [const TimeOfDay(hour: 9, minute: 0)],
//                     DateTime.thursday: [const TimeOfDay(hour: 9, minute: 0)],
//                     DateTime.friday: [const TimeOfDay(hour: 9, minute: 0)],
//                   };
//                   specialistData['consultationPrices'] ??= {
//                     'À domicile': '10 000 FCFA',
//                     'À l\'hôpital': '8 000 FCFA',
//                     'En ligne': '5 000 FCFA',
//                   };
//                   final specialist = ProfessionalModel.fromMap(specialistData);
//                   return SpecialistDashboardScreen(specialist: specialist);
//                 case 'user':
//                 default:
//                   return const HomeScreen();
//               }
//             },
//           );
//         }
//         return null;
//       },
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:medical/constants/app_colors.dart';
import 'package:medical/models/professional_model.dart';
import 'package:medical/screens/home_screen.dart';
import 'package:medical/screens/profile_screen.dart' hide TextStyle;
import 'package:medical/screens/signin_screen.dart';
import 'package:medical/screens/signup_screen.dart';
import 'package:medical/screens/specialist_profile_screen.dart';
import 'package:medical/screens/chat_room_screen.dart';
import 'package:medical/screens/admin/admin_screen.dart';
import 'package:medical/screens/specialist_dashboard_screen.dart';
import 'package:medical/models/user_model.dart';
import 'package:medical/widgets/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Configuration du cache
  await DefaultCacheManager().emptyCache();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/admin': (context) => AdminScreen(),
        '/chatRoom': (context) {
          final user = ModalRoute.of(context)!.settings.arguments as UserModel;
          return ChatRoomScreen(user: user);
        },
        '/specialistProfile': (context) {
          final specialist = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return SpecialistProfileScreen(specialist: specialist);
        },
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/redirect') {
          final user = settings.arguments as UserModel;
          print('Redirecting user with role: ${user.role}, data: ${user.toJson()}');
          return MaterialPageRoute(
            builder: (context) {
              switch (user.role) {
                case 'admin':
                  return AdminScreen();
                case 'professional':
                  final specialistData = user.toJson();
                  // Set only essential fields, rely on API data for availabilities and prices
                  specialistData['name'] = specialistData['fullName'] ?? 'Spécialiste inconnu';
                  specialistData['specialty'] ??= 'Médecin généraliste';
                  specialistData['image'] = specialistData['profilePhoto'] ?? 'https://via.placeholder.com/150';
                  final specialist = ProfessionalModel.fromMap(specialistData);
                  return SpecialistDashboardScreen(specialist: specialist);
                case 'user':
                default:
                  return const HomeScreen();
              }
            },
          );
        }
        return null;
      },
    );
  }
}