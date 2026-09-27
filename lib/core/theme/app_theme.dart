import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_palette.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light(Locale locale) =>
      _build(AppPalette.light, Brightness.light, locale);

  static ThemeData dark(Locale locale) =>
      _build(AppPalette.dark, Brightness.dark, locale);

  static ThemeData _build(AppPalette p, Brightness b, Locale locale) {
    final base = ThemeData(
      brightness: b,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: p.primary,
        brightness: b,
        primary: p.primary,
        surface: p.surface,
      ),
    );
    return base.copyWith(
      scaffoldBackgroundColor: p.background,
      extensions: [p],
      textTheme: _texts(base.textTheme, p, locale),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: p.textPrimary,
        centerTitle: false,
      ),
      dividerTheme: DividerThemeData(color: p.divider, thickness: 1),
      drawerTheme: DrawerThemeData(backgroundColor: p.surface),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: p.textPrimary,
        contentTextStyle: TextStyle(color: p.background),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.surface,
        showDragHandle: true,
      ),
    );
  }

  // Cairo للعربي و Poppins للإنجليزي، نفس الأحجام في الاتنين
  static TextTheme _texts(TextTheme base, AppPalette p, Locale locale) {
    final themed = locale.languageCode == 'ar'
        ? GoogleFonts.cairoTextTheme(base)
        : GoogleFonts.poppinsTextTheme(base);
    final t = themed.apply(bodyColor: p.textPrimary, displayColor: p.textPrimary);
    return t.copyWith(
      headlineMedium: t.headlineMedium?.copyWith(fontSize: 28, fontWeight: FontWeight.w700, height: 1.25),
      titleLarge: t.titleLarge?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
      titleMedium: t.titleMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
      bodyLarge: t.bodyLarge?.copyWith(fontSize: 15),
      bodyMedium: t.bodyMedium?.copyWith(fontSize: 14),
      bodySmall: t.bodySmall?.copyWith(fontSize: 13, color: p.textMuted),
      labelLarge: t.labelLarge?.copyWith(fontSize: 15, fontWeight: FontWeight.w600),
      labelSmall: t.labelSmall?.copyWith(
          fontSize: 11, fontWeight: FontWeight.w600, letterSpacing: .8, color: p.textMuted),
    );
  }
}
