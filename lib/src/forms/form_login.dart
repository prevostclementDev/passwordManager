import 'package:flutter/material.dart';
import 'package:password_administrator/database/db_helper.dart';
import 'package:password_administrator/src/views/home.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  FormLoginState createState() => FormLoginState();
}

class FormLoginState extends State<FormLogin> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> submit() async {
    final username = _controllerUsername.text;
    final password = _controllerPassword.text;

    final dbHelper = DbHelper();
    final db = await dbHelper.getDatabase();

    final results = await db.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);

    if (!mounted) return;

    if (results.isNotEmpty) {
      // L'utilisateur est authentifié avec succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connexion établie !')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Les informations de connexion sont incorrectes
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de la connexion.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire de connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _controllerUsername,
              decoration: const InputDecoration(
                labelText: 'Nom d\'utilisateur',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _controllerPassword,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: submit,
              child: const Text('Connexion'),
            ),
          ],
        ),
      ),
    );
  }
}
