import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/navigation/app_route.dart';
import '../../core/theme/theme_x.dart';
import '../../core/utils/responsive.dart';
import '../../shared/map/trip_map.dart';
import '../../shared/widgets/primary_button.dart';
import 'request_viewmodel.dart';
import 'trip_accepted_view.dart';
import 'widgets/pulse_rings.dart';
import 'widgets/trip_info_card.dart';

// "بنعرض سعرك... مستنيين رد الراكب"
class WaitingView extends StatefulWidget {
  const WaitingView({super.key});

  static void open(BuildContext context, RequestViewModel vm, {bool replace = false}) {
    vm.sendOffer();
    final page = ChangeNotifierProvider.value(value: vm, child: const WaitingView());
    replace ? context.replaceWith(page) : context.push(page);
  }

  @override
  State<WaitingView> createState() => _WaitingViewState();
}

class _WaitingViewState extends State<WaitingView> {
  late final RequestViewModel _vm = context.read<RequestViewModel>();

  @override
  void initState() {
    super.initState();
    _vm.addListener(_onStatus);
  }

  // أول ما الراكب يوافق نروح لشاشة بداية الرحلة
  void _onStatus() {
    if (_vm.status != OfferStatus.accepted || !mounted) return;
    context.replaceWith(TripAcceptedView(request: _vm.request, fare: _vm.offeredFare));
  }

  @override
  void dispose() {
    _vm.removeListener(_onStatus);
    super.dispose();
  }

  void _cancel() {
    _vm.cancelOffer();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final white = context.texts.bodyLarge?.copyWith(color: Colors.white70);
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(child: TripMap(route: _vm.request.route)),
        Positioned.fill(child: ColoredBox(color: Colors.black.withValues(alpha: .72))),
        SafeArea(
          child: ResponsiveCenter(
            maxWidth: 480,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                const Spacer(),
                PulseRings(
                  child: Icon(Icons.hourglass_top_rounded, size: 44, color: context.colors.surface),
                ),
                const SizedBox(height: 16),
                Text(context.tr('offering_fare'), style: white),
                Text(
                  context.money(_vm.offeredFare),
                  style: context.texts.headlineMedium?.copyWith(color: Colors.white, fontSize: 34),
                ),
                Text(context.tr('waiting_reply'), style: white),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TripInfoCard(request: _vm.request, fare: _vm.offeredFare),
                ),
                const SizedBox(height: 12),
                PrimaryButton(label: context.tr('cancel'), type: ButtonStyleType.light, onPressed: _cancel),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
