import 'package:shared_preferences/shared_preferences.dart';

// wrapper صغير على shared_preferences عشان الـ viewmodel مايعرفش حاجة عن الـ storage
class PrefsService {
  PrefsService(this._prefs);

  final SharedPreferences _prefs;

  static const _themeKey = 'theme_mode';
  static const _langKey = 'lang';
  static const _onboardingKey = 'onboarding_done';

  static Future<PrefsService> create() async =>
      PrefsService(await SharedPreferences.getInstance());

  String? get themeMode => _prefs.getString(_themeKey);
  Future<void> saveThemeMode(String value) => _prefs.setString(_themeKey, value);

  String? get language => _prefs.getString(_langKey);
  Future<void> saveLanguage(String code) => _prefs.setString(_langKey, code);

  bool get onboardingDone => _prefs.getBool(_onboardingKey) ?? false;
  Future<void> saveOnboardingDone(bool value) =>
      _prefs.setBool(_onboardingKey, value);
}
