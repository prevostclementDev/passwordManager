import 'package:flutter/material.dart';
import 'package:password_administrator/src/forms/form_login.dart';
import 'package:password_administrator/src/forms/form_register.dart';

import 'settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {

    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(

          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          debugShowCheckedModeBanner: false,
          title: 'Gestionnaire de mots de passe',
          home: const FormLogin(),
        );
      },
    );
  }
}
