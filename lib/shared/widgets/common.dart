import 'package:flutter/material.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/theme/theme_x.dart';
import 'pressable.dart';

// widgets صغيرة بتتكرر في أكتر من شاشة

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.label, {super.key, this.trailing});

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Row(children: [
        Text(label.toUpperCase(), style: context.texts.labelSmall),
        const Spacer(),
        ?trailing,
      ]),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({super.key, required this.icon, this.onTap, this.label});

  final IconData icon;
  final VoidCallback? onTap;
  final String? label; // لو فيه label بيتعرض بدل الأيقونة (زرار اللغة مثلا)

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: onTap,
      scale: .9,
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: c.surface,
          shape: BoxShape.circle,
          boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 12, offset: Offset(0, 4))],
        ),
        child: label != null
            ? Text(label!, style: context.texts.titleMedium?.copyWith(color: c.primary))
            : Icon(icon, color: c.textPrimary, size: 22),
      ),
    );
  }
}

class EgpBadge extends StatelessWidget {
  const EgpBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.success.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        context.tr('currency'),
        style: context.texts.labelSmall?.copyWith(color: c.success, letterSpacing: 0, fontSize: 12),
      ),
    );
  }
}

void showComingSoon(BuildContext context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(context.tr('coming_soon'))));
}
