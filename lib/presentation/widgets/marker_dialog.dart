import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:flutter/material.dart';

class MarkerDialog extends StatelessWidget {
  final int markerNumber;
  final String markerId;
  final List<CarbonIntensity> carbonIntensity;
  final VoidCallback onClose;
  final VoidCallback onRemove;

  const MarkerDialog({
    super.key,
    required this.markerNumber,
    required this.markerId,
    required this.carbonIntensity,
    required this.onClose,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Marker $markerNumber'),
            const SizedBox(height: 16),
            if (carbonIntensity.isNotEmpty) ...[
              Text('Carbon Intensity:'),
              const SizedBox(height: 8),
              Text(
                'Forecast: ${carbonIntensity[0].intensity.forecast} gCO₂/kWh',
              ),
              if (carbonIntensity[0].intensity.actual != null)
                Text('Actual: ${carbonIntensity[0].intensity.actual} gCO₂/kWh'),
              Text('Index: ${carbonIntensity[0].intensity.index}'),
            ] else
              Text('No carbon intensity data available'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: onClose, child: const Text('Close')),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: onRemove,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Remove'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
