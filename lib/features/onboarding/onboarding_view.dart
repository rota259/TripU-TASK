import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/l10n/l10n_x.dart';
import '../../core/settings/settings_viewmodel.dart';
import '../../core/theme/theme_x.dart';
import '../../core/utils/responsive.dart';
import 'onboarding_viewmodel.dart';
import 'widgets/onboarding_footer.dart';
import 'widgets/onboarding_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _pages = PageController();

  void _next() => _pages.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => OnboardingViewModel(c.read<SettingsViewModel>()),
      child: Consumer<OnboardingViewModel>(
        builder: (context, vm, _) => Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: context.colors.heroGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: ResponsiveCenter(
                child: Column(children: [
                  _TopBar(onSkip: vm.finish, showSkip: !vm.isLast),
                  Expanded(
                    child: PageView.builder(
                      controller: _pages,
                      onPageChanged: vm.onPageChanged,
                      itemCount: vm.slides.length,
                      itemBuilder: (_, i) => OnboardingPage(slide: vm.slides[i]),
                    ),
                  ),
                  OnboardingFooter(vm: vm, onNext: _next),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onSkip, required this.showSkip});

  final VoidCallback onSkip;
  final bool showSkip;

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsViewModel>();
    final style = context.texts.bodyMedium?.copyWith(color: Colors.white70);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(children: [
        TextButton.icon(
          onPressed: settings.toggleLanguage,
          icon: const Icon(Icons.translate_rounded, size: 18, color: Colors.white70),
          label: Text(context.tr('switch_lang'), style: style),
        ),
        const Spacer(),
        AnimatedOpacity(
          opacity: showSkip ? 1 : 0,
          duration: const Duration(milliseconds: 250),
          child: TextButton(
            onPressed: showSkip ? onSkip : null,
            child: Text(context.tr('skip'), style: style),
          ),
        ),
      ]),
    );
  }
}
