import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/common.dart';
import '../../../shared/widgets/primary_button.dart';
import '../passenger_home_viewmodel.dart';
import 'fare_controls.dart';
import 'trip_fields.dart';

// "مفيش سواقين متاحين" -> يزود السعر ويدور تاني
class StageSearching extends StatelessWidget {
  const StageSearching({super.key, required this.vm});

  final PassengerHomeViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(context.tr('no_drivers_title'), style: context.texts.titleMedium),
        const SizedBox(height: 4),
        Text(
          context.tr('no_drivers_body'),
          textAlign: TextAlign.center,
          style: context.texts.bodySmall,
        ),
        const SizedBox(height: 12),
        // progress bar بيتحرك طول ما احنا بندور
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            minHeight: 4,
            color: context.colors.primary,
            backgroundColor: context.colors.primarySoft,
          ),
        ),
        const SizedBox(height: 16),
        Row(children: [
          StepButton(icon: Icons.remove_rounded, onTap: vm.decreaseFare, size: 46),
          Expanded(
            child: Center(child: AnimatedFare(fare: vm.fare, style: context.texts.headlineMedium)),
          ),
          StepButton(icon: Icons.add_rounded, onTap: vm.increaseFare, size: 46),
        ]),
        const SizedBox(height: 16),
        PrimaryButton(
          label: context.tr('raise_fare'),
          loading: vm.loadingOffers,
          onPressed: vm.raiseFareAndSearch,
        ),
        const SizedBox(height: 10),
        PrimaryButton(
          label: context.tr('cancel_request'),
          type: ButtonStyleType.outlined,
          onPressed: vm.cancel,
        ),
        const SizedBox(height: 14),
        RouteFields(route: vm.route!, pickup: false),
        const SizedBox(height: 10),
        Row(children: [
          const EgpBadge(),
          const SizedBox(width: 8),
          Text(context.money(vm.fare), style: context.texts.titleMedium),
          const Spacer(),
          Text(context.tr('cash'), style: context.texts.bodySmall),
        ]),
      ],
    );
  }
}
