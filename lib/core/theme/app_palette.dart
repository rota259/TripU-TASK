import 'package:flutter/material.dart';

// كل ألوان التطبيق هنا، light و dark
// بنستخدمها من context.colors بدل ما نكتب hex في كل widget
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.primary,
    required this.primarySoft,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textMuted,
    required this.divider,
    required this.success,
    required this.danger,
    required this.star,
    required this.walletGradient,
    required this.heroGradient,
  });

  final Color primary;
  final Color primarySoft;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textMuted;
  final Color divider;
  final Color success;
  final Color danger;
  final Color star;
  final List<Color> walletGradient;
  final List<Color> heroGradient;

  static const light = AppPalette(
    primary: Color(0xFF2E5BFF),
    primarySoft: Color(0xFFEAF0FF),
    background: Color(0xFFF6F7FB),
    surface: Colors.white,
    textPrimary: Color(0xFF14142B),
    textMuted: Color(0xFF8A8FA3),
    divider: Color(0xFFECEEF3),
    success: Color(0xFF1FBF75),
    danger: Color(0xFFF04438),
    star: Color(0xFFFFC107),
    walletGradient: [Color(0xFF8C9BF0), Color(0xFF6E7FE8)],
    heroGradient: [Color(0xFF2E5BFF), Color(0xFF1B3FE0)],
  );

  static const dark = AppPalette(
    primary: Color(0xFF5B7CFF),
    primarySoft: Color(0xFF1E2747),
    background: Color(0xFF0F1117),
    surface: Color(0xFF1A1D27),
    textPrimary: Color(0xFFF2F3F7),
    textMuted: Color(0xFF9096A8),
    divider: Color(0xFF2A2E3B),
    success: Color(0xFF2ED18A),
    danger: Color(0xFFFF5A4F),
    star: Color(0xFFFFC107),
    walletGradient: [Color(0xFF3B4A9E), Color(0xFF28337A)],
    heroGradient: [Color(0xFF2343C7), Color(0xFF101E6B)],
  );

  @override
  AppPalette copyWith() => this;

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    List<Color> ll(List<Color> a, List<Color> b) =>
        [for (var i = 0; i < a.length; i++) l(a[i], b[i])];
    return AppPalette(
      primary: l(primary, other.primary),
      primarySoft: l(primarySoft, other.primarySoft),
      background: l(background, other.background),
      surface: l(surface, other.surface),
      textPrimary: l(textPrimary, other.textPrimary),
      textMuted: l(textMuted, other.textMuted),
      divider: l(divider, other.divider),
      success: l(success, other.success),
      danger: l(danger, other.danger),
      star: l(star, other.star),
      walletGradient: ll(walletGradient, other.walletGradient),
      heroGradient: ll(heroGradient, other.heroGradient),
    );
  }
}
