import 'package:flutter/material.dart';

import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/pressable.dart';

// keypad زي بتاع الموبايل (الأرقام تحتها حروف زي الديزاين)
class NumberKeypad extends StatelessWidget {
  const NumberKeypad({super.key, required this.onDigit, required this.onBackspace});

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  static const _letters = {
    '2': 'ABC', '3': 'DEF', '4': 'GHI', '5': 'JKL',
    '6': 'MNO', '7': 'PQRS', '8': 'TUV', '9': 'WXYZ',
  };

  @override
  Widget build(BuildContext context) {
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '<'];
    // الـ keypad بيفضل LTR حتى في العربي، زي keypad الموبايل بالظبط
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 2.3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [for (final k in keys) _key(context, k)],
      ),
    );
  }

  Widget _key(BuildContext context, String k) {
    if (k.isEmpty) return const SizedBox.shrink();
    final c = context.colors;
    final isBack = k == '<';
    return Pressable(
      onTap: isBack ? onBackspace : () => onDigit(k),
      scale: .9,
      child: Container(
        decoration: BoxDecoration(
          color: isBack ? Colors.transparent : c.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: isBack
            ? Icon(Icons.backspace_outlined, color: c.textMuted)
            : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(k, style: context.texts.titleLarge?.copyWith(height: 1.1)),
                if (_letters[k] != null)
                  Text(_letters[k]!, style: context.texts.labelSmall?.copyWith(fontSize: 9)),
              ]),
      ),
    );
  }
}
