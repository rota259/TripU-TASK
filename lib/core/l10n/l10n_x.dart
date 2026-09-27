import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  String tr(String key, [Map<String, Object>? args]) => l10n.tr(key, args);

  bool get isArabic => l10n.isArabic;

  String get _lang => l10n.locale.languageCode;

  String money(Object value) => tr('money', {'v': value});

  String time(DateTime date) => DateFormat.jm(_lang).format(date);

  String longDate(DateTime date) => DateFormat.MMMMEEEEd(_lang).format(date);
}
