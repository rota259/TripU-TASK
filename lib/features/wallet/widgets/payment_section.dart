import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/common.dart';
import '../../../shared/widgets/primary_button.dart';

// للراكب: طريقة الدفع
class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionHeader(context.tr('payment_method')),
      Row(children: [
        Icon(Icons.payments_rounded, color: c.success),
        const SizedBox(width: 10),
        Text(context.tr('cash'), style: context.texts.titleMedium),
        const Spacer(),
        Text(context.tr('change'), style: context.texts.bodySmall?.copyWith(color: c.primary)),
      ]),
      const SizedBox(height: 14),
      // IntrinsicWidth عشان الزرار ياخد عرض الكلام بس، في العربي والإنجليزي
      IntrinsicWidth(
        child: PrimaryButton(
          label: context.tr('add_payment_method'),
          icon: Icons.add_rounded,
          height: 44,
          onPressed: () => showComingSoon(context),
        ),
      ),
    ]);
  }
}

// للسواق: كسب النهارده بدل طريقة الدفع
class EarnedToday extends StatelessWidget {
  const EarnedToday({super.key, required this.amount});

  final int amount;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionHeader(context.tr('earned_today')),
      Row(children: [
        Icon(Icons.payments_rounded, color: c.success),
        const SizedBox(width: 10),
        TweenAnimationBuilder<int>(
          tween: IntTween(begin: 0, end: amount),
          duration: const Duration(milliseconds: 900),
          builder: (_, v, _) => Text(context.money(v), style: context.texts.titleMedium),
        ),
        const Spacer(),
        Text(context.tr('check_all'), style: context.texts.bodySmall?.copyWith(color: c.primary)),
        Icon(Icons.chevron_right_rounded, size: 18, color: c.textMuted),
      ]),
    ]);
  }
}
