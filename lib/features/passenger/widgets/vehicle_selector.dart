import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_x.dart';
import '../../../core/theme/theme_x.dart';
import '../../../data/models/ride_models.dart';
import '../../../shared/widgets/pressable.dart';

class VehicleSelector extends StatelessWidget {
  const VehicleSelector({
    super.key,
    required this.vehicles,
    required this.selected,
    required this.onSelect,
  });

  final List<VehicleType> vehicles;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      for (var i = 0; i < vehicles.length; i++) ...[
        if (i > 0) const SizedBox(width: 12),
        Expanded(
          child: _VehicleTile(
            vehicle: vehicles[i],
            active: i == selected,
            onTap: () => onSelect(i),
          ),
        ),
      ],
    ]);
  }
}

class _VehicleTile extends StatelessWidget {
  const _VehicleTile({required this.vehicle, required this.active, required this.onTap});

  final VehicleType vehicle;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Pressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? c.primarySoft : c.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: active ? c.primary : c.divider, width: active ? 1.5 : 1),
        ),
        child: Column(children: [
          // العربية بتكبر شوية لما تتختار
          AnimatedScale(
            scale: active ? 1.15 : 1,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            child: Icon(vehicle.icon, size: 26, color: active ? c.primary : c.textMuted),
          ),
          const SizedBox(height: 4),
          Text(
            context.tr(vehicle.nameKey),
            style: context.texts.titleMedium?.copyWith(color: active ? c.primary : c.textPrimary),
          ),
        ]),
      ),
    );
  }
}
