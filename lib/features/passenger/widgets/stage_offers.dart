import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../data/models/ride_models.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../../../shared/widgets/primary_button.dart';
import '../passenger_home_viewmodel.dart';
import 'driver_offer_tile.dart';

class StageOffers extends StatelessWidget {
  const StageOffers({super.key, required this.vm});

  final PassengerHomeViewModel vm;

  void _accept(BuildContext context, DriverOffer offer) {
    final accepted = vm.acceptOffer(offer);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(context.tr('ride_confirmed', {'name': context.tr(accepted.nameKey)})),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.tr('driver_offers'), style: context.texts.titleLarge),
        const SizedBox(height: 2),
        Text(context.tr('driver_offers_sub'), style: context.texts.bodySmall),
        const SizedBox(height: 14),
        // AnimatedSize عشان لما عرض يترفض الكروت اللي تحته تطلع بنعومة
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Column(children: [
            for (final (i, offer) in vm.offers.indexed)
              FadeSlideIn(
                key: ObjectKey(offer),
                index: i,
                child: DriverOfferTile(
                  offer: offer,
                  onAccept: () => _accept(context, offer),
                  onDecline: () => vm.declineOffer(offer),
                ),
              ),
          ]),
        ),
        PrimaryButton(
          label: context.tr('cancel_request'),
          type: ButtonStyleType.outlined,
          onPressed: vm.cancel,
        ),
      ],
    );
  }
}
