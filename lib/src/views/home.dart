import 'package:flutter/material.dart';
import 'package:password_administrator/src/forms/add_password_form.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionnaire de mots de passe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Bienvenue dans le gestionnaire de mots de passe !'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPasswordForm()),
                );
              },
              child: const Text('Ajouter un mot de passe'),
            )
          ],
        ),
      ),      
    );
  }
}
