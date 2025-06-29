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
  final Set<Marker> _markers = {};

  final LatLng _center = const LatLng(54.0, -2.0);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onMapLongPressed(LatLng position) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_${_markers.length}'),
          position: position,
          infoWindow: InfoWindow(
            title: 'Charge Point ${_markers.length + 1}',
            snippet:
                'Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}',
          ),
        ),
      );
    });
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
          onLongPress: _onMapLongPressed,
          markers: _markers,
          initialCameraPosition: CameraPosition(target: _center, zoom: 6.0),
        ),
      ),
    );
  }
}
