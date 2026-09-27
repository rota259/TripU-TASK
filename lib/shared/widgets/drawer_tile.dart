import 'package:flutter/material.dart';

import '../../core/theme/theme_x.dart';
import 'pressable.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
    this.color,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fg = selected ? c.primary : (color ?? c.textPrimary);
    return Pressable(
      onTap: onTap,
      scale: .98,
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: selected ? c.primarySoft : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          Icon(icon, size: 22, color: fg),
          const SizedBox(width: 14),
          Text(label, style: context.texts.bodyMedium?.copyWith(color: fg, fontWeight: FontWeight.w500)),
        ]),
      ),
    );
  }
}
