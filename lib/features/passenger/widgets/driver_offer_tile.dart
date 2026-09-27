import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../data/models/ride_models.dart';
import '../../../shared/widgets/person_widgets.dart';
import '../../../shared/widgets/primary_button.dart';

class DriverOfferTile extends StatelessWidget {
  const DriverOfferTile({
    super.key,
    required this.offer,
    required this.onAccept,
    required this.onDecline,
  });

  final DriverOffer offer;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.divider),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: RatingPill(
              name: context.tr(offer.nameKey),
              rating: offer.rating,
              subtitle: '${context.tr(offer.carKey)} · ${context.tr('rides_count', {'n': offer.rides})}',
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(context.tr('minutes_short', {'m': offer.etaMinutes}), style: context.texts.bodySmall),
            Text(context.tr('meters', {'m': offer.distanceM}), style: context.texts.bodySmall),
          ]),
        ]),
        const SizedBox(height: 10),
        Text(context.money(offer.fare), style: context.texts.headlineMedium?.copyWith(fontSize: 24)),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
            child: PrimaryButton(
              label: context.tr('decline'),
              type: ButtonStyleType.outlined,
              height: 44,
              onPressed: onDecline,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: PrimaryButton(label: context.tr('accept'), height: 44, onPressed: onAccept),
          ),
        ]),
      ]),
    );
  }
}
