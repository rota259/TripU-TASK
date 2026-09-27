import 'package:flutter/material.dart';

import '../../core/theme/theme_x.dart';
import '../../core/utils/responsive.dart';

// layout كل شاشات الخريطة:
// موبايل -> الـ panel تحت زي bottom sheet
// شاشة عريضة -> الـ panel كارت على جنب والخريطة واخدة الباقي
class MapPanelLayout extends StatelessWidget {
  const MapPanelLayout({
    super.key,
    required this.map,
    required this.panel,
    this.topBar,
  });

  final Widget map;
  final Widget panel;
  final Widget? topBar;

  @override
  Widget build(BuildContext context) {
    final wide = context.isWide;
    // SizedBox.expand ضروري: الـ Scaffold بيدي الـ body ارتفاع loose، ومن غيره
    // الـ Stack بياخد ارتفاع الـ topBar بس في الشاشات العريضة
    return SizedBox.expand(child: Stack(children: [
      Positioned.fill(child: map),
      if (topBar != null)
        SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: topBar)),
      if (wide)
        PositionedDirectional(
          start: 24,
          bottom: 24,
          width: context.sidePanelWidth,
          child: _PanelCard(wide: true, child: panel),
        )
      else
        Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: context.screen.height * .66),
            child: _PanelCard(wide: false, child: panel),
          ),
        ),
    ]));
  }
}

class _PanelCard extends StatelessWidget {
  const _PanelCard({required this.wide, required this.child});

  final bool wide;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final radius = wide
        ? BorderRadius.circular(24)
        : const BorderRadius.vertical(top: Radius.circular(24));
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: radius,
        boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 24, offset: Offset(0, -4))],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          // AnimatedSize عشان لما محتوى الـ panel يتغير الطول يتغير بنعومة
          child: AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOutCubic,
            alignment: Alignment.bottomCenter,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              if (!wide)
                Container(
                  width: 44,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 14),
                  decoration: BoxDecoration(color: c.divider, borderRadius: BorderRadius.circular(3)),
                ),
              child,
            ]),
          ),
        ),
      ),
    );
  }
}
