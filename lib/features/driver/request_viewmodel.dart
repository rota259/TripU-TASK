import 'package:flutter/foundation.dart';

import '../../data/models/ride_models.dart';
import '../../data/repositories/ride_repository.dart';

enum OfferStatus { idle, waiting, accepted }

// state الطلب الواحد من أول ما السواق يفتحه لحد ما الراكب يوافق
// بيتشارك بين شاشة التفاصيل والـ keypad وشاشة الانتظار
class RequestViewModel extends ChangeNotifier {
  RequestViewModel(this._repo, this.request) : offeredFare = request.fare;

  final RideRepository _repo;
  final RideRequest request;

  int offeredFare;
  String _input = '';
  OfferStatus status = OfferStatus.idle;

  // نفس فكرة الديزاين: 3 اختيارات جاهزة أعلى من سعر الراكب
  List<int> get quickFares => [for (final add in [5, 10, 15]) request.fare + add];

  int get keypadFare => _input.isEmpty ? offeredFare : int.parse(_input);
  bool get hasInput => _input.isNotEmpty;

  void pickFare(int value) {
    offeredFare = value;
    _input = '';
    notifyListeners();
  }

  void startEditing() {
    _input = '';
    notifyListeners();
  }

  void typeDigit(String d) {
    if (_input.length >= 4 || (_input.isEmpty && d == '0')) return;
    _input += d;
    notifyListeners();
  }

  void backspace() {
    if (_input.isEmpty) return;
    _input = _input.substring(0, _input.length - 1);
    notifyListeners();
  }

  Future<void> sendOffer() async {
    offeredFare = keypadFare;
    status = OfferStatus.waiting;
    notifyListeners();
    final ok = await _repo.sendOffer(offeredFare);
    if (status != OfferStatus.waiting) return; // السواق لغى قبل الرد
    status = ok ? OfferStatus.accepted : OfferStatus.idle;
    notifyListeners();
  }

  void cancelOffer() {
    status = OfferStatus.idle;
    notifyListeners();
  }
}
