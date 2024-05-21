import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionnaire de mots de passe'),
      ),
      body: const Center(
        child: Text('Bienvenue dans le gestionnaire de mots de passe !'),
      ),
    );
  }
}
