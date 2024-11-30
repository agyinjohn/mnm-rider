import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RealTimeMap extends StatefulWidget {
  const RealTimeMap({super.key});

  @override
  _RealTimeMapState createState() => _RealTimeMapState();
}

class _RealTimeMapState extends State<RealTimeMap> {
  late GoogleMapController _mapController;
  final Location _location = Location();
  LatLng _currentLocation =
      const LatLng(37.7749, -122.4194); // Default location (San Francisco)
  final LatLng _destination =
      const LatLng(37.7849, -122.4094); // Sample destination
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _fetchRoute();
  }

  /// Initialize user's current location
  Future<void> _initializeLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final userLocation = await _location.getLocation();
    setState(() {
      _currentLocation =
          LatLng(userLocation.latitude!, userLocation.longitude!);
      _markers.add(
        Marker(
          markerId: const MarkerId("current_location"),
          position: _currentLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId("destination"),
          position: _destination,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });

    // Track the user in real-time
    _location.onLocationChanged.listen((locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          _currentLocation =
              LatLng(locationData.latitude!, locationData.longitude!);
          _updateUserLocationMarker(_currentLocation);
          _checkDeviation();
        });
      }
    });
  }

  /// Update user's marker on movement
  void _updateUserLocationMarker(LatLng newPosition) {
    _markers.removeWhere(
        (marker) => marker.markerId == const MarkerId("current_location"));
    _markers.add(
      Marker(
        markerId: const MarkerId("current_location"),
        position: newPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ),
    );
  }

  /// Fetch route from Google Directions API
  Future<void> _fetchRoute() async {
    const apiKey = "AIzaSyA2c9JnAfwmLnn98nCVHELAbLDiy8jM_cM";
    final url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_currentLocation.latitude},${_currentLocation.longitude}&destination=${_destination.latitude},${_destination.longitude}&key=$apiKey";

    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final route = data["routes"][0]["overview_polyline"]["points"];
      final points = _decodePolyline(route);

      setState(() {
        _routePoints = points;
        _polylines.add(
          Polyline(
            polylineId: const PolylineId("route"),
            points: points,
            color: Colors.blue,
            width: 5,
          ),
        );
      });
    } else {
      throw Exception("Failed to fetch route");
    }
  }

  /// Decode polyline from Google Directions API
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }

  /// Check if user is deviating from the route
  void _checkDeviation() {
    for (LatLng point in _routePoints) {
      final distance = _calculateDistance(_currentLocation, point);
      if (distance < 0.02) return; // Within 20 meters of route
    }

    // If not close to any route point, prompt user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("You are deviating from the route!")),
    );
  }

  /// Calculate distance between two points (in kilometers)
  double _calculateDistance(LatLng point1, LatLng point2) {
    const double radius = 6371; // Earth's radius in km
    final double dLat =
        (point2.latitude - point1.latitude) * (3.141592653589793 / 180.0);
    final double dLng =
        (point2.longitude - point1.longitude) * (3.141592653589793 / 180.0);

    final double a = (sin(dLat / 2) * sin(dLat / 2)) +
        cos(point1.latitude * (3.141592653589793 / 180.0)) *
            cos(point2.latitude * (3.141592653589793 / 180.0)) *
            (sin(dLng / 2) * sin(dLng / 2));

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return radius * c; // Distance in kilometers
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Real-Time Navigation")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation,
          zoom: 14,
        ),
        myLocationEnabled: true,
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
