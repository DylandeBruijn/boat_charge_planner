import 'package:flutter/material.dart';

class CarbonIntensityEmptyWarning extends StatelessWidget {
  const CarbonIntensityEmptyWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber, color: Colors.orange.shade900, size: 20),
          const SizedBox(width: 8),
          Text(
            'No carbon intensity data available',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.orange.shade900),
          ),
        ],
      ),
    );
  }
}
