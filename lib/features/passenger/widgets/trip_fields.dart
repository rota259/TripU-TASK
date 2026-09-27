import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../data/models/ride_models.dart';

class LocationField extends StatelessWidget {
  const LocationField({super.key, required this.label, required this.isPickup});

  final String label;
  final bool isPickup;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(color: c.background, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(
          isPickup ? Icons.my_location_rounded : Icons.location_on_rounded,
          size: 18,
          color: isPickup ? c.primary : c.danger,
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: context.texts.bodyMedium)),
      ]),
    );
  }
}

// الاتنين مع بعض عشان بيتكرروا في أكتر من مرحلة
class RouteFields extends StatelessWidget {
  const RouteFields({super.key, required this.route, this.pickup = true});

  final TripRoute route;
  final bool pickup;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (pickup) ...[
        LocationField(label: context.tr(route.pickupKey), isPickup: true),
        const SizedBox(height: 8),
      ],
      LocationField(label: context.tr(route.destinationKey), isPickup: false),
    ]);
  }
}

class PaymentRow extends StatelessWidget {
  const PaymentRow({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(children: [
      Icon(Icons.payments_rounded, size: 22, color: c.success),
      const SizedBox(width: 12),
      Text(context.tr('cash'), style: context.texts.titleMedium),
      const Spacer(),
      Text(context.tr('change'), style: context.texts.bodySmall?.copyWith(color: c.primary)),
      Icon(Icons.chevron_right_rounded, size: 18, color: c.textMuted),
    ]);
  }
}
