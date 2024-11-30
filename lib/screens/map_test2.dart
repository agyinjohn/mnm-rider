// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/services.dart';

// import '../models/region_model.dart';

// class MapWithRegions extends StatefulWidget {
//   const MapWithRegions({super.key});

//   @override
//   _MapWithRegionsState createState() => _MapWithRegionsState();
// }

// class _MapWithRegionsState extends State<MapWithRegions> {
//   late GoogleMapController _mapController;
//   Map<String, dynamic>? _regionData;
//   List<Polygon> _polygons = [];
//   String? _selectedRegion;
//     List<Region> _regions = [];
//   // String? _selectedRegion;
//   // Set<Polygon> _polygons = {};
//   @override
//   void initState() {
//     super.initState();
//     _loadRegionData();
//   }

//   Future<void> _loadRegionData() async {
//     final jsonString =
//         await rootBundle.loadString('assets/images/ghana_regions.json');
//     setState(() {
//       _regionData = jsonDecode(jsonString);
//     });
//   }

//   void _onRegionSelected(String? regionName) {
//     if (regionName == null || _regionData == null) return;

//     final region = _regionData!['regions']
//         .firstWhere((region) => region['name'] == regionName);

//     final coordinates = region['coordinates'] as List;
//     final polygonPoints =
//         coordinates.map((coord) => LatLng(coord[0], coord[1])).toList();

//     setState(() {
//       _selectedRegion = regionName;
//       _polygons = [
//         Polygon(
//           polygonId: PolygonId(regionName),
//           points: polygonPoints,
//           strokeColor: Colors.red,
//           strokeWidth: 2,
//           fillColor: Colors.red.withOpacity(0.4),
//         ),
//       ];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Map with Regions')),
//       body: Column(
//         children: [
//           if (_regionData != null)
//             DropdownButton<String>(
//               value: _selectedRegion,
//               hint: const Text('Select a region'),
//               items: (_regionData!['regions'] as List)
//                   .map((region) => DropdownMenuItem<String>(
//                         value: region['name'],
//                         child: Text(region['name']),
//                       ))
//                   .toList(),
//               onChanged: _onRegionSelected,
//             ),
//           Expanded(
//             child: GoogleMap(
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(37.423, -122.084),
//                 zoom: 14,
//               ),
//               polygons: _polygons.toSet(),
//               onMapCreated: (controller) => _mapController = controller,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/region_model.dart';

// Import your Region model

class GhanaMap extends StatefulWidget {
  const GhanaMap({super.key});

  @override
  _GhanaMapState createState() => _GhanaMapState();
}

class _GhanaMapState extends State<GhanaMap> {
  GoogleMapController? _mapController;
  List<Region> _regions = [];
  String? _selectedRegion;
  Set<Polygon> _polygons = {};

  @override
  void initState() {
    super.initState();
    _loadRegions();
  }

  Future<void> _loadRegions() async {
    final jsonString =
        await rootBundle.loadString('assets/images/ghana_regions.json');
    final regions = parseRegions(jsonString);

    setState(() {
      _regions = regions;
    });
    print(regions);
  }

  _onRegionSelected(String regionName) {
    // if (regionName == null) return;
    final selectedRegion =
        _regions.firstWhere((region) => region.name == regionName);

    final polygon = Polygon(
      polygonId: PolygonId(regionName),
      points: selectedRegion.coordinates
          .map((coord) => LatLng(coord[1], coord[0]))
          .toList(),
      fillColor: Colors.orange.withOpacity(0.4),
      strokeColor: Colors.white,
      strokeWidth: 2,
    );

    setState(() {
      _polygons = {polygon};
      _selectedRegion = regionName;
    });

    // Move the map camera to the selected region
    final bounds = _calculateBounds(polygon.points);
    _mapController?.moveCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  LatLngBounds _calculateBounds(List<LatLng> points) {
    final latitudes = points.map((p) => p.latitude).toList();
    final longitudes = points.map((p) => p.longitude).toList();

    return LatLngBounds(
      southwest: LatLng(latitudes.reduce((a, b) => a < b ? a : b),
          longitudes.reduce((a, b) => a < b ? a : b)),
      northeast: LatLng(latitudes.reduce((a, b) => a > b ? a : b),
          longitudes.reduce((a, b) => a > b ? a : b)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acitive map for riders and opertions"),
      ),
      body: Column(
        children: [
          if (_regions.isNotEmpty)
            DropdownButton<String>(
              value: _selectedRegion,
              hint: const Text("Select a Region"),
              items: _regions.map((region) {
                return DropdownMenuItem(
                  value: region.name,
                  child: Text(region.name),
                );
              }).toList(),
              onChanged: (value) => _onRegionSelected(value!),
            ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(7.9465, -1.0232), // Center of Ghana
                zoom: 6,
              ),
              polygons: _polygons,
              onMapCreated: (controller) => _mapController = controller,
            ),
          ),
        ],
      ),
    );
  }
}
