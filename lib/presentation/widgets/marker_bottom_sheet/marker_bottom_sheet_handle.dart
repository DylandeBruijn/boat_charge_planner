import 'package:flutter/material.dart';

class MarkerBottomSheetHandle extends StatelessWidget {
  const MarkerBottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceDim,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
