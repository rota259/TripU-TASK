import 'package:flutter_test/flutter_test.dart';
import 'package:tripu/features/passenger/passenger_home_viewmodel.dart';

import 'fakes.dart';

void main() {
  late PassengerHomeViewModel vm;

  setUp(() async {
    vm = PassengerHomeViewModel(FakeRideRepository());
    await Future<void>.delayed(Duration.zero); // استنى الـ init
  });

  test('loads the route and nearby cars on start', () {
    expect(vm.route, isNotNull);
    expect(vm.cars, isNotEmpty);
    expect(vm.stage, BookingStage.selecting);
  });

  test('fare moves in steps of 5 and never goes under the minimum', () {
    vm.increaseFare();
    expect(vm.fare, 55);
    for (var i = 0; i < 20; i++) {
      vm.decreaseFare();
    }
    expect(vm.fare, 20);
  });

  test('goes through the booking stages in order', () async {
    vm.confirm();
    expect(vm.stage, BookingStage.confirmed);
    vm.findRide();
    expect(vm.stage, BookingStage.searching);
    await vm.raiseFareAndSearch();
    expect(vm.stage, BookingStage.offers);
    expect(vm.offers, isNotEmpty);
  });

  test('declining every offer goes back to searching', () async {
    await vm.raiseFareAndSearch();
    for (final o in List.of(vm.offers)) {
      vm.declineOffer(o);
    }
    expect(vm.stage, BookingStage.searching);
  });

  test('accepting an offer resets the flow', () async {
    await vm.raiseFareAndSearch();
    final offer = vm.acceptOffer(vm.offers.first);
    expect(offer.nameKey, isNotEmpty);
    expect(vm.stage, BookingStage.selecting);
  });
}
