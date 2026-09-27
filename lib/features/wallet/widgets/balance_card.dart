import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/pressable.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    required this.balance,
    required this.onAddFunds,
    this.loading = false,
  });

  final double balance;
  final VoidCallback onAddFunds;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final white = context.texts.bodyMedium?.copyWith(color: Colors.white);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(colors: c.walletGradient),
      ),
      child: Stack(children: [
        // الأشكال اللي في خلفية الكارت زي الديزاين
        PositionedDirectional(end: -30, top: -40, child: _blob(160)),
        PositionedDirectional(end: 60, bottom: -60, child: _blob(130)),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(context.tr('tripu_cash'), style: white),
              const Spacer(),
              const Icon(Icons.chevron_right_rounded, color: Colors.white),
            ]),
            const SizedBox(height: 10),
            // الرصيد بيعد لحد الرقم الجديد بدل ما يتغير مرة واحدة
            TweenAnimationBuilder<double>(
              tween: Tween(end: balance),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (_, v, _) => Text(
                context.money(v.toStringAsFixed(2)),
                style: context.texts.headlineMedium?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 14),
            Pressable(
              onTap: loading ? null : onAddFunds,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                decoration: BoxDecoration(color: c.primary, borderRadius: BorderRadius.circular(10)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  loading
                      ? const SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.add_rounded, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  Text(context.tr('add_funds'), style: white?.copyWith(fontWeight: FontWeight.w600)),
                ]),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _blob(double size) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .12),
          borderRadius: BorderRadius.circular(size * .3),
        ),
      );
}
