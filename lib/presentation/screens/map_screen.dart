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
  final Map<String, MarkerData> _markersData = {};
  final Set<Marker> _markers = {};
  final LatLng _center = const LatLng(54.0, -2.0);

  void _initializeMapController(GoogleMapController controller) {
    mapController = controller;
  }

  void _createMarker(LatLng position) {
    setState(() {
      final markerId = const Uuid().v4();
      final markerData = MarkerData(
        id: markerId,
        position: position,
        title: 'Charging Point ${_markersData.length + 1}',
      );

      _markersData[markerId] = markerData;
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          onTap: () => _showMarkerModal(markerData),
        ),
      );
    });
  }

  void _showMarkerModal(MarkerData markerData) {
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
                  Row(
                    children: [
                      Text(
                        markerData.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(markerData.id),
                    ],
                  ),
                  SizedBox(height: 100),
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
                          _removeMarker(markerData.id);
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
      _markersData.remove(markerId);
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
