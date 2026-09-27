import 'package:flutter/material.dart';

import '../../core/theme/theme_x.dart';

// avatar + اسم + تقييم، بيستخدم في كروت السواق والراكب
class RatingPill extends StatelessWidget {
  const RatingPill({
    super.key,
    required this.name,
    required this.rating,
    this.subtitle,
    this.radius = 20,
  });

  final String name;
  final double rating;
  final String? subtitle;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Row(children: [
      Avatar(radius: radius),
      const SizedBox(width: 10),
      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              Flexible(child: Text(name, style: context.texts.titleMedium, overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 6),
              Icon(Icons.star_rounded, size: 16, color: c.star),
              Text(' $rating', style: context.texts.bodySmall),
            ]),
            if (subtitle != null)
              Text(subtitle!, style: context.texts.bodySmall?.copyWith(fontSize: 12)),
          ],
        ),
      ),
    ]);
  }
}

class Avatar extends StatelessWidget {
  const Avatar({super.key, this.radius = 20});

  final double radius;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return CircleAvatar(
      radius: radius,
      backgroundColor: c.primarySoft,
      child: Icon(Icons.person_rounded, color: c.primary, size: radius * 1.1),
    );
  }
}

// "من ← إلى" بأيقونة بدل حرف السهم، وبتتقلب لوحدها في الـ RTL
class RouteLine extends StatelessWidget {
  const RouteLine({super.key, required this.from, required this.to, this.style});

  final String from;
  final String to;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final s = style ?? context.texts.bodySmall;
    return Row(children: [
      Flexible(child: Text(from, style: s, overflow: TextOverflow.ellipsis)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Icon(Icons.arrow_forward_rounded, size: 14, color: context.colors.textMuted),
      ),
      Flexible(child: Text(to, style: s, overflow: TextOverflow.ellipsis)),
    ]);
  }
}
