import 'package:flutter/cupertino.dart';
import 'package:password_administrator/src/app.dart';
import 'package:password_administrator/src/settings/settings_controller.dart';
import 'package:password_administrator/src/settings/settings_service.dart';

void main() async {

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));

}
