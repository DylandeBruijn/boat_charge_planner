import 'package:flutter/material.dart';

enum Status { error, warning }

typedef StatusStyle = ({
  Color backgroundColor,
  Color borderColor,
  Color iconColor,
  Color textColor,
  IconData icon,
});

class CarbonIntensityStatusAlert extends StatelessWidget {
  final Status status;
  final String message;

  const CarbonIntensityStatusAlert({
    super.key,
    required this.status,
    required this.message,
  });

  StatusStyle _getStatusStyle() {
    switch (status) {
      case Status.warning:
        return (
          backgroundColor: Colors.orange.shade50,
          borderColor: Colors.orange.shade200,
          iconColor: Colors.orange.shade900,
          textColor: Colors.orange.shade900,
          icon: Icons.warning_amber,
        );
      case Status.error:
        return (
          backgroundColor: Colors.red.shade50,
          borderColor: Colors.red.shade200,
          iconColor: Colors.red.shade900,
          textColor: Colors.red.shade900,
          icon: Icons.error,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: statusStyle.backgroundColor,
        border: Border.all(color: statusStyle.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(statusStyle.icon, color: statusStyle.iconColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: statusStyle.textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
