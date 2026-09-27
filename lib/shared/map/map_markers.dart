import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../core/theme/theme_x.dart';
import 'pulsing_dot.dart';

// markers الخريطة: مكان الركوب (نقطة بتنبض)، الوجهة، والعربيات اللي حوالين
class MapMarkers {
  MapMarkers._();

  static Marker pickup(LatLng p) =>
      Marker(point: p, width: 64, height: 64, child: const PulsingDot());

  static Marker destination(LatLng p) => Marker(
        point: p,
        width: 44,
        height: 44,
        alignment: Alignment.topCenter,
        child: Builder(
          builder: (c) => Icon(Icons.location_on_rounded, size: 44, color: c.colors.danger),
        ),
      );

  static Marker car(LatLng p) =>
      Marker(point: p, width: 34, height: 34, child: const CarIcon());

  // العربية اللي ماشية: سهم بيلف مع اتجاه الشارع
  static Marker heading(LatLng p, double angle) => Marker(
        point: p,
        width: 40,
        height: 40,
        child: Builder(
          builder: (c) => Container(
            decoration: BoxDecoration(
              color: c.colors.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: const [BoxShadow(color: Color(0x44000000), blurRadius: 8)],
            ),
            child: Transform.rotate(
              angle: angle,
              child: const Icon(Icons.navigation_rounded, color: Colors.white, size: 20),
            ),
          ),
        ),
      );
}

class CarIcon extends StatelessWidget {
  const CarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Color(0x33000000), blurRadius: 6)],
      ),
      child: Icon(Icons.local_taxi_rounded, size: 20, color: context.colors.textPrimary),
    );
  }
}
