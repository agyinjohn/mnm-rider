import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RiderApp extends StatefulWidget {
  const RiderApp({super.key});

  @override
  _RiderAppState createState() => _RiderAppState();
}

class _RiderAppState extends State<RiderApp> {
  String? selectedRegion;
  Set<Polygon> activePolygons = {};
  late GoogleMapController _mapController;
  static const LatLng initialPosition = LatLng(5.614818, -0.205874); // Accra

  @override
  void initState() {
    super.initState();
  }

  /// Fetches region boundaries from Overpass API
  Future<List<LatLng>> fetchRegionBoundary(String regionName) async {
    final url =
        'https://overpass-api.de/api/interpreter?data=[out:json];relation[name="$regionName"];out geom;';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> elements = data['elements'];

      // Ensure a valid response with geometry data
      if (elements.isNotEmpty && elements[0]['geometry'] != null) {
        List<dynamic> coordinates = elements[0]['geometry'];

        return coordinates
            .map((point) => LatLng(point['lat'], point['lon']))
            .toList();
      } else {
        throw Exception("No geometry data found for region $regionName.");
      }
    } else {
      throw Exception("Failed to load region boundary for $regionName.");
    }
  }

  /// Updates the map with the polygon for the selected region
  void _updateMapWithBoundary(String regionName) async {
    try {
      // Fetch boundary coordinates
      final boundary = await fetchRegionBoundary(regionName);

      // Update the active polygon
      setState(() {
        activePolygons = {
          Polygon(
            polygonId: PolygonId(regionName),
            points: boundary,
            strokeColor: Colors.blueAccent,
            fillColor: Colors.blueAccent.withOpacity(0.3),
            strokeWidth: 3,
          ),
        };
      });

      // Adjust camera to fit the polygon bounds
      _mapController.animateCamera(CameraUpdate.newLatLngBounds(
        _getBoundsFromLatLngList(boundary),
        50, // Padding
      ));
    } catch (e) {
      print("Error fetching boundary: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load boundary for $regionName.")),
      );
    }
  }

  /// Calculates bounds for the given LatLng points
  LatLngBounds _getBoundsFromLatLngList(List<LatLng> points) {
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (var point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rider Area Selector")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButton<String>(
              hint: const Text("Select Region"),
              value: selectedRegion,
              items: const [
                "Accra",
                "Ashanti region",
                "Western Region",
              ].map((region) {
                return DropdownMenuItem(
                  value: region,
                  child: Text(region),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRegion = value;
                });
                if (value != null) {
                  _updateMapWithBoundary(value);
                }
              },
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: initialPosition,
                zoom: 10,
              ),
              polygons: activePolygons,
              onMapCreated: (controller) {
                _mapController = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}
