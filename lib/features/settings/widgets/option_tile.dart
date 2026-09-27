import 'package:flutter/material.dart';

import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/pressable.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: onTap,
      scale: .98,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? c.primarySoft : c.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? c.primary : c.divider, width: selected ? 1.5 : 1),
        ),
        child: Row(children: [
          Icon(icon, color: selected ? c.primary : c.textMuted),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: context.texts.titleMedium)),
          AnimatedScale(
            scale: selected ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            child: Icon(Icons.check_circle_rounded, color: c.primary),
          ),
        ]),
      ),
    );
  }
}
