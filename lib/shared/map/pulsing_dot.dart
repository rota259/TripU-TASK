import 'package:flutter/material.dart';

import '../../core/theme/theme_x.dart';

// نقطة مكان الركوب، بتطلع منها موجة كل شوية
class PulsingDot extends StatefulWidget {
  const PulsingDot({super.key});

  @override
  State<PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot> with SingleTickerProviderStateMixin {
  late final _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = context.colors.primary;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, _) => Stack(alignment: Alignment.center, children: [
        Container(
          width: 18 + 46 * _ctrl.value,
          height: 18 + 46 * _ctrl.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withValues(alpha: .35 * (1 - _ctrl.value)),
          ),
        ),
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
        ),
      ]),
    );
  }
}
