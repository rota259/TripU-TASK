import 'package:flutter/material.dart';

// بيظهر الـ child بـ fade + طلعة لفوق
// index بيعمل stagger للّستات (كل عنصر يتأخر شوية عن اللي قبله)
class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.index = 0,
    this.step = const Duration(milliseconds: 70),
    this.dy = .12,
  });

  final Widget child;
  final int index;
  final Duration step;
  final double dy;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );
  late final _curve = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);

  @override
  void initState() {
    super.initState();
    // cap على الـ delay عشان لو اللستة طويلة ماتستناش كتير
    final delay = widget.step * widget.index.clamp(0, 8);
    Future.delayed(delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curve,
      child: SlideTransition(
        position: Tween(begin: Offset(0, widget.dy), end: Offset.zero)
            .animate(_curve),
        child: widget.child,
      ),
    );
  }
}
