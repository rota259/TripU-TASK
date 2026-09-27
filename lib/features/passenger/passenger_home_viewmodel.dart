import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/ride_models.dart';
import '../../data/repositories/ride_repository.dart';

// نفس ترتيب شاشات الديزاين:
// اختيار العربية والسعر -> مراجعة المسار -> مفيش سواقين (ارفع السعر) -> عروض السواقين
enum BookingStage { selecting, confirmed, searching, offers }

class PassengerHomeViewModel extends ChangeNotifier {
  PassengerHomeViewModel(this._repo) {
    _init();
  }

  final RideRepository _repo;
  final vehicles = MockData.vehicles;

  static const _fareStep = 5;
  static const _minFare = 20;

  TripRoute? route;
  List<LatLng> cars = const [];
  List<DriverOffer> offers = [];

  int vehicleIndex = 0;
  int fare = 50;
  BookingStage stage = BookingStage.selecting;
  bool loadingOffers = false;

  Future<void> _init() async {
    route = await _repo.passengerRoute();
    cars = _repo.nearbyCars(route!.pickup);
    notifyListeners();
  }

  void _go(BookingStage next) {
    stage = next;
    notifyListeners();
  }

  void selectVehicle(int i) {
    vehicleIndex = i;
    notifyListeners();
  }

  void increaseFare() => _setFare(fare + _fareStep);
  void decreaseFare() => _setFare(fare - _fareStep);

  void _setFare(int value) {
    if (value < _minFare) return;
    fare = value;
    notifyListeners();
  }

  void confirm() => _go(BookingStage.confirmed);
  void findRide() => _go(BookingStage.searching);
  void cancel() => _go(BookingStage.selecting);

  Future<void> raiseFareAndSearch() async {
    loadingOffers = true;
    notifyListeners();
    offers = List.of(await _repo.fetchOffers());
    loadingOffers = false;
    _go(BookingStage.offers);
  }

  void declineOffer(DriverOffer offer) {
    offers.remove(offer);
    // لو رفض كل العروض يرجع لشاشة رفع السعر
    offers.isEmpty ? _go(BookingStage.searching) : notifyListeners();
  }

  DriverOffer acceptOffer(DriverOffer offer) {
    _go(BookingStage.selecting);
    return offer;
  }
}
