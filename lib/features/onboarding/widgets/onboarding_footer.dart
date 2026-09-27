import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../shared/widgets/primary_button.dart';
import '../onboarding_viewmodel.dart';

// نفس الديزاين: النقط + زرار Next صغير، وفي آخر صفحة زرار Sign up عريض
class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({super.key, required this.vm, required this.onNext});

  final OnboardingViewModel vm;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 8, 28, 24),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, a) => FadeTransition(
          opacity: a,
          child: ScaleTransition(scale: Tween(begin: .92, end: 1.0).animate(a), child: child),
        ),
        child: vm.isLast
            ? PrimaryButton(
                key: const ValueKey('signup'),
                label: context.tr('signup_login'),
                type: ButtonStyleType.light,
                onPressed: vm.finish,
              )
            : Row(key: const ValueKey('next'), children: [
                _Dots(count: vm.slides.length, index: vm.index),
                const Spacer(),
                SizedBox(
                  width: 110,
                  child: PrimaryButton(
                    label: context.tr('next'),
                    type: ButtonStyleType.light,
                    height: 46,
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
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsetsDirectional.only(end: 6),
          height: 7,
          width: active ? 26 : 7,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: active ? 1 : .45),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
