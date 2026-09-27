import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/navigation/app_route.dart';
import '../../core/settings/settings_viewmodel.dart';
import '../../core/theme/theme_x.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/common.dart';
import '../../shared/widgets/fade_slide_in.dart';
import '../driver/driver_home_view.dart';
import '../passenger/passenger_home_view.dart';
import 'widgets/role_card.dart';

// مش في الديزاين، بس محتاجينها عشان نفصل بين تجربة الراكب والسواق
class RoleSelectView extends StatelessWidget {
  const RoleSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsViewModel>();
    final cards = [
      RoleCard(
        icon: Icons.person_pin_circle_rounded,
        title: context.tr('role_passenger'),
        subtitle: context.tr('role_passenger_sub'),
        onTap: () => context.push(const PassengerHomeView()),
      ),
      RoleCard(
        icon: Icons.directions_car_filled_rounded,
        title: context.tr('role_driver'),
        subtitle: context.tr('role_driver_sub'),
        onTap: () => context.push(const DriverHomeView(), name: DriverHomeView.routeName),
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          maxWidth: 760,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Spacer(),
                CircleIconButton(
                  icon: Icons.translate_rounded,
                  label: context.isArabic ? 'EN' : 'ع',
                  onTap: settings.toggleLanguage,
                ),
                const SizedBox(width: 10),
                CircleIconButton(
                  icon: context.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  onTap: () => settings.toggleTheme(Theme.of(context).brightness),
                ),
              ]),
              const Spacer(),
              FadeSlideIn(child: Text('TripU', style: context.texts.headlineMedium?.copyWith(fontSize: 38))),
              FadeSlideIn(index: 1, child: Text(context.tr('role_hint'), style: context.texts.bodySmall)),
              const SizedBox(height: 32),
              // في التابلت الكارتين جنب بعض
              if (context.isTablet)
                Row(children: [
                  for (final (i, card) in cards.indexed) ...[
                    if (i > 0) const SizedBox(width: 16),
                    Expanded(child: FadeSlideIn(index: i + 2, child: card)),
                  ],
                ])
              else
                for (final (i, card) in cards.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: FadeSlideIn(index: i + 2, child: card),
                  ),
              const Spacer(flex: 2),
            ]),
          ),
        ),
      ),
    );
  }
}
