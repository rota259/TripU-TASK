import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../shared/widgets/common.dart';
import '../../../shared/widgets/primary_button.dart';
import '../request_viewmodel.dart';
import 'fare_chips.dart';
import 'trip_info_card.dart';

class RequestDetailCard extends StatelessWidget {
  const RequestDetailCard({
    super.key,
    required this.vm,
    required this.onAccept,
    required this.onQuickOffer,
    required this.onEditFare,
    required this.onSkip,
  });

  final RequestViewModel vm;
  final VoidCallback onAccept;
  final ValueChanged<int> onQuickOffer;
  final VoidCallback onEditFare;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TripInfoCard(request: vm.request),
        const SizedBox(height: 16),
        PrimaryButton(
          label: context.tr('accept_for', {'fare': context.money(vm.request.fare)}),
          onPressed: onAccept,
        ),
        SectionHeader(context.tr('offer_your_fare')),
        FareChips(values: vm.quickFares, onSelect: onQuickOffer, onEdit: onEditFare),
        const SizedBox(height: 12),
        PrimaryButton(
          label: context.tr('skip'),
          type: ButtonStyleType.outlined,
          onPressed: onSkip,
        ),
      ],
    );
  }
}
