import 'package:flutter/material.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/navigation/app_route.dart';
import '../../data/models/ride_models.dart';
import '../../shared/map/trip_map.dart';
import '../../shared/widgets/common.dart';
import '../../shared/widgets/info_chip.dart';
import '../../shared/widgets/map_panel_layout.dart';
import 'driver_home_view.dart';
import 'widgets/swipe_to_start.dart';
import 'widgets/trip_info_card.dart';

// الراكب وافق: العربية بتتحرك على المسار والسواق يسحب عشان يبدأ
class TripAcceptedView extends StatelessWidget {
  const TripAcceptedView({super.key, required this.request, required this.fare});

  final RideRequest request;
  final int fare;

  void _start(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    final msg = context.tr('trip_started');
    context.popUntilNamed(DriverHomeView.routeName);
    messenger.showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapPanelLayout(
        map: TripMap(route: request.route, movingCar: true),
        topBar: Align(
          alignment: AlignmentDirectional.topStart,
          child: CircleIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
        panel: Column(mainAxisSize: MainAxisSize.min, children: [
          TripInfoCard(request: request, fare: fare),
          const SizedBox(height: 14),
          InfoChip(
            icon: Icons.timer_outlined,
            text: context.tr('pickup_time', {'m': request.etaMinutes}),
          ),
          const SizedBox(height: 16),
          SwipeToStart(label: context.tr('swipe_to_start'), onDone: () => _start(context)),
        ]),
      ),
    );
  }
}
