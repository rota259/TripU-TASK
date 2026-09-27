import 'package:flutter/material.dart';

import '../passenger_home_viewmodel.dart';
import 'stage_confirmed.dart';
import 'stage_offers.dart';
import 'stage_searching.dart';
import 'stage_selecting.dart';

// بيبدّل محتوى الـ panel حسب المرحلة بـ fade + slide خفيف
class BookingPanel extends StatelessWidget {
  const BookingPanel({super.key, required this.vm});

  final PassengerHomeViewModel vm;

  @override
  Widget build(BuildContext context) {
    final Widget body = switch (vm.stage) {
      BookingStage.selecting => StageSelecting(vm: vm),
      BookingStage.confirmed => StageConfirmed(vm: vm),
      BookingStage.searching => StageSearching(vm: vm),
      BookingStage.offers => StageOffers(vm: vm),
    };
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, .06), end: Offset.zero).animate(anim),
          child: child,
        ),
      ),
      // الـ layoutBuilder الافتراضي بيعمل Stack بـ center، ده بيخليها تبدأ من فوق
      layoutBuilder: (current, previous) => Stack(
        alignment: Alignment.topCenter,
        children: [...previous, ?current],
      ),
      child: KeyedSubtree(key: ValueKey(vm.stage), child: body),
    );
  }
}
