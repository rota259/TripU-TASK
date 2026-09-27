import 'package:flutter/material.dart';

import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/pressable.dart';

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: c.divider),
        ),
        child: Row(children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: c.primarySoft,
            child: Icon(icon, color: c.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.texts.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: context.texts.bodySmall),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: c.textMuted),
        ]),
      ),
    );
  }
}
