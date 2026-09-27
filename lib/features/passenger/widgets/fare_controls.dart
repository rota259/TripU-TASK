import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/common.dart';
import '../../../shared/widgets/pressable.dart';

// لما السعر يتغير الرقم القديم يطلع لفوق والجديد يدخل من تحت (زي العداد)
class AnimatedFare extends StatelessWidget {
  const AnimatedFare({super.key, required this.fare, this.style});

  final int fare;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (child, anim) {
        final incoming = child.key == ValueKey(fare);
        final begin = Offset(0, incoming ? .5 : -.5);
        return ClipRect(
          child: SlideTransition(
            position: Tween(begin: begin, end: Offset.zero).animate(anim),
            child: FadeTransition(opacity: anim, child: child),
          ),
        );
      },
      child: Text(context.money(fare), key: ValueKey(fare), style: style),
    );
  }
}

class StepButton extends StatelessWidget {
  const StepButton({super.key, required this.icon, required this.onTap, this.size = 34});

  final IconData icon;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: onTap,
      scale: .85,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: c.primarySoft, borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, size: size * .55, color: c.primary),
      ),
    );
  }
}

// صف "اعرض سعرك" اللي في أول مرحلة
class FareRow extends StatelessWidget {
  const FareRow({super.key, required this.fare, required this.onMinus, required this.onPlus});

  final int fare;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const EgpBadge(),
      const SizedBox(width: 10),
      Expanded(child: Text(context.tr('offer_your_fare'), style: context.texts.bodyMedium)),
      StepButton(icon: Icons.remove_rounded, onTap: onMinus),
      SizedBox(
        width: 84,
        child: Center(child: AnimatedFare(fare: fare, style: context.texts.titleMedium)),
      ),
      StepButton(icon: Icons.add_rounded, onTap: onPlus),
    ]);
  }
}
