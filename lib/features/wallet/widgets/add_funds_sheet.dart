import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../shared/widgets/pressable.dart';
import '../../../shared/widgets/primary_button.dart';

// bottom sheet بسيط لاختيار المبلغ، بيرجع المبلغ أو null لو اتقفل
class AddFundsSheet extends StatefulWidget {
  const AddFundsSheet({super.key});

  static Future<int?> show(BuildContext context) => showModalBottomSheet<int>(
        context: context,
        builder: (_) => const AddFundsSheet(),
      );

  @override
  State<AddFundsSheet> createState() => _AddFundsSheetState();
}

class _AddFundsSheetState extends State<AddFundsSheet> {
  static const _amounts = [50, 100, 200, 500];
  int _selected = 100;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(context.tr('add_funds'), style: context.texts.titleLarge),
          const SizedBox(height: 16),
          Wrap(spacing: 10, runSpacing: 10, children: [
            for (final a in _amounts)
              Pressable(
                onTap: () => setState(() => _selected = a),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    color: a == _selected ? c.primary : c.primarySoft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    context.money(a),
                    style: context.texts.titleMedium?.copyWith(
                      color: a == _selected ? Colors.white : c.primary,
                    ),
                  ),
                ),
              ),
          ]),
          const SizedBox(height: 20),
          PrimaryButton(
            label: context.tr('add_amount', {'v': context.money(_selected)}),
            onPressed: () => Navigator.pop(context, _selected),
          ),
        ]),
      ),
    );
  }
}
