import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:boat_charge_planner/presentation/widgets/carbon_intensity/carbon_intensity_card.dart';
import 'package:boat_charge_planner/presentation/widgets/carbon_intensity/carbon_intensity_status_alert.dart';
import 'package:flutter/material.dart';

class CarbonIntensitySection extends StatefulWidget {
  final String title;
  final Future<List<CarbonIntensity>> carbonIntensity;

  const CarbonIntensitySection({
    super.key,
    required this.title,
    required this.carbonIntensity,
  });

  @override
  State<CarbonIntensitySection> createState() => _CarbonIntensitySectionState();
}

class _CarbonIntensitySectionState extends State<CarbonIntensitySection> {
  bool _showBestChargeTime = false;

  int _findBestChargeTimeIndex(List<CarbonIntensity> data) {
    final lowestCarbonIntensity = data.fold<CarbonIntensity>(
      data.first,
      (prev, curr) =>
          curr.intensity.forecast < prev.intensity.forecast ? curr : prev,
    );
    return data.indexOf(lowestCarbonIntensity);
  }

  int _findWorstChargeTimeIndex(List<CarbonIntensity> data) {
    final higehstCarbonIntensity = data.fold<CarbonIntensity>(
      data.first,
      (prev, curr) =>
          curr.intensity.forecast > prev.intensity.forecast ? curr : prev,
    );
    return data.indexOf(higehstCarbonIntensity);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            FilterChip(
              selected: _showBestChargeTime,
              onSelected: (selected) {
                setState(() {
                  _showBestChargeTime = selected;
                });
              },
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text("Show Best")],
              ),
              selectedColor: Colors.green.shade100,
              checkmarkColor: Colors.green.shade700,
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: FutureBuilder<List<CarbonIntensity>>(
            future: widget.carbonIntensity,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const CarbonIntensityStatusAlert(
                  status: Status.error,
                  message: 'Error loading carbon intensity data',
                );
              }

              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final data = snapshot.data!;
                final bestChargeTimeIndex = _findBestChargeTimeIndex(data);
                final worstChargeTimeIndex = _findWorstChargeTimeIndex(data);

                final filteredData = _showBestChargeTime
                    ? [data[bestChargeTimeIndex]]
                    : data;

                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final item = filteredData[index];
                    return CarbonIntensityCard(
                      carbonIntensity: item,
                      isBestChargeTime: item == data[bestChargeTimeIndex],
                      isWorstChargeTime: item == data[worstChargeTimeIndex],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                );
              }

              return const CarbonIntensityStatusAlert(
                status: Status.warning,
                message: 'No carbon intensity data available',
              );
            },
          ),
        ),
      ],
    );
  }
}
