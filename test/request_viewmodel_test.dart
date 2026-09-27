import 'package:flutter_test/flutter_test.dart';
import 'package:tripu/features/driver/request_viewmodel.dart';

import 'fakes.dart';

void main() {
  late FakeRideRepository repo;
  late RequestViewModel vm;

  setUp(() {
    repo = FakeRideRepository();
    vm = RequestViewModel(repo, FakeRideRepository.request);
  });

  test('quick fares are above the passenger offer', () {
    expect(vm.quickFares, [55, 60, 65]);
    expect(vm.offeredFare, 50);
  });

  group('keypad', () {
    test('ignores a leading zero and caps at 4 digits', () {
      vm.startEditing();
      vm.typeDigit('0');
      expect(vm.hasInput, isFalse);
      for (final d in ['1', '2', '3', '4', '5']) {
        vm.typeDigit(d);
      }
      expect(vm.keypadFare, 1234);
    });

    test('backspace removes the last digit', () {
      vm.startEditing();
      vm.typeDigit('7');
      vm.typeDigit('5');
      vm.backspace();
      expect(vm.keypadFare, 7);
    });

    test('empty input falls back to the current fare', () {
      vm.startEditing();
      expect(vm.keypadFare, 50);
    });
  });

  test('offer becomes accepted when the passenger replies', () async {
    vm.pickFare(60);
    final sending = vm.sendOffer();
    expect(vm.status, OfferStatus.waiting);
    repo.pendingOffer!.complete(true);
    await sending;
    expect(vm.status, OfferStatus.accepted);
    expect(vm.offeredFare, 60);
  });

  test('cancelling before the reply keeps it idle', () async {
    final sending = vm.sendOffer();
    vm.cancelOffer();
    repo.pendingOffer!.complete(true);
    await sending;
    expect(vm.status, OfferStatus.idle);
  });
}
