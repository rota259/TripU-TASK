import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../core/theme/theme_x.dart';
import '../../core/utils/responsive.dart';
import '../../data/models/ride_models.dart';
import 'camera_animator.dart';
import 'map_attribution.dart';
import 'map_markers.dart';
import 'map_style.dart';
import 'moving_car_layer.dart';

// الخريطة الأساسية (OpenStreetMap) اللي بتستخدم في كل شاشات الرحلة
class TripMap extends StatefulWidget {
  const TripMap({
    super.key,
    required this.route,
    this.showRoute = true,
    this.cars = const [],
    this.movingCar = false,
  });

  final TripRoute route;
  final bool showRoute;
  final List<LatLng> cars;
  final bool movingCar;

  @override
  State<TripMap> createState() => _TripMapState();
}

class _TripMapState extends State<TripMap> with TickerProviderStateMixin {
  final _map = MapController();
  late final _camera = CameraAnimator(this, _map);
  bool _ready = false;

  void _syncCamera() {
    if (!_ready) return;
    // من غير مسار: نخلي مكان الركوب والعربيات اللي حواليه ظاهرين فوق الـ panel
    final points = widget.showRoute
        ? widget.route.points
        : [widget.route.pickup, ...widget.cars];
    _camera.fitPoints(points, context.mapFitPadding);
  }

  @override
  void didUpdateWidget(TripMap old) {
    super.didUpdateWidget(old);
    if (old.showRoute != widget.showRoute || old.route != widget.route) {
      _syncCamera();
    }
  }

  @override
  void dispose() {
    _camera.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final r = widget.route;
    return FlutterMap(
      mapController: _map,
      options: MapOptions(
        initialCenter: r.pickup,
        initialZoom: 14.5,
        backgroundColor: c.background,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        onMapReady: () {
          _ready = true;
          _syncCamera();
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.rota.tripu',
          tileBuilder: context.isDark ? darkTileBuilder : null,
        ),
        if (widget.showRoute)
          PolylineLayer(polylines: [
            Polyline(points: r.points, strokeWidth: 7, color: c.primary.withValues(alpha: .25)),
            Polyline(points: r.points, strokeWidth: 4, color: c.primary),
          ]),
        MarkerLayer(markers: [
          if (!widget.movingCar) ...widget.cars.map(MapMarkers.car),
          if (widget.showRoute) MapMarkers.destination(r.destination),
          MapMarkers.pickup(r.pickup),
        ]),
        if (widget.movingCar) MovingCarLayer(points: r.points),
        const MapAttribution(),
      ],
    );
  }
}
