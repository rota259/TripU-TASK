import 'package:flutter/material.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/navigation/app_route.dart';
import '../../core/theme/theme_x.dart';
import '../../data/mock/mock_data.dart';
import '../../features/settings/settings_view.dart';
import '../../features/wallet/wallet_view.dart';
import 'common.dart';
import 'drawer_tile.dart';
import 'fade_slide_in.dart';
import 'person_widgets.dart';

enum DrawerItem {
  rides('menu_rides', Icons.local_taxi_rounded),
  rentTime('menu_rent_time', Icons.schedule_rounded),
  rentDays('menu_rent_days', Icons.calendar_month_rounded),
  wallet('menu_wallet', Icons.account_balance_wallet_rounded),
  history('menu_history', Icons.history_rounded),
  settings('menu_settings', Icons.settings_rounded),
  support('menu_support', Icons.headset_mic_rounded),
  invite('menu_invite', Icons.group_add_rounded),
  signOut('menu_sign_out', Icons.logout_rounded);

  const DrawerItem(this.labelKey, this.icon);
  final String labelKey;
  final IconData icon;
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, this.isDriver = false});

  final bool isDriver;

  void _onTap(BuildContext context, DrawerItem item) {
    Navigator.pop(context); // اقفل الدرور الأول
    switch (item) {
      case DrawerItem.rides:
        break;
      case DrawerItem.wallet:
        context.push(WalletView(isDriver: isDriver));
      case DrawerItem.settings:
        context.push(const SettingsView());
      case DrawerItem.signOut:
        Navigator.of(context).popUntil((r) => r.isFirst);
      default:
        showComingSoon(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = MockData.user;
    final c = context.colors;
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          children: [
            ListTile(
              leading: const Avatar(radius: 24),
              title: Text(context.tr(user.nameKey), style: context.texts.titleMedium),
              subtitle: Row(children: [
                Icon(Icons.star_rounded, size: 16, color: c.star),
                Text(' ${user.rating}  ${context.tr('trips_count', {'n': user.trips})}',
                    style: context.texts.bodySmall),
              ]),
              trailing: Icon(Icons.chevron_right_rounded, color: c.textMuted),
            ),
            const Divider(height: 24),
            for (final (i, item) in DrawerItem.values.indexed)
              FadeSlideIn(
                index: i,
                dy: 0,
                child: DrawerTile(
                  icon: item.icon,
                  label: context.tr(item.labelKey),
                  selected: item == DrawerItem.rides,
                  color: switch (item) {
                    DrawerItem.invite => c.primary,
                    DrawerItem.signOut => c.danger,
                    _ => null,
                  },
                  onTap: () => _onTap(context, item),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
