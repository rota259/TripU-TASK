import 'package:flutter/material.dart';

import '../models/ride_models.dart';
import '../models/user_models.dart';
import '../models/wallet_models.dart';

// كل الداتا fake لحد ما يبقى فيه backend
// الأسماء والأماكن keys بتتترجم من assets/lang
class MockData {
  MockData._();

  static const user = UserProfile(nameKey: 'name_mostafa', rating: 4.8, trips: 130);

  static const slides = [
    OnboardingSlide(
      titleKey: 'onb_title_1',
      bodyKey: 'onb_body_1',
      icon: Icons.local_taxi_rounded,
      badge: Icons.location_on_rounded,
    ),
    OnboardingSlide(
      titleKey: 'onb_title_2',
      bodyKey: 'onb_body_2',
      icon: Icons.directions_car_filled_rounded,
      badge: Icons.star_rounded,
    ),
    OnboardingSlide(
      titleKey: 'onb_title_3',
      bodyKey: 'onb_body_3',
      icon: Icons.verified_user_rounded,
      badge: Icons.lock_rounded,
    ),
  ];

  static const vehicles = [
    VehicleType(id: 'ride', nameKey: 'vehicle_ride', icon: Icons.time_to_leave_rounded),
    VehicleType(id: 'comfort', nameKey: 'vehicle_comfort', icon: Icons.airport_shuttle_rounded),
  ];

  static const offers = [
    DriverOffer(nameKey: 'name_ahmed', rating: 4.8, rides: 98, carKey: 'car_yaris', etaMinutes: 5, distanceM: 750, fare: 55),
    DriverOffer(nameKey: 'name_kareem', rating: 4.9, rides: 210, carKey: 'car_accent', etaMinutes: 6, distanceM: 900, fare: 50),
    DriverOffer(nameKey: 'name_youssef', rating: 4.7, rides: 64, carKey: 'car_elantra', etaMinutes: 8, distanceM: 1300, fare: 48),
  ];

  // route key -> بيانات الطلب، والـ route نفسه بيتقرا من routes.json
  static const requests = {
    'october': (id: 'r1', passenger: 'name_mostafa', rating: 4.8, trips: 130, fare: 30, eta: 5, from: 'place_october', to: 'place_zayed'),
    'dokki': (id: 'r2', passenger: 'name_sara', rating: 4.7, trips: 64, fare: 45, eta: 7, from: 'place_dokki', to: 'place_nasr'),
    'maadi': (id: 'r3', passenger: 'name_omar', rating: 4.9, trips: 302, fare: 38, eta: 6, from: 'place_maadi', to: 'place_downtown'),
  };

  static List<WalletTransaction> transactions() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final older = today.subtract(const Duration(days: 3));
    return [
      WalletTransaction(kind: TxnKind.fawry, date: today.add(const Duration(hours: 18)), amount: 100),
      WalletTransaction(kind: TxnKind.card, date: today.add(const Duration(hours: 10, minutes: 30)), amount: 100),
      WalletTransaction(kind: TxnKind.paypal, date: older.add(const Duration(hours: 20)), amount: 100),
      WalletTransaction(kind: TxnKind.fawry, date: older.add(const Duration(hours: 18)), amount: 100),
    ];
  }

  static List<WalletTransaction> driverTransactions() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return [
      WalletTransaction(kind: TxnKind.trip, date: today.add(const Duration(hours: 16, minutes: 20)), amount: 55),
      WalletTransaction(kind: TxnKind.trip, date: today.add(const Duration(hours: 13, minutes: 5)), amount: 95),
      WalletTransaction(kind: TxnKind.trip, date: today.add(const Duration(hours: 9, minutes: 40)), amount: 100),
      ...transactions().skip(2),
    ];
  }
}
