import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future main() async {
  runApp(const BoatChargePlannerApp());
}

class BoatChargePlannerApp extends StatefulWidget {
  const BoatChargePlannerApp({super.key});

  @override
  State<BoatChargePlannerApp> createState() => _BoatChargePlannerAppState();
}

class _BoatChargePlannerAppState extends State<BoatChargePlannerApp> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(54.0, -2.0);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Boat Charge Planner'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(target: _center, zoom: 6.0),
        ),
      ),
    );
  }
}
