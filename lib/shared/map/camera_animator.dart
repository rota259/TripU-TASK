import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// flutter_map مفيهاش animated move جاهز، فبنعمل tween على الـ center والـ zoom بنفسنا
class CameraAnimator {
  CameraAnimator(this._vsync, this._map);

  final TickerProvider _vsync;
  final MapController _map;
  AnimationController? _ctrl;

  void moveTo(
    LatLng center,
    double zoom, {
    Duration duration = const Duration(milliseconds: 900),
  }) {
    _ctrl?.dispose();
    final cam = _map.camera;
    final lat = Tween(begin: cam.center.latitude, end: center.latitude);
    final lng = Tween(begin: cam.center.longitude, end: center.longitude);
    final z = Tween(begin: cam.zoom, end: zoom);

    final ctrl = AnimationController(vsync: _vsync, duration: duration);
    final curve = CurvedAnimation(parent: ctrl, curve: Curves.easeInOutCubic);
    ctrl.addListener(() {
      _map.move(LatLng(lat.evaluate(curve), lng.evaluate(curve)), z.evaluate(curve));
    });
    _ctrl = ctrl..forward();
  }

  /// يقرّب/يبعّد لحد ما النقط كلها تبان جوه الـ padding
  void fitPoints(List<LatLng> points, EdgeInsets padding) {
    if (points.length < 2) return;
    final target = CameraFit.bounds(
      bounds: LatLngBounds.fromPoints(points),
      padding: padding,
      maxZoom: 16,
    ).fit(_map.camera);
    moveTo(target.center, target.zoom);
  }

  void dispose() => _ctrl?.dispose();
}
