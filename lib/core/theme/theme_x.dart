import 'package:flutter/material.dart';

import 'app_palette.dart';

extension ThemeX on BuildContext {
  AppPalette get colors => Theme.of(this).extension<AppPalette>()!;
  TextTheme get texts => Theme.of(this).textTheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}
