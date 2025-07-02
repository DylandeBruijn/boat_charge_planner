import 'package:boat_charge_planner/data/models/carbon_intensity.dart';
import 'package:boat_charge_planner/data/repositories/carbon_intensity_repository.dart';
import 'package:boat_charge_planner/presentation/widgets/custom_app_bar.dart';
import 'package:boat_charge_planner/presentation/widgets/map.dart';
import 'package:boat_charge_planner/presentation/widgets/marker_dialog.dart';
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
    final markerCarbonIntensity = await CarbonIntensityApiRepository()
        .getTodaysCarbonIntensity();

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          onTap: () =>
              _showMarkerDialog(markerId, markerNumber, markerCarbonIntensity),
        ),
      );
    });
  }

  void _removeMarker(String markerId) {
    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == markerId);
    });
  }

  void _showMarkerDialog(
    String markerId,
    int markerNumber,
    List<CarbonIntensity> carbonIntensity,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MarkerDialog(
          markerNumber: markerNumber,
          markerId: markerId,
          carbonIntensity: carbonIntensity,
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
      appBar: const CustomAppBar(),
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
