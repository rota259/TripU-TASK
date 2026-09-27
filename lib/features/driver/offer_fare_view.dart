import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/theme/theme_x.dart';
import '../../shared/map/trip_map.dart';
import '../../shared/widgets/common.dart';
import '../../shared/widgets/map_panel_layout.dart';
import '../../shared/widgets/primary_button.dart';
import 'request_viewmodel.dart';
import 'waiting_view.dart';
import 'widgets/number_keypad.dart';

class OfferFareView extends StatelessWidget {
  const OfferFareView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<RequestViewModel>();
    return Scaffold(
      body: MapPanelLayout(
        map: TripMap(route: vm.request.route),
        topBar: Align(
          alignment: AlignmentDirectional.topStart,
          child: CircleIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
        panel: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(context.tr('offer_your_fare'), style: context.texts.bodySmall),
          const SizedBox(height: 4),
          // كل رقم جديد بيعمل pop صغير
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, a) => ScaleTransition(
              scale: Tween(begin: .8, end: 1.0).animate(a),
              child: FadeTransition(opacity: a, child: child),
            ),
            child: Text(
              '${vm.keypadFare}',
              key: ValueKey(vm.keypadFare),
              style: context.texts.headlineMedium?.copyWith(
                fontSize: 44,
                color: vm.hasInput ? context.colors.textPrimary : context.colors.textMuted,
              ),
            ),
          ),
          Text(
            context.tr('customer_offer', {'fare': context.money(vm.request.fare)}),
            style: context.texts.bodySmall?.copyWith(color: context.colors.primary),
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: context.tr('offer'),
            onPressed: () => WaitingView.open(context, vm, replace: true),
          ),
          const SizedBox(height: 12),
          NumberKeypad(onDigit: vm.typeDigit, onBackspace: vm.backspace),
        ]),
      ),
    );
  }
}
