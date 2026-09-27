import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../data/models/wallet_models.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.txn});

  final WalletTransaction txn;

  Color _color(BuildContext context) => switch (txn.kind) {
        TxnKind.fawry => const Color(0xFFF7A928),
        TxnKind.card => context.colors.danger,
        TxnKind.paypal => const Color(0xFF2D9CDB),
        TxnKind.trip => context.colors.primary,
      };

  @override
  Widget build(BuildContext context) {
    final color = _color(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withValues(alpha: .14),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(txn.kind.icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(context.tr(txn.kind.labelKey), style: context.texts.titleMedium),
            Text(context.time(txn.date), style: context.texts.bodySmall?.copyWith(fontSize: 12)),
          ]),
        ),
        Text(
          '+${context.money(txn.amount)}',
          style: context.texts.titleMedium?.copyWith(color: context.colors.success),
        ),
      ]),
    );
  }
}
