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
  
  @override
  void initState() {
    super.initState();
    _getPasswords();
  }

  Future<void> _getPasswords() async {
    final dbHelper = DbHelper();
    final passwords = await dbHelper.getPasswords(globals.userId);
    setState(() {
      _passwords = passwords.map((password) => Password(
          site_name: password.site_name,
          site_url: password.site_url,
          password: password.password,
          id_user: password.id_user,
          isPasswordVisible: false,
        )).toList();
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
              child: _passwords.isEmpty
                ? const Center(child: Text('Aucun mot de passe enregistré'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text('Nom du site'),
                          ),
                          DataColumn(
                            label: Text('URL'),
                          ),
                          DataColumn(
                            label: Text('Mot de passe'),
                          ),
                        ],
                        rows: _passwords.map((password) {
                          return DataRow(
                            cells: <DataCell>[
                              DataCell(Text(password.site_name)),
                              DataCell(Text(password.site_url),),
                              DataCell(
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: password.password,
                                        obscureText: !password.isPasswordVisible,
                                        enabled: false,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(password.isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                                      onPressed: () {
                                        setState(() {
                                          password.isPasswordVisible = !password.isPasswordVisible;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
