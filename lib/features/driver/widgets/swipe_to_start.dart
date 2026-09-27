import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/theme_x.dart';

// "اسحب عشان تبدأ الرحلة"
// لو السحب أقل من 75% الزرار يرجع مكانه بـ animation
class SwipeToStart extends StatefulWidget {
  const SwipeToStart({super.key, required this.label, required this.onDone});

  final String label;
  final VoidCallback onDone;

  @override
  State<SwipeToStart> createState() => _SwipeToStartState();
}

class _SwipeToStartState extends State<SwipeToStart> {
  static const _knob = 52.0;
  double _dx = 0;
  bool _dragging = false;
  bool _done = false;

  void _end(double max) {
    final passed = _dx > max * .75;
    setState(() {
      _dragging = false;
      _dx = passed ? max : 0;
      _done = passed;
    });
    if (passed) {
      HapticFeedback.mediumImpact();
      Future.delayed(const Duration(milliseconds: 250), widget.onDone);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    // في العربي السحب بيبقى من اليمين للشمال
    final dir = Directionality.of(context) == TextDirection.rtl ? -1.0 : 1.0;
    return LayoutBuilder(builder: (context, box) {
      final max = box.maxWidth - _knob - 8;
      final progress = max <= 0 ? 0.0 : _dx / max;
      return Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(color: c.primary, borderRadius: BorderRadius.circular(16)),
        child: Stack(alignment: Alignment.center, children: [
          Opacity(
            opacity: (1 - progress * 1.4).clamp(0.0, 1.0),
            child: Text(widget.label, style: context.texts.labelLarge?.copyWith(color: Colors.white)),
          ),
          AnimatedPositionedDirectional(
            duration: _dragging ? Duration.zero : const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            start: 4 + _dx,
            top: 4,
            child: GestureDetector(
              onHorizontalDragStart: _done ? null : (_) => setState(() => _dragging = true),
              onHorizontalDragUpdate: _done
                  ? null
                  : (d) => setState(() => _dx = (_dx + d.delta.dx * dir).clamp(0.0, max)),
              onHorizontalDragEnd: _done ? null : (_) => _end(max),
              child: Container(
                width: _knob,
                height: _knob,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Icon(
                  _done
                      ? Icons.check_rounded
                      : (dir > 0 ? Icons.keyboard_double_arrow_right_rounded : Icons.keyboard_double_arrow_left_rounded),
                  color: c.primary,
                ),
              ),
            ),
          ),
        ]),
      );
    });
  }
}
