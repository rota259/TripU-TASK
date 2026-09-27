import 'package:flutter/material.dart';

import 'app/tripu_app.dart';
import 'core/settings/prefs_service.dart';
import 'core/settings/settings_viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // بنقرا الإعدادات قبل runApp عشان التطبيق يفتح على الثيم واللغة الصح من أول frame
  final settings = SettingsViewModel(await PrefsService.create())..load();

  runApp(TripUApp(settings: settings));
}
