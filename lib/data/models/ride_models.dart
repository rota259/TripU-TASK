import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class VehicleType {
  const VehicleType({required this.id, required this.nameKey, required this.icon});

  final String id;
  final String nameKey;
  final IconData icon;
}

// pickup/destination keys بيتترجموا في الـ view، والنقط جاية من routes.json
class TripRoute {
  const TripRoute({
    required this.pickupKey,
    required this.destinationKey,
    required this.points,
    required this.distanceKm,
    required this.minutes,
  });

  final String pickupKey;
  final String destinationKey;
  final List<LatLng> points;
  final double distanceKm;
  final int minutes;

  LatLng get pickup => points.first;
  LatLng get destination => points.last;
}

class DriverOffer {
  const DriverOffer({
    required this.nameKey,
    required this.rating,
    required this.rides,
    required this.carKey,
    required this.etaMinutes,
    required this.distanceM,
    required this.fare,
  });

  final String nameKey;
  final double rating;
  final int rides;
  final String carKey;
  final int etaMinutes;
  final int distanceM;
  final int fare;
}

class RideRequest {
  const RideRequest({
    required this.id,
    required this.passengerKey,
    required this.rating,
    required this.trips,
    required this.route,
    required this.fare,
    required this.etaMinutes,
  });

  final String id;
  final String passengerKey;
  final double rating;
  final int trips;
  final TripRoute route;
  final int fare;
  final int etaMinutes;
}
