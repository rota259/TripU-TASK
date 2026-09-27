import 'dart:async';

import 'package:latlong2/latlong.dart';
import 'package:tripu/data/mock/mock_data.dart';
import 'package:tripu/data/models/ride_models.dart';
import 'package:tripu/data/repositories/ride_repository.dart';

// نفس الـ repo بس من غير delays ومن غير assets
class FakeRideRepository extends RideRepository {
  Completer<bool>? pendingOffer;

  static const route = TripRoute(
    pickupKey: 'a',
    destinationKey: 'b',
    points: [LatLng(30.03, 31.23), LatLng(30.07, 31.28)],
    distanceKm: 9,
    minutes: 10,
  );

  static const request = RideRequest(
    id: 'r1',
    passengerKey: 'name_sara',
    rating: 4.7,
    trips: 10,
    route: route,
    fare: 50,
    etaMinutes: 5,
  );

  @override
  Future<TripRoute> passengerRoute() async => route;

  @override
  Future<List<DriverOffer>> fetchOffers() async => MockData.offers;

  @override
  Future<bool> sendOffer(int fare) {
    pendingOffer = Completer<bool>();
    return pendingOffer!.future;
  }
}
