import 'package:flutter/material.dart';

// fade + slide خفيف، واتجاه الـ slide بيتقلب لوحده في العربي
class AppRoute<T> extends PageRouteBuilder<T> {
  AppRoute(Widget page, {String? name})
      : super(
          settings: RouteSettings(name: name),
          transitionDuration: const Duration(milliseconds: 380),
          reverseTransitionDuration: const Duration(milliseconds: 280),
          pageBuilder: (_, _, _) => page,
          transitionsBuilder: (context, animation, secondary, child) {
            final curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
              reverseCurve: Curves.easeInCubic,
            );
            final rtl = Directionality.of(context) == TextDirection.rtl;
            final slide = Tween<Offset>(
              begin: Offset(rtl ? -0.15 : 0.15, 0),
              end: Offset.zero,
            ).animate(curved);
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(position: slide, child: child),
            );
          },
        );
}

extension NavX on BuildContext {
  Future<T?> push<T>(Widget page, {String? name}) =>
      Navigator.of(this).push<T>(AppRoute<T>(page, name: name));

  Future<T?> replaceWith<T>(Widget page) =>
      Navigator.of(this).pushReplacement<T, void>(AppRoute<T>(page));

  void popUntilNamed(String name) => Navigator.of(this)
      .popUntil((r) => r.settings.name == name || r.isFirst);
}
