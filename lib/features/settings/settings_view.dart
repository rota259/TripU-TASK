import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/settings/settings_viewmodel.dart';
import '../../core/theme/theme_x.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/common.dart';
import '../../shared/widgets/fade_slide_in.dart';
import 'widgets/option_tile.dart';

// الإعدادات بتتطبق على طول من غير restart وبتتحفظ
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const _themes = [
    (ThemeMode.light, 'theme_light', Icons.light_mode_rounded),
    (ThemeMode.dark, 'theme_dark', Icons.dark_mode_rounded),
    (ThemeMode.system, 'theme_system', Icons.brightness_auto_rounded),
  ];

  static const _languages = [
    ('ar', 'العربية', Icons.translate_rounded),
    ('en', 'English', Icons.language_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final s = context.watch<SettingsViewModel>();
    var i = 0;
    return Scaffold(
      appBar: AppBar(),
      body: ResponsiveCenter(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
          children: [
            Text(context.tr('menu_settings'), style: context.texts.headlineMedium?.copyWith(fontSize: 32)),
            SectionHeader(context.tr('appearance')),
            for (final (mode, key, icon) in _themes)
              FadeSlideIn(
                index: i++,
                child: OptionTile(
                  icon: icon,
                  label: context.tr(key),
                  selected: s.themeMode == mode,
                  onTap: () => s.setThemeMode(mode),
                ),
              ),
            SectionHeader(context.tr('language')),
            // أسماء اللغات مش بتتترجم، كل لغة مكتوبة بنفسها
            for (final (code, name, icon) in _languages)
              FadeSlideIn(
                index: i++,
                child: OptionTile(
                  icon: icon,
                  label: name,
                  selected: s.locale.languageCode == code,
                  onTap: () => s.setLanguage(code),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
