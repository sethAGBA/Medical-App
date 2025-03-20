import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:medical/screens/signin_screen.dart' as signin;

enum CountryCode {
  togo('+228', Colors.green, 'assets/images/togo_flag.png'),
  france('+33', Colors.blue, 'assets/images/france_flag.png'),
  usa('+1', Colors.red, 'assets/images/usa_flag.jpeg');

  final String code;
  final Color color;
  final String flagPath;
  const CountryCode(this.code, this.color, this.flagPath);
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _usePhoneNumber = false;
  bool _obscureText = true;
  CountryCode _selectedCountry = CountryCode.togo;

  bool _validateEmailOrPhone(String value) {
    if (_usePhoneNumber) {
      final fullNumber = _selectedCountry.code + value;
      print('Validating phone number: $fullNumber'); // Débogage

      switch (_selectedCountry) {
        case CountryCode.togo:
          final phoneRegex = RegExp(r'^\+228[9][0-1][0-9]{6}$');
          return phoneRegex.hasMatch(fullNumber) && value.length == 8;
        case CountryCode.france:
          final phoneRegex = RegExp(r'^\+33[6-7][0-9]{8}$');
          return phoneRegex.hasMatch(fullNumber) && value.length == 9;
        case CountryCode.usa:
          final phoneRegex = RegExp(r'^\+1[2-9][0-9]{9}$');
          return phoneRegex.hasMatch(fullNumber) && value.length == 10;
      }
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      return emailRegex.hasMatch(value);
    }
    return false;
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }

  void _handleSignIn(BuildContext context) {
    final emailOrPhone = _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (emailOrPhone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    if (!_validateEmailOrPhone(emailOrPhone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_usePhoneNumber
              ? 'Veuillez entrer un numéro valide (${_selectedCountry == CountryCode.togo ? "8 chiffres" : _selectedCountry == CountryCode.france ? "9 chiffres" : "10 chiffres"} après ${_selectedCountry.code})'
              : 'Veuillez entrer un email valide (ex: nom@domaine.com)'),
        ),
      );
      return;
    }

    if (!_validatePassword(password)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Le mot de passe doit contenir au moins 6 caractères')),
      );
      return;
    }

    // Simuler une connexion réussie
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo ou image
              Image.asset(
                'assets/images/login.png',
                height: 200,
              ),
              const SizedBox(height: 30),

              // Titre
              Text(
                'Content de te revoir!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 40),

              // Champ Email ou Téléphone
              Row(
                children: [
                  Expanded(
                    child: _buildPhoneOrEmailField(),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                      _usePhoneNumber ? Icons.email : Icons.phone,
                      color: _usePhoneNumber ? Colors.grey : _selectedCountry.color,
                    ),
                    onPressed: () {
                      setState(() {
                        _usePhoneNumber = !_usePhoneNumber;
                        _emailController.clear();
                        _phoneNumberController.clear();
                      });
                    },
                    tooltip: _usePhoneNumber
                        ? 'Utiliser un email'
                        : 'Utiliser un numéro de téléphone',
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Champ Mot de passe
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() => _obscureText = !_obscureText);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Bouton Connexion
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 7, 56, 9),
                  padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onPressed: () => _handleSignIn(context),
                child: const Text(
                  'Se connecter',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              // Lien Inscription
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 16.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Pas de compte ? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      TextSpan(
                        text: 'Inscrivez-vous',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneOrEmailField() {
    return _usePhoneNumber
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton<CountryCode>(
                value: _selectedCountry,
                items: CountryCode.values
                    .map((country) => DropdownMenuItem(
                          value: country,
                          child: Row(
                            children: [
                              Image.asset(
                                country.flagPath,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                country.code,
                                style: TextStyle(color: country.color),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value!;
                    _phoneNumberController.clear();
                  });
                },
                underline: const SizedBox(),
              ),
              const SizedBox(width: 8),
              Container(
                width: 60,
                child: TextField(
                  controller: TextEditingController(text: _selectedCountry.code),
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Numéro (ex: ${_selectedCountry == CountryCode.togo ? "90123456" : _selectedCountry == CountryCode.france ? "612345678" : "2025550123"})',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ],
          )
        : TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email (ex: nom@domaine.com)',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}