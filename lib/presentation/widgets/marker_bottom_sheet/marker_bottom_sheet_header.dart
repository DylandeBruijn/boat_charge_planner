import 'package:flutter/material.dart';

class MarkerBottomSheetHeader extends StatelessWidget {
  final IconData? icon;
  final String title;

  const MarkerBottomSheetHeader({super.key, this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 28, color: Theme.of(context).colorScheme.onSurface),
          const SizedBox(width: 4),
        ],
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
