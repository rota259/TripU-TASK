import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/navigation/app_route.dart';
import '../../data/models/ride_models.dart';
import '../../shared/map/trip_map.dart';
import '../../shared/widgets/common.dart';
import '../../shared/widgets/map_panel_layout.dart';
import 'offer_fare_view.dart';
import 'request_viewmodel.dart';
import 'trip_accepted_view.dart';
import 'waiting_view.dart';
import 'widgets/request_detail_card.dart';

class RequestDetailView extends StatelessWidget {
  const RequestDetailView({super.key, required this.request});

  final RideRequest request;

  // نفس الـ viewmodel بيتنقل للشاشات اللي بعدها عشان الـ state تفضل واحدة
  static Widget _withVm(RequestViewModel vm, Widget child) =>
      ChangeNotifierProvider.value(value: vm, child: child);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => RequestViewModel(c.read(), request),
      child: Consumer<RequestViewModel>(
        builder: (context, vm, _) => Scaffold(
          body: MapPanelLayout(
            map: TripMap(route: request.route),
            topBar: Align(
              alignment: AlignmentDirectional.topStart,
              child: CircleIconButton(
                icon: Icons.arrow_back_rounded,
                onTap: () => Navigator.pop(context),
              ),
            ),
            panel: RequestDetailCard(
              vm: vm,
              // قبول بسعر الراكب على طول
              onAccept: () => context.push(
                TripAcceptedView(request: request, fare: request.fare),
              ),
              // الاختيارات الجاهزة = عرض سعر تاني ونستنى رد الراكب
              onQuickOffer: (fare) {
                vm.pickFare(fare);
                WaitingView.open(context, vm);
              },
              onEditFare: () {
                vm.startEditing();
                context.push(_withVm(vm, const OfferFareView()));
              },
              onSkip: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
    );
  }
}
