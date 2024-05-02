import 'package:flutter/material.dart';

import 'model/user_model.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {

  // final settingsController = SettingsController(SettingsService());
  //
  // await settingsController.loadSettings();
  //
  // runApp(MyApp(settingsController: settingsController));

  const User user = User(id: 10, username: 'clement', password: 'prevost');
  user.list();
}