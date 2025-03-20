import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical/constants/app_colors.dart';
import 'dart:io'; // Pour utiliser File
import 'home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

enum CountryCode {
  togo('+228', Colors.green, 'assets/images/togo_flag.png'),
  france('+33', Colors.blue, 'assets/images/france_flag.png'),
  usa('+1', Colors.red, 'assets/images/usa_flag.jpeg');

  final String code;
  final Color color;
  final String flagPath;
  const CountryCode(this.code, this.color, this.flagPath);
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _dobController = TextEditingController();
  String _selectedGender = 'Homme';
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  bool _isLoading = false;
  bool _usePhoneNumber = false;
  File? _image;
  CountryCode _selectedCountry = CountryCode.togo;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

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

  bool _validateConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword && password.length >= 6;
  }

  void _handleSignUp(BuildContext context) async {
    final emailOrPhone = _usePhoneNumber ? _phoneNumberController.text.trim() : _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (_usernameController.text.isEmpty ||
        emailOrPhone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        _dobController.text.isEmpty ||
        _image == null) {
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

    if (!_validateConfirmPassword(password, confirmPassword)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Les mots de passe ne correspondent pas ou sont trop courts (min. 6 caractères)')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'inscription: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/register.png',
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Rejoignez Nous!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('Entrez votre nom', _usernameController, icon: Icons.person),
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
              _buildPasswordField('Entrez votre mot de passe', _passwordController, _obscureText, () {
                setState(() => _obscureText = !_obscureText);
              }),
              _buildPasswordField('Confirmez votre mot de passe', _confirmPasswordController, _obscureConfirmText, () {
                setState(() => _obscureConfirmText = !_obscureConfirmText);
              }),
              _buildDateField('Entrez votre date de naissance', _dobController, context),
              _buildGenderDropdown(),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.white, width: 1.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                ),
                child: const Text(
                  'Cliquez pour sélectionner une photo de profil',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              if (_image != null)
                Center(
                  child: Image.file(
                    _image!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : () => _handleSignUp(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 7, 56, 9),
                  padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_add, color: Colors.white),
                          SizedBox(width: 10),
                          Text("Inscription", style: TextStyle(color: Colors.white)),
                        ],
                      ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vous avez déjà un compte ?",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signin');
                    },
                    child: const Text(
                      'Connexion',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: hintText,
          prefixIcon: Icon(icon, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneOrEmailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: _usePhoneNumber
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
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
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
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Entrez votre email (ex: nom@domaine.com)',
                prefixIcon: const Icon(Icons.email, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
    );
  }

  Widget _buildPasswordField(String hintText, TextEditingController controller, bool obscureText, VoidCallback toggleVisibility) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: hintText,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
            onPressed: toggleVisibility,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(String hintText, TextEditingController controller, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: hintText,
          prefixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onTap: () => _selectDate(context),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        items: ['Homme', 'Femme', 'Autre']
            .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedGender = value!;
          });
        },
        decoration: InputDecoration(
          labelText: 'Sélectionnez votre genre',
          prefixIcon: const Icon(Icons.person),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}