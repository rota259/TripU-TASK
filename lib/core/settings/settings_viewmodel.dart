import 'package:flutter/material.dart';

import 'prefs_service.dart';

// app-level state: الثيم واللغة وهل المستخدم شاف الـ onboarding ولا لأ
class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel(this._prefs);

  final PrefsService _prefs;

  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('ar');
  bool _onboardingDone = false;

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  bool get onboardingDone => _onboardingDone;
  bool get isArabic => _locale.languageCode == 'ar';

  void load() {
    _themeMode = ThemeMode.values.firstWhere(
      (m) => m.name == _prefs.themeMode,
      orElse: () => ThemeMode.system,
    );
    // أول مرة بناخد لغة الموبايل، لو مش عربي يبقى انجليزي
    final device = WidgetsBinding.instance.platformDispatcher.locale;
    final code = _prefs.language ?? (device.languageCode == 'ar' ? 'ar' : 'en');
    _locale = Locale(code);
    _onboardingDone = _prefs.onboardingDone;
  }

  void setThemeMode(ThemeMode mode) {
    if (mode == _themeMode) return;
    _themeMode = mode;
    _prefs.saveThemeMode(mode.name);
    notifyListeners();
  }

  // quick toggle من الـ top bar: بيقلب بين light و dark بس
  void toggleTheme(Brightness current) => setThemeMode(
      current == Brightness.dark ? ThemeMode.light : ThemeMode.dark);

  void setLanguage(String code) {
    if (code == _locale.languageCode) return;
    _locale = Locale(code);
    _prefs.saveLanguage(code);
    notifyListeners();
  }

  void toggleLanguage() => setLanguage(isArabic ? 'en' : 'ar');

  void completeOnboarding() {
    _onboardingDone = true;
    _prefs.saveOnboardingDone(true);
    notifyListeners();
  }
}
