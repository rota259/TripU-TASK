import 'package:flutter/material.dart';

import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/pressable.dart';

// 55 / 60 / 65 + زرار القلم اللي بيفتح الـ keypad
class FareChips extends StatelessWidget {
  const FareChips({
    super.key,
    required this.values,
    required this.onSelect,
    required this.onEdit,
  });

  final List<int> values;
  final ValueChanged<int> onSelect;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget box(Widget child, {bool filled = true}) => Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: filled ? c.primary : c.primarySoft,
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
    return Row(children: [
      for (final v in values) ...[
        Expanded(
          child: Pressable(
            onTap: () => onSelect(v),
            scale: .9,
            child: box(Text('$v', style: context.texts.titleMedium?.copyWith(color: Colors.white))),
          ),
        ),
        const SizedBox(width: 10),
      ],
      Pressable(
        onTap: onEdit,
        scale: .9,
        child: SizedBox(
          width: 48,
          child: box(Icon(Icons.edit_rounded, size: 20, color: c.primary), filled: false),
        ),
      ),
    ]);
  }
}
