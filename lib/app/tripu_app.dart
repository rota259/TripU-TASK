import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../core/l10n/app_localizations.dart';
import '../core/settings/settings_viewmodel.dart';
import '../core/theme/app_theme.dart';
import '../data/repositories/ride_repository.dart';
import '../data/repositories/wallet_repository.dart';
import '../features/onboarding/onboarding_view.dart';
import '../features/role/role_select_view.dart';

class TripUApp extends StatelessWidget {
  const TripUApp({super.key, required this.settings});

  final SettingsViewModel settings;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: settings),
        // repos بتتعمل مرة واحدة وكل الـ viewmodels بتاخدها من هنا
        Provider(create: (_) => RideRepository()),
        Provider(create: (_) => WalletRepository()),
      ],
      child: Consumer<SettingsViewModel>(
        builder: (context, s, _) => MaterialApp(
          title: 'TripU',
          debugShowCheckedModeBanner: false,
          themeMode: s.themeMode,
          theme: AppTheme.light(s.locale),
          darkTheme: AppTheme.dark(s.locale),
          themeAnimationDuration: const Duration(milliseconds: 400),
          locale: s.locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: s.onboardingDone
                ? const RoleSelectView()
                : const OnboardingView(),
          ),
        ),
      ),
    );
  }
}
