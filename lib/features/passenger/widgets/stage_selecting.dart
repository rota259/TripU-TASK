import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../shared/widgets/common.dart';
import '../../../shared/widgets/primary_button.dart';
import '../passenger_home_viewmodel.dart';
import 'fare_controls.dart';
import 'trip_fields.dart';
import 'vehicle_selector.dart';

class StageSelecting extends StatelessWidget {
  const StageSelecting({super.key, required this.vm});

  final PassengerHomeViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VehicleSelector(
          vehicles: vm.vehicles,
          selected: vm.vehicleIndex,
          onSelect: vm.selectVehicle,
        ),
        const SizedBox(height: 14),
        RouteFields(route: vm.route!),
        const SizedBox(height: 14),
        FareRow(fare: vm.fare, onMinus: vm.decreaseFare, onPlus: vm.increaseFare),
        SectionHeader(context.tr('payment')),
        const PaymentRow(),
        const SizedBox(height: 18),
        PrimaryButton(label: context.tr('confirm'), onPressed: vm.confirm),
      ],
    );
  }
}
