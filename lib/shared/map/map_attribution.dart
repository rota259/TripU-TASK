import 'package:flutter/material.dart';

import '../../core/theme/theme_x.dart';

class MapAttribution extends StatelessWidget {
  const MapAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    // الـ attribution لازم يفضل ظاهر (شرط رخصة OSM)
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 18),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: context.colors.surface.withValues(alpha: .8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text('© OpenStreetMap', style: context.texts.bodySmall?.copyWith(fontSize: 10)),
        ),
      ),
    );
  }
}
