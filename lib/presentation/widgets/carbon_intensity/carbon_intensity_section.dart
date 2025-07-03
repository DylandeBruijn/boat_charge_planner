import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:boat_charge_planner/presentation/widgets/carbon_intensity/carbon_intensity_card.dart';
import 'package:boat_charge_planner/presentation/widgets/carbon_intensity/carbon_intensity_empty_warning.dart';
import 'package:flutter/material.dart';

class CarbonIntensitySection extends StatelessWidget {
  final String? title;
  final Future<List<CarbonIntensity>> carbonIntensity;

  const CarbonIntensitySection({
    super.key,
    this.title,
    required this.carbonIntensity,
  });

  int _findBestChargeTimeIndex(List<CarbonIntensity> data) {
    final lowestIntensity = data.fold<CarbonIntensity>(
      data.first,
      (prev, curr) =>
          curr.intensity.forecast < prev.intensity.forecast ? curr : prev,
    );
    return data.indexOf(lowestIntensity);
  }

  int _findWorstChargeTimeIndex(List<CarbonIntensity> data) {
    final highestIntensity = data.fold<CarbonIntensity>(
      data.first,
      (prev, curr) =>
          curr.intensity.forecast > prev.intensity.forecast ? curr : prev,
    );
    return data.indexOf(highestIntensity);
  }

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
        SizedBox(
          height: 160,
          child: FutureBuilder<List<CarbonIntensity>>(
            future: carbonIntensity,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final data = snapshot.data!;
                final bestChargeTimeIndex = _findBestChargeTimeIndex(data);
                final worstChargeTimeIndex = _findWorstChargeTimeIndex(data);

                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, index) => CarbonIntensityCard(
                    carbonIntensity: data[index],
                    isBestChargeTime: index == bestChargeTimeIndex,
                    isWorstChargeTime: index == worstChargeTimeIndex,
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                );
              } else if (snapshot.hasError) {
                return const CarbonIntensityEmptyWarning();
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
