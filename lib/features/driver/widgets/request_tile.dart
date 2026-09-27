import 'package:flutter/material.dart';

import '../../../core/theme/theme_x.dart';
import '../../../data/models/ride_models.dart';
import '../../../shared/widgets/pressable.dart';
import 'trip_info_card.dart';

class RequestTile extends StatelessWidget {
  const RequestTile({super.key, required this.request, required this.onTap});

  final RideRequest request;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: onTap,
      scale: .98,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: c.divider),
        ),
        child: TripInfoCard(
          request: request,
          trailing: Icon(Icons.chevron_right_rounded, color: c.textMuted),
        ),
      ),
    );
  }
}
