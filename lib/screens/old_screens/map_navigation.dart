import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapNavigationScreen extends StatefulWidget {
  final LatLng pickupLocation;
  final LatLng deliveryLocation;

  const MapNavigationScreen(
      {super.key,
      required this.pickupLocation,
      required this.deliveryLocation});

  @override
  _MapNavigationScreenState createState() => _MapNavigationScreenState();
}

class _MapNavigationScreenState extends State<MapNavigationScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  late LatLng _currentPosition;
  late Polyline _routePolyline; // For route drawing
  bool _isMapLoading = true;

  @override
  void initState() {
    super.initState();
    _currentPosition =
        const LatLng(5.6037, -0.1870); // Example location (Accra, Ghana)
    _setMarkers();
    _drawRoute(); // Call this to create the route polyline
  }

  void _setMarkers() {
    // Adding markers for pickup and delivery locations
    _markers.add(Marker(
      markerId: const MarkerId('pickup'),
      position: widget.pickupLocation,
      infoWindow: const InfoWindow(title: "Pickup Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ));

    _markers.add(Marker(
      markerId: const MarkerId('delivery'),
      position: widget.deliveryLocation,
      infoWindow: const InfoWindow(title: "Delivery Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));
  }

  void _drawRoute() {
    // Example hardcoded route polyline between pickup and delivery
    _routePolyline = Polyline(
      polylineId: const PolylineId('route'),
      points: [widget.pickupLocation, widget.deliveryLocation],
      color: Colors.blue,
      width: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              setState(() {
                _isMapLoading = false;
              });
            },
            initialCameraPosition: CameraPosition(
              target: _currentPosition, // Rider's current location
              zoom: 14.0,
            ),
            markers: _markers,
            polylines: {_routePolyline}, // Draw the route on the map
            myLocationEnabled: true, // Show rider's current location
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
          ),
          if (_isMapLoading)
            const Center(
                child:
                    CircularProgressIndicator()), // Loading indicator while map loads
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: _buildBottomCard(), // Information card for ETA, buttons
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCard() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ETA: 15 mins', // Example ETA, could be dynamic
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Distance: 5.2 km', // Example distance
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    // Start navigation button action
                  },
                  child: const Text('Start Navigation',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
