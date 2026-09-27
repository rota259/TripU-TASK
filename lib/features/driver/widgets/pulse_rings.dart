import 'package:flutter/material.dart';

// دواير بتكبر وتختفي ورا بعض، علامة إننا مستنيين رد
class PulseRings extends StatefulWidget {
  const PulseRings({super.key, required this.child, this.size = 200});

  final Widget child;
  final double size;

  @override
  State<PulseRings> createState() => _PulseRingsState();
}

class _PulseRingsState extends State<PulseRings> with SingleTickerProviderStateMixin {
  late final _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) => Stack(alignment: Alignment.center, children: [
          for (var i = 0; i < 3; i++) _ring((_ctrl.value + i / 3) % 1),
          child!,
        ]),
        child: widget.child,
      ),
    );
  }

  Widget _ring(double t) {
    final d = widget.size * (.35 + .65 * t);
    return Container(
      width: d,
      height: d,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: (1 - t) * .6), width: 2),
      ),
    );
  }
}
