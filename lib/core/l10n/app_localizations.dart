import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// الترجمة من ملفات json في assets/lang
// اخترت كده بدل gen-l10n عشان الـ strings تبقى في مكان واحد وسهل تتعدل
class AppLocalizations {
  AppLocalizations(this.locale, this._strings);

  final Locale locale;
  final Map<String, String> _strings;

  static const supportedLocales = [Locale('ar'), Locale('en')];
  static const delegate = _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  bool get isArabic => locale.languageCode == 'ar';

  /// tr('money', {'v': 50}) -> "50 EGP"
  String tr(String key, [Map<String, Object>? args]) {
    var value = _strings[key];
    if (value == null) {
      assert(() {
        debugPrint('missing translation: $key (${locale.languageCode})');
        return true;
      }());
      return key;
    }
    args?.forEach((k, v) => value = value!.replaceAll('{$k}', '$v'));
    return value!;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      const ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final raw =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    final map = (json.decode(raw) as Map<String, dynamic>)
        .map((k, v) => MapEntry(k, v.toString()));
    return AppLocalizations(locale, map);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
