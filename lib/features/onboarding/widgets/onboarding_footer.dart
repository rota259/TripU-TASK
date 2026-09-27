import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../shared/widgets/primary_button.dart';
import '../onboarding_viewmodel.dart';

// نفس الديزاين: النقط + زرار Next أبيض صغير، وفي آخر صفحة زرار Sign up عريض
class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({super.key, required this.vm, required this.onNext});

  final OnboardingViewModel vm;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, a) => FadeTransition(
          opacity: a,
          child: ScaleTransition(scale: Tween(begin: .9, end: 1.0).animate(a), child: child),
        ),
        child: vm.isLast
            ? PrimaryButton(
                key: const ValueKey('signup'),
                label: context.tr('signup_login'),
                type: ButtonStyleType.light,
                height: 46,
                onPressed: vm.finish,
              )
            : Row(key: const ValueKey('next'), children: [
                _Dots(count: vm.slides.length, index: vm.index),
                const Spacer(),
                SizedBox(
                  width: 76,
                  child: PrimaryButton(
                    label: context.tr('next'),
                    type: ButtonStyleType.light,
                    height: 40,
                    onPressed: onNext,
                  ),
                ),
              ]),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(count, (i) {
        final active = i == index;
        // في الديزاين النقطة الحالية شرطة باهتة والباقي نقط بيضا
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsetsDirectional.only(end: 6),
          height: 6,
          width: active ? 22 : 6,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: active ? .45 : 1),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }
}
