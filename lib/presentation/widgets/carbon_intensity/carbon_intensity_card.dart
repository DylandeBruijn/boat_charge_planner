import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:boat_charge_planner/presentation/widgets/carbon_intensity/carbon_intensity_chip.dart';
import 'package:flutter/material.dart';

class CarbonIntensityCard extends StatelessWidget {
  final CarbonIntensity carbonIntensity;

  const CarbonIntensityCard({super.key, required this.carbonIntensity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
        ),
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
