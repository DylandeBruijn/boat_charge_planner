import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:boat_charge_planner/presentation/widgets/carbon_intensity/carbon_intensity_chip.dart';
import 'package:flutter/material.dart';

class CarbonIntensityCard extends StatelessWidget {
  final CarbonIntensity carbonIntensity;
  final bool isBestChargeTime;
  final bool isWorstChargeTime;

  const CarbonIntensityCard({
    super.key,
    required this.carbonIntensity,
    this.isBestChargeTime = false,
    this.isWorstChargeTime = false,
  });

  Color _getBorderColor(BuildContext context) {
    if (isBestChargeTime) {
      return Colors.green.shade600;
    } else if (isWorstChargeTime) {
      return Colors.red.shade600;
    }
    return Theme.of(context).colorScheme.surfaceContainerHigh;
  }

  Color _getBackgroundColor(BuildContext context) {
    if (isBestChargeTime) {
      return Colors.green.shade50;
    } else if (isWorstChargeTime) {
      return Colors.red.shade50;
    }
    return Theme.of(context).colorScheme.surfaceContainerLow;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        border: Border.all(color: _getBorderColor(context), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarbonIntensityChip(index: carbonIntensity.intensity.index),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                'Time:',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${carbonIntensity.from.hour.toString().padLeft(2, '0')}:${carbonIntensity.from.minute.toString().padLeft(2, '0')} - ${carbonIntensity.to.hour.toString().padLeft(2, '0')}:${carbonIntensity.to.minute.toString().padLeft(2, '0')}',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                'Forecast:',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${carbonIntensity.intensity.forecast} gCO₂/kWh',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          if (carbonIntensity.intensity.actual != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Actual:',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '${carbonIntensity.intensity.actual} gCO₂/kWh',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
