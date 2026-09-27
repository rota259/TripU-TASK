import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../data/models/user_models.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import 'floating_illustration.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder عشان الرسمة تصغر في الشاشات القصيرة ومتعملش overflow
    return LayoutBuilder(builder: (context, box) {
      final size = (box.maxHeight * .48).clamp(160.0, 280.0);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingIllustration(icon: slide.icon, badge: slide.badge, size: size),
            SizedBox(height: box.maxHeight * .07),
            FadeSlideIn(
              child: Text(
                context.tr(slide.titleKey),
                textAlign: TextAlign.center,
                style: context.texts.headlineMedium?.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            FadeSlideIn(
              index: 2,
              child: Text(
                context.tr(slide.bodyKey),
                textAlign: TextAlign.center,
                style: context.texts.bodyLarge?.copyWith(color: Colors.white.withValues(alpha: .85), height: 1.6),
              ),
            ),
          ],
        ),
      );
    });
  }
}
