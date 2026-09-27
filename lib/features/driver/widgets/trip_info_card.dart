import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../data/models/ride_models.dart';
import '../../../shared/widgets/person_widgets.dart';

// بيانات الراكب + المسار + السعر، متكررة في كل شاشات السواق
class TripInfoCard extends StatelessWidget {
  const TripInfoCard({super.key, required this.request, this.fare, this.trailing});

  final RideRequest request;
  final int? fare; // لو السواق عرض سعر غير سعر الراكب
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final r = request;
    final c = context.colors;
    return Row(children: [
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RatingPill(
              name: context.tr(r.passengerKey),
              rating: r.rating,
              subtitle: context.tr('trips_count', {'n': r.trips}),
              radius: 19,
            ),
            const SizedBox(height: 10),
            Row(children: [
              Icon(Icons.location_on_rounded, size: 16, color: c.primary),
              const SizedBox(width: 4),
              Expanded(
                child: RouteLine(
                  from: context.tr(r.route.pickupKey),
                  to: context.tr(r.route.destinationKey),
                  style: context.texts.bodyMedium,
                ),
              ),
            ]),
            const SizedBox(height: 4),
            Text(
              '${context.money(fare ?? r.fare)} · ${context.tr('km', {'v': r.route.distanceKm})}'
              ' · ${context.tr('minutes_short', {'m': r.etaMinutes})}',
              style: context.texts.titleMedium,
            ),
          ],
        ),
      ),
      ?trailing,
    ]);
  }
}
