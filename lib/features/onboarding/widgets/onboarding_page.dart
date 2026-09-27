import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../data/models/user_models.dart';
import '../../../shared/widgets/fade_slide_in.dart';

// صفحة زي الديزاين: عنوان + وصف فوق، والرسمة واخدة عرض الشاشة تحت
// الرسمة بتتحرك أسرع من الكلام وقت السحب (parallax) وبتطفو بهدوء
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
    required this.slide,
    required this.index,
    required this.controller,
  });

  final OnboardingSlide slide;
  final int index;
  final PageController controller;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late final _float = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 4),
  )..repeat();

  @override
  void dispose() {
    _float.dispose();
    super.dispose();
  }

  // بعد الصفحة عن النص (-1 .. 1)
  double get _offset {
    final c = widget.controller;
    if (!c.hasClients || !c.position.haveDimensions) return 0;
    return (c.page ?? 0) - widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final white70 = context.texts.bodySmall?.copyWith(color: Colors.white70, height: 1.6);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 24, 70, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FadeSlideIn(
            child: Text(
              context.tr(widget.slide.titleKey),
              style: context.texts.headlineMedium?.copyWith(color: Colors.white, fontSize: 24),
            ),
          ),
          const SizedBox(height: 10),
          FadeSlideIn(index: 2, child: Text(context.tr(widget.slide.bodyKey), style: white70)),
        ]),
      ),
      Expanded(
        child: AnimatedBuilder(
          animation: Listenable.merge([widget.controller, _float]),
          builder: (context, child) {
            final w = MediaQuery.sizeOf(context).width;
            final bob = math.sin(_float.value * 2 * math.pi) * 5;
            return Transform.translate(
              // الرسمة بتتسحب 40% أكتر من الصفحة نفسها
              offset: Offset(-_offset * w * .4, bob),
              child: Opacity(opacity: (1 - _offset.abs()).clamp(0, 1), child: child),
            );
          },
          child: FadeSlideIn(
            index: 1,
            dy: .08,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(widget.slide.image, width: double.infinity, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    ]);
  }
}
