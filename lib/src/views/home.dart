import 'package:flutter/material.dart';
import 'package:password_administrator/database/db_helper.dart';
import 'package:password_administrator/globals.dart';
import 'package:password_administrator/model/password_model.dart';
import 'package:password_administrator/src/forms/add_password_form.dart';
import 'package:password_administrator/src/forms/form_login.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Password> _passwords = [];
  
  @override
  void initState() {
    super.initState();
    _getPasswords();
  }

  Future<void> _getPasswords() async {
    final dbHelper = DbHelper();
    final passwords = await dbHelper.getPasswords(Globals.user['id']);
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

  String connectFromText = "Connecté en tant que ${Globals.user['username']}";

  void _launchURL(String url) async {
    final endUrl = Uri.parse(url);
    if (!await launchUrl(endUrl, mode: LaunchMode.externalApplication)){
      throw Exception('Could not launch $endUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionnaire de mots de passe'),
        bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Text(connectFromText, textAlign: TextAlign.left)
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
            onPressed: () {
              Globals.user = {};
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const FormLogin()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              : Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: <DataColumn>[
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
                            DataCell(
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _launchURL(password.site_url);
                                    },
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Ouvrir',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.open_in_new, color: Colors.blue),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    tooltip: 'Afficher le mot de passe',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
              ),
          )
        ],
      ),
    );
  }
}