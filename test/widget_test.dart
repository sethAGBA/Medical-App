import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical/main.dart';
import 'package:medical/screens/signin_screen.dart';

void main() {
  testWidgets('SignInScreen displays correctly', (WidgetTester tester) async {
    // Construire l'écran de connexion
    await tester.pumpWidget(MaterialApp(
      home: SignInScreen(),
    ));

    // Vérifier que le titre de l'AppBar est correct
    expect(find.text('Connexion'), findsOneWidget);

    // Vérifier que les champs de texte sont présents
    expect(find.byType(TextField), findsNWidgets(2)); // 2 champs de texte (email et mot de passe)

    // Vérifier que le bouton de connexion est présent
    expect(find.text('Connexion'), findsOneWidget);

    // Vérifier que le lien vers l'écran d'inscription est présent
    expect(find.text('Pas de compte ? Inscrivez-vous'), findsOneWidget);
  });

  testWidgets('SignInScreen navigates to HomeScreen on successful login', (WidgetTester tester) async {
    // Construire l'application
    await tester.pumpWidget(MyApp());

    // Naviguer vers l'écran de connexion
    await tester.tap(find.text('Connexion'));
    await tester.pumpAndSettle();

    // Remplir les champs de texte
    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    // Appuyer sur le bouton de connexion
    await tester.tap(find.text('Connexion'));
    await tester.pumpAndSettle();

    // Vérifier que l'écran d'accueil est affiché
    expect(find.text('Medical'), findsOneWidget);
  });
}