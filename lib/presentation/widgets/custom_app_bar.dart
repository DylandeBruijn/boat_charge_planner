import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;

  const CustomAppBar({super.key, required this.title, required this.icon});

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('How to Use'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Boat Charge Planner helps you plan your boat charging stops efficiently:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.touch_app),
                title: Text(
                  'Tap and hold on the map to add a marker',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.data_usage),
                title: Text(
                  'View carbon intensity data for different regions',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.info),
                title: Text(
                  'Plan when to charge your boat',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it!'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.onPrimary, size: 32),
          const SizedBox(width: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => _showHelpDialog(context),
          icon: Icon(
            Icons.help_outline,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 24,
          ),
          tooltip: 'Help',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
