import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _profileUrlController = TextEditingController();
  final _dobController = TextEditingController(); // Date de naissance
  String _selectedGender = 'Homme'; // Par défaut

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
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
            children: [
              const SizedBox(height: 60),
              Center(
                child: Image.network(
                  'https://cdn3d.iconscout.com/3d/premium/thumb/sign-in-3025711-2527503.png', // Image en ligne
                  height: 150,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text('Failed to load image');
                  },
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
              _buildTextField('Entrez votre email', _emailController, icon: Icons.email),
              _buildTextField('Entrez votre mot de passe', _passwordController, isPassword: true, icon: Icons.lock),
              _buildDateField('Entrez votre date de naissance', _dobController, context),
              _buildGenderDropdown(),
              _buildTextField('Entrez le lien vers votre image', _profileUrlController, icon: Icons.image),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Logique d'inscription
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
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
                      Navigator.pushNamed(context, '/signin');
                    },
                    child: const Text(
                      'Connexion',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
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

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false, IconData? icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey[600]) : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller, BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: label,
              prefixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.wc, color: Colors.grey),
        ),
        items: ['Homme', 'Femme', 'Autre'].map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender, style: const TextStyle(fontSize: 16)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue!;
          });
        },
      ),
    );
  }
}