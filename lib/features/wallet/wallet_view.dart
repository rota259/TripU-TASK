import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/theme/theme_x.dart';
import '../../core/utils/responsive.dart';
import '../../shared/widgets/common.dart';
import '../../shared/widgets/fade_slide_in.dart';
import 'wallet_viewmodel.dart';
import 'widgets/add_funds_sheet.dart';
import 'widgets/balance_card.dart';
import 'widgets/payment_section.dart';
import 'widgets/transaction_tile.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key, this.isDriver = false});

  final bool isDriver;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => WalletViewModel(c.read(), isDriver: isDriver),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<WalletViewModel>(
          builder: (context, vm, _) => vm.loading
              ? const Center(child: CircularProgressIndicator())
              : ResponsiveCenter(child: _content(context, vm)),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, WalletViewModel vm) {
    var i = 0; // عداد للـ stagger
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      children: [
        Text(context.tr('wallet'), style: context.texts.headlineMedium?.copyWith(fontSize: 32)),
        const SizedBox(height: 16),
        FadeSlideIn(
          child: BalanceCard(
            balance: vm.balance,
            loading: vm.addingFunds,
            onAddFunds: () async {
              final amount = await AddFundsSheet.show(context);
              if (amount != null) vm.addFunds(amount);
            },
          ),
        ),
        const SizedBox(height: 8),
        FadeSlideIn(
          index: 1,
          child: vm.isDriver ? EarnedToday(amount: vm.earnedToday) : const PaymentSection(),
        ),
        const SizedBox(height: 20),
        Text(context.tr('transaction_history'), style: context.texts.titleMedium),
        for (final entry in vm.grouped.entries) ...[
          SectionHeader(_dayLabel(context, entry.key)),
          for (final t in entry.value)
            FadeSlideIn(index: 2 + i++, child: TransactionTile(txn: t)),
        ],
      ],
    );
  }

  String _dayLabel(BuildContext context, DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return day == today ? context.tr('today') : context.longDate(day);
  }
}
