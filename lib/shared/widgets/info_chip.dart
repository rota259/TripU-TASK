import 'package:flutter/material.dart';

import '../../core/theme/theme_x.dart';

class InfoChip extends StatelessWidget {
  const InfoChip({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: c.primarySoft, borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Icon(icon, size: 18, color: c.primary),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: context.texts.bodyMedium?.copyWith(color: c.primary))),
      ]),
    );
  }
}
