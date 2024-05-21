import 'package:flutter/material.dart';
import 'package:password_administrator/database/db_helper.dart';
import 'package:password_administrator/globals.dart';
import 'package:password_administrator/model/password_model.dart';
import 'package:password_administrator/src/forms/add_password_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Password> _passwords = [];
  final globals = Globals();
  bool _isPasswordVisible = false;
  
  @override
  void initState() {
    super.initState();
    _getPasswords();
  }

  Future<void> _getPasswords() async {
    final dbHelper = DbHelper();
    final passwords = await dbHelper.getPasswords(globals.userId);
    setState(() {
      _passwords = passwords;
    });
  }

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
                ).then((value) => _getPasswords());
              },
              child: const Text('Ajouter un mot de passe'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _passwords.length,
                itemBuilder: (BuildContext context, int index) {
                  final password = _passwords[index];
                  return ListTile(
                    title: Text(password.site_name),
                    subtitle: Text(password.site_url),
                    trailing: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible =!_isPasswordVisible;
                        });
                      },
                    ),
                  );
                },
              )
            )
          ],
        ),
      ),      
    );
  }
}
