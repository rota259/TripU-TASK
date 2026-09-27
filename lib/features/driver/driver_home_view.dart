import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/navigation/app_route.dart';
import '../../core/theme/theme_x.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/app_drawer.dart';
import '../../shared/widgets/fade_slide_in.dart';
import 'driver_home_viewmodel.dart';
import 'request_detail_view.dart';
import 'widgets/offline_state.dart';
import 'widgets/online_toggle.dart';
import 'widgets/request_tile.dart';

class DriverHomeView extends StatelessWidget {
  const DriverHomeView({super.key});

  // بنرجعلها بـ popUntil بعد ما الرحلة تبدأ
  static const routeName = 'driver-home';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => DriverHomeViewModel(c.read()),
      child: Consumer<DriverHomeViewModel>(
        builder: (context, vm, _) => Scaffold(
          drawer: const AppDrawer(isDriver: true),
          appBar: AppBar(title: Text(context.tr('requests'), style: context.texts.titleLarge)),
          body: ResponsiveCenter(
            maxWidth: 640,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: OnlineToggle(online: vm.online, onChanged: vm.setOnline),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _body(context, vm),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, DriverHomeViewModel vm) {
    if (!vm.online) {
      return OfflineState(key: const ValueKey('off'), onGoOnline: () => vm.setOnline(true));
    }
    if (vm.loading && vm.requests.isEmpty) {
      return const Center(key: ValueKey('loading'), child: CircularProgressIndicator());
    }
    return RefreshIndicator(
      key: const ValueKey('list'),
      color: context.colors.primary,
      onRefresh: vm.refresh,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        itemCount: vm.requests.length,
        itemBuilder: (context, i) {
          final r = vm.requests[i];
          return FadeSlideIn(
            key: ValueKey(r.id),
            index: i,
            child: RequestTile(
              request: r,
              onTap: () => context.push(RequestDetailView(request: r)),
            ),
          );
        },
      ),
    );
  }
}
