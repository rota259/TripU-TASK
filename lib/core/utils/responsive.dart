import 'package:flutter/material.dart';

// breakpoints بسيطة:
//  < 600 موبايل، >= 600 تابلت، >= 840 الشاشات اللي فيها خريطة بتحط الـ panel على الجنب
extension ResponsiveX on BuildContext {
  Size get screen => MediaQuery.sizeOf(this);

  bool get isTablet => screen.width >= 600;
  bool get isWide => screen.width >= 840;

  double get sidePanelWidth => 420;

  /// padding لما الخريطة تعمل fit على المسار، عشان المسار مايستخباش تحت الـ panel
  EdgeInsets get mapFitPadding {
    if (!isWide) {
      // الـ panel في الموبايل ممكن ياخد لحد ~60% من الشاشة
      return EdgeInsets.fromLTRB(48, 110, 48, screen.height * .6);
    }
    final rtl = Directionality.of(this) == TextDirection.rtl;
    final side = sidePanelWidth + 64;
    return EdgeInsets.fromLTRB(rtl ? 60 : side, 90, rtl ? side : 60, 60);
  }
}

/// بيوسّط المحتوى ويمنعه يتمط على الشاشات الكبيرة
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({super.key, required this.child, this.maxWidth = 560});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
