import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'map_markers.dart';

// عربية بتمشي على المسار في loop، بتلف حسب اتجاه الشارع
class MovingCarLayer extends StatefulWidget {
  const MovingCarLayer({super.key, required this.points});

  final List<LatLng> points;

  @override
  State<MovingCarLayer> createState() => _MovingCarLayerState();
}

class _MovingCarLayerState extends State<MovingCarLayer>
    with SingleTickerProviderStateMixin {
  late final _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 14),
  )..repeat();

  late final List<double> _cumulative = _buildDistances();

  List<double> _buildDistances() {
    const d = Distance();
    final acc = <double>[0];
    for (var i = 1; i < widget.points.length; i++) {
      acc.add(acc.last + d(widget.points[i - 1], widget.points[i]));
    }
    return acc;
  }

  // بنحسب المكان على المسار حسب المسافة مش حسب عدد النقط، عشان السرعة تبقى ثابتة
  (LatLng, double) _positionAt(double t) {
    final pts = widget.points;
    final target = _cumulative.last * t;
    var i = 1;
    while (i < _cumulative.length - 1 && _cumulative[i] < target) {
      i++;
    }
    final a = pts[i - 1], b = pts[i];
    final seg = _cumulative[i] - _cumulative[i - 1];
    final f = seg == 0 ? 0.0 : (target - _cumulative[i - 1]) / seg;
    final pos = LatLng(
      a.latitude + (b.latitude - a.latitude) * f,
      a.longitude + (b.longitude - a.longitude) * f,
    );
    final angle = math.atan2(b.longitude - a.longitude, b.latitude - a.latitude);
    return (pos, angle);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.points.length < 2) return const SizedBox.shrink();
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, _) {
        final (pos, angle) = _positionAt(_ctrl.value);
        // أيقونة الـ navigation أصلا باصة لفوق (الشمال) فالزاوية مظبوطة على طول
        return MarkerLayer(markers: [MapMarkers.heading(pos, angle)]);
      },
    );
  }
}
