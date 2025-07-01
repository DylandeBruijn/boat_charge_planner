import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.directions_boat, color: Colors.white, size: 28),
            const SizedBox(width: 8),
            const Text(
              'Boat Charge Planner',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1e3c72), Color(0xFF2a5298), Color(0xFF4a90e2)],
            ),
          ),
        ),
        elevation: 8,
        shadowColor: Colors.black26,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        onLongPress: _onMapLongPressed,
        markers: _markers,
        initialCameraPosition: CameraPosition(target: _center, zoom: 6.0),
      ),
    );
  }
}
