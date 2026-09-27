import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/fade_slide_in.dart';
import '../../../shared/widgets/primary_button.dart';

class OfflineState extends StatelessWidget {
  const OfflineState({super.key, required this.onGoOnline});

  final VoidCallback onGoOnline;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: FadeSlideIn(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: c.primarySoft,
              child: Icon(Icons.nights_stay_rounded, size: 40, color: c.primary),
            ),
            const SizedBox(height: 20),
            Text(context.tr('offline_title'), style: context.texts.titleLarge),
            const SizedBox(height: 6),
            Text(
              context.tr('offline_body'),
              textAlign: TextAlign.center,
              style: context.texts.bodySmall,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              child: PrimaryButton(label: context.tr('go_online'), onPressed: onGoOnline),
            ),
          ]),
        ),
      ),
    );
  }
}
