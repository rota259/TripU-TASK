import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/pressable.dart';

// Offline / Online، الـ thumb الأزرق بيتزحلق بين الاتنين
class OnlineToggle extends StatelessWidget {
  const OnlineToggle({super.key, required this.online, required this.onChanged});

  final bool online;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: c.divider),
      ),
      child: Stack(children: [
        AnimatedAlign(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutBack,
          alignment: online ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
          child: FractionallySizedBox(
            widthFactor: .5,
            child: Container(
              decoration: BoxDecoration(
                color: online ? c.primary : c.textMuted,
                borderRadius: BorderRadius.circular(26),
              ),
            ),
          ),
        ),
        Row(children: [
          _label(context, context.tr('offline'), !online, () => onChanged(false)),
          _label(context, context.tr('online'), online, () => onChanged(true)),
        ]),
      ]),
    );
  }

  Widget _label(BuildContext context, String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: Pressable(
        onTap: onTap,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: context.texts.titleMedium!.copyWith(
              color: active ? Colors.white : context.colors.textMuted,
            ),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
