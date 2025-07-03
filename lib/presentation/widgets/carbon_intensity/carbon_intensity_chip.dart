import 'package:flutter/material.dart';

class CarbonIntensityChip extends StatelessWidget {
  final String index;

  const CarbonIntensityChip({super.key, required this.index});

  Color _getIndexColor(String index) {
    switch (index.toLowerCase()) {
      case 'very low':
        return Colors.green.shade600;
      case 'low':
        return Colors.green.shade600;
      case 'moderate':
        return Colors.yellow.shade600;
      case 'high':
        return Colors.orange.shade600;
      case 'very high':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  Color _getTextColor(String index) {
    switch (index.toLowerCase()) {
      case 'very low':
      case 'low':
        return Colors.white;
      case 'moderate':
        return Colors.black;
      case 'high':
      case 'very high':
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getIndexColor(index);
    final textColor = _getTextColor(index);

    return Container(
      decoration: BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          index.toUpperCase(),
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
