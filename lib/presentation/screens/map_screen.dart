import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:boat_charge_planner/data/repositories/carbon_intensity_repository.dart';
import 'package:boat_charge_planner/presentation/widgets/custom_app_bar.dart';
import 'package:boat_charge_planner/presentation/widgets/map.dart';
import 'package:boat_charge_planner/presentation/widgets/marker_bottom_sheet/marker_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

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
    final markerId = const Uuid().v4();
    final markerNumber = _markers.length + 1;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          onTap: () => _showMarkerBottomSheet(markerId, markerNumber),
        ),
      );
    });
  }

  void _removeMarker(String markerId) {
    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == markerId);
    });
  }

  void _showMarkerBottomSheet(String markerId, int markerNumber) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return MarkerBottomSheet(
          markerNumber: markerNumber,
          markerId: markerId,
          onClose: () => Navigator.of(context).pop(),
          onRemove: () {
            Navigator.of(context).pop();
            _removeMarker(markerId);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Boat Charge Planner',
        icon: Icons.directions_boat,
      ),
      body: Map(
        markers: _markers,
        center: _center,
        onMapCreated: _initializeMapController,
        onLongPress: _createMarker,
        zoom: 6.0,
      ),
    );
  }
}
