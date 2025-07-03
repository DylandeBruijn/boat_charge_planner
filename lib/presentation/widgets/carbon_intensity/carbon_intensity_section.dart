import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:boat_charge_planner/presentation/widgets/carbon_intensity/carbon_intensity_card.dart';
import 'package:boat_charge_planner/presentation/widgets/carbon_intensity/carbon_intensity_empty_warning.dart';
import 'package:flutter/material.dart';

class CarbonIntensitySection extends StatelessWidget {
  final String? title;
  final List<CarbonIntensity> carbonIntensity;

  const CarbonIntensitySection({
    super.key,
    this.title,
    required this.carbonIntensity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (carbonIntensity.isNotEmpty) ...[
          CarbonIntensityCard(carbonIntensity: carbonIntensity),
          const SizedBox(height: 8),
        ] else
          const CarbonIntensityEmptyWarning(),
      ],
    );
  }
}
