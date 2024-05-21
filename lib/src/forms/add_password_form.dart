import 'package:flutter/material.dart';
import 'package:password_administrator/database/db_helper.dart';
import 'package:password_administrator/model/password_model.dart';

class AddPasswordForm extends StatefulWidget {
  const AddPasswordForm({super.key});

  @override
  AddPasswordFormState createState() => AddPasswordFormState();
}

class AddPasswordFormState extends State<AddPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _addPassword() async {
    if (_formKey.currentState!.validate()) {
      final password = Password(
        site_name: _nameController.text,
        site_url: _urlController.text,
        password: _passwordController.text,
      );

      final dbHelper = DbHelper();
      final db = await dbHelper.getDatabase();

      await db.insert('passwords', password.toMap());

      _nameController.clear();
      _urlController.clear();
      _passwordController.clear();

      _showSnackBar('Mot de passe ajouté avec succès');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un mot de passe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom du site',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du site';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'URL du site',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'URL du site';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addPassword,
                child: const Text('Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
