import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:boat_charge_planner/data/repositories/carbon_intensity_repository.dart';
import 'package:boat_charge_planner/presentation/widgets/marker_bottom_sheet/marker_bottom_sheet_handle.dart';
import 'package:boat_charge_planner/presentation/widgets/marker_bottom_sheet/marker_bottom_sheet_action_buttons.dart';
import 'package:boat_charge_planner/presentation/widgets/marker_bottom_sheet/marker_bottom_sheet_header.dart';
import 'package:boat_charge_planner/presentation/widgets/carbon_intensity/carbon_intensity_section.dart';
import 'package:flutter/material.dart';

class MarkerBottomSheet extends StatefulWidget {
  final int markerNumber;
  final String markerId;
  final VoidCallback onClose;
  final VoidCallback onRemove;

  const MarkerBottomSheet({
    super.key,
    required this.markerNumber,
    required this.markerId,
    required this.onClose,
    required this.onRemove,
  });

  @override
  State<MarkerBottomSheet> createState() => _MarkerBottomSheetState();
}

class _MarkerBottomSheetState extends State<MarkerBottomSheet> {
  late Future<List<CarbonIntensity>> carbonIntensity;

  @override
  void initState() {
    super.initState();
    carbonIntensity = CarbonIntensityApiRepository().getTodaysCarbonIntensity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MarkerBottomSheetHandle(),
          const SizedBox(height: 16),
          MarkerBottomSheetHeader(
            icon: Icons.battery_charging_full,
            title: 'Charge Point ${widget.markerNumber}',
          ),
          const SizedBox(height: 16),
          CarbonIntensitySection(
            title: 'Today\'s Carbon Intensity:',
            carbonIntensity: carbonIntensity,
          ),
          const SizedBox(height: 16),
          MarkerBottomSheetActionButtons(
            onClose: widget.onClose,
            onRemove: widget.onRemove,
          ),
        ],
      ),
    );
  }
}
