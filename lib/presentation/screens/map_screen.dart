import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:boat_charge_planner/data/repositories/carbon_intensity_repository.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class MarkerData {
  final String id;
  final LatLng position;
  final String title;

  MarkerData({required this.id, required this.position, required this.title});
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final LatLng _center = const LatLng(54.0, -2.0);

  void _initializeMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void _createMarker(LatLng position) async {
    final markerNumber = _markers.length + 1;
    final carbonIntensity = await CarbonIntensityApiRepository()
        .getTodaysCarbonIntensity();

    setState(() {
      final markerId = const Uuid().v4();

      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          onTap: () =>
              _showMarkerModal(markerNumber, markerId, carbonIntensity),
        ),
      );
    });
  }

  void _showMarkerModal(
    int markerNumber,
    String markerId,
    List<CarbonIntensity> carbonIntensity,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Marker $markerNumber'),
                  Text(carbonIntensity[0].toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                      SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _removeMarker(markerId);
                        },
                        child: Text('Remove'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _removeMarker(String markerId) {
    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == markerId);
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
        onMapCreated: _initializeMapController,
        onLongPress: _createMarker,
        markers: _markers,
        initialCameraPosition: CameraPosition(target: _center, zoom: 6.0),
      ),
    );
  }
}
