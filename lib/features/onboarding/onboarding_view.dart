import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/settings/settings_viewmodel.dart';
import '../../core/theme/theme_x.dart';
import '../../core/utils/responsive.dart';
import 'onboarding_viewmodel.dart';
import 'widgets/onboarding_footer.dart';
import 'widgets/onboarding_page.dart';

// نفس لون الديزاين، وفي الدارك مود بيغمق شوية
const onboardingBlue = Color(0xFF1F63EE);

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _pages = PageController();

  void _next() => _pages.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = context.isDark ? const Color(0xFF173E9E) : onboardingBlue;
    return ChangeNotifierProvider(
      create: (c) => OnboardingViewModel(c.read<SettingsViewModel>()),
      child: Consumer<OnboardingViewModel>(
        builder: (context, vm, _) => Scaffold(
          backgroundColor: bg,
          body: SafeArea(
            child: ResponsiveCenter(
              maxWidth: 480,
              child: Stack(children: [
                Column(children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pages,
                      onPageChanged: vm.onPageChanged,
                      itemCount: vm.slides.length,
                      itemBuilder: (_, i) => OnboardingPage(
                        slide: vm.slides[i],
                        index: i,
                        controller: _pages,
                      ),
                    ),
                  ),
                  OnboardingFooter(vm: vm, onNext: _next),
                ]),
                // Skip في نفس سطر العنوان زي الديزاين، وبيختفي في آخر صفحة
                PositionedDirectional(
                  top: 18,
                  end: 12,
                  child: AnimatedOpacity(
                    opacity: vm.isLast ? 0 : 1,
                    duration: const Duration(milliseconds: 250),
                    child: TextButton(
                      onPressed: vm.isLast ? null : vm.finish,
                      child: Text(
                        context.tr('skip'),
                        style: context.texts.labelLarge?.copyWith(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
