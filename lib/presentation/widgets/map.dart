import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatelessWidget {
  final Set<Marker> markers;
  final LatLng center;
  final double zoom;
  final Function(GoogleMapController) onMapCreated;
  final Function(LatLng) onLongPress;

  const Map({
    super.key,
    required this.markers,
    required this.center,
    required this.zoom,
    required this.onMapCreated,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: onMapCreated,
      onLongPress: onLongPress,
      markers: markers,
      initialCameraPosition: CameraPosition(target: center, zoom: zoom),
    );
  }
}
