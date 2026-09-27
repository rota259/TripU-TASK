import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../shared/widgets/info_chip.dart';
import '../../../shared/widgets/primary_button.dart';
import '../passenger_home_viewmodel.dart';
import 'fare_controls.dart';
import 'trip_fields.dart';
import 'vehicle_selector.dart';

// المسار بيترسم على الخريطة في المرحلة دي
class StageConfirmed extends StatelessWidget {
  const StageConfirmed({super.key, required this.vm});

  final PassengerHomeViewModel vm;

  @override
  Widget build(BuildContext context) {
    final route = vm.route!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VehicleSelector(
          vehicles: vm.vehicles,
          selected: vm.vehicleIndex,
          onSelect: vm.selectVehicle,
        ),
        const SizedBox(height: 14),
        RouteFields(route: route),
        const SizedBox(height: 14),
        FareRow(fare: vm.fare, onMinus: vm.decreaseFare, onPlus: vm.increaseFare),
        const SizedBox(height: 12),
        InfoChip(
          icon: Icons.schedule_rounded,
          text: context.tr('travel_time', {'m': route.minutes, 'km': route.distanceKm}),
        ),
        const SizedBox(height: 16),
        PrimaryButton(label: context.tr('find_ride'), onPressed: vm.findRide),
        const SizedBox(height: 10),
        PrimaryButton(
          label: context.tr('cancel'),
          type: ButtonStyleType.outlined,
          onPressed: vm.cancel,
        ),
      ],
    );
  }
}
