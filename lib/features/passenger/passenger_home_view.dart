import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/map/trip_map.dart';
import '../../shared/widgets/app_drawer.dart';
import '../../shared/widgets/common.dart';
import '../../shared/widgets/map_panel_layout.dart';
import 'passenger_home_viewmodel.dart';
import 'widgets/booking_panel.dart';

class PassengerHomeView extends StatelessWidget {
  const PassengerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => PassengerHomeViewModel(c.read()),
      child: Scaffold(
        drawer: const AppDrawer(),
        body: Consumer<PassengerHomeViewModel>(
          builder: (context, vm, _) {
            final route = vm.route;
            if (route == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return MapPanelLayout(
              map: TripMap(
                route: route,
                showRoute: vm.stage != BookingStage.selecting,
                cars: vm.cars,
              ),
              topBar: Row(children: [
                Builder(
                  builder: (c) => CircleIconButton(
                    icon: Icons.menu_rounded,
                    onTap: () => Scaffold.of(c).openDrawer(),
                  ),
                ),
                const Spacer(),
                CircleIconButton(
                  icon: Icons.notifications_none_rounded,
                  onTap: () => showComingSoon(context),
                ),
              ]),
              panel: BookingPanel(vm: vm),
            );
          },
        ),
      ),
    );
  }
}
