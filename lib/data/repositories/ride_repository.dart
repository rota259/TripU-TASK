import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';

import '../mock/mock_data.dart';
import '../models/ride_models.dart';

// fake api: بيرجع mock بعد delay صغير عشان الـ loading states تبان
// المسارات نفسها حقيقية على شوارع القاهرة (متخزنة في assets/mock/routes.json)
class RideRepository {
  Map<String, dynamic>? _routesJson;

  Future<Map<String, dynamic>> _loadRoutes() async {
    return _routesJson ??= json.decode(
      await rootBundle.loadString('assets/mock/routes.json'),
    ) as Map<String, dynamic>;
  }

  Future<TripRoute> _route(String key, String from, String to) async {
    final raw = (await _loadRoutes())[key] as Map<String, dynamic>;
    final points = (raw['points'] as List)
        .map((p) => LatLng((p[0] as num).toDouble(), (p[1] as num).toDouble()))
        .toList();
    return TripRoute(
      pickupKey: from,
      destinationKey: to,
      points: points,
      distanceKm: (raw['distanceKm'] as num).toDouble(),
      minutes: raw['minutes'] as int,
    );
  }

  Future<TripRoute> passengerRoute() =>
      _route('passenger', 'place_ezz_el_arab', 'place_ain_shams');

  Future<List<DriverOffer>> fetchOffers() async {
    await Future.delayed(const Duration(milliseconds: 1400));
    return MockData.offers;
  }

  Future<List<RideRequest>> fetchRequests() async {
    await Future.delayed(const Duration(milliseconds: 900));
    final result = <RideRequest>[];
    for (final e in MockData.requests.entries) {
      final r = e.value;
      result.add(RideRequest(
        id: r.id,
        passengerKey: r.passenger,
        rating: r.rating,
        trips: r.trips,
        fare: r.fare,
        etaMinutes: r.eta,
        route: await _route(e.key, r.from, r.to),
      ));
    }
    return result;
  }

  /// الراكب "بيوافق" دايمًا بعد 3 ثواني، مجرد simulation
  Future<bool> sendOffer(int fare) async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }

  // عربيات في دايرة حوالين نقطة الركوب (مش فوقها)، والـ seed ثابت عشان الشكل مايتغيرش
  List<LatLng> nearbyCars(LatLng around, {int count = 5}) {
    final rnd = Random(7);
    return List.generate(count, (i) {
      final angle = i * 2 * pi / count + rnd.nextDouble() * .8;
      final r = .004 + rnd.nextDouble() * .005;
      return LatLng(around.latitude + r * sin(angle), around.longitude + r * cos(angle));
    });
  }
}
