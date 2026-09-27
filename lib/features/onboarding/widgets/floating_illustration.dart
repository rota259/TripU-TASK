import 'dart:math' as math;

import 'package:flutter/material.dart';

// رسمة الـ onboarding: دواير فوق بعض والأيقونة بتطفو لفوق وتحت
// والـ badge الصغير بيلف حواليها
class FloatingIllustration extends StatefulWidget {
  const FloatingIllustration({
    super.key,
    required this.icon,
    required this.badge,
    required this.size,
  });

  final IconData icon;
  final IconData badge;
  final double size;

  @override
  State<FloatingIllustration> createState() => _FloatingIllustrationState();
}

class _FloatingIllustrationState extends State<FloatingIllustration>
    with SingleTickerProviderStateMixin {
  late final _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _circle(double size, double alpha, [Widget? child]) => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: alpha),
        ),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final s = widget.size;
    return SizedBox.square(
      dimension: s,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, _) {
          final t = _ctrl.value * 2 * math.pi;
          final float = math.sin(t * 2) * 8;
          final orbit = s * .42;
          return Stack(alignment: Alignment.center, children: [
            _circle(s, .10),
            _circle(s * .72, .12),
            Transform.translate(
              offset: Offset(0, float),
              child: Icon(widget.icon, size: s * .42, color: Colors.white),
            ),
            Transform.translate(
              offset: Offset(math.cos(t) * orbit, math.sin(t) * orbit),
              child: _circle(
                s * .17,
                .95,
                Icon(widget.badge, size: s * .09, color: const Color(0xFF2E5BFF)),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
