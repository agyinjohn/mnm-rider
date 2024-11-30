// import 'dart:ui';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:geolocator/geolocator.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/dashboard_page.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/orders_thread/order_details_page.dart';
import 'package:m_n_m_rider/screens/new_screens/swipe_to_confirm.dart';
import 'package:m_n_m_rider/widgets/alert_dialog.dart';
import 'package:m_n_m_rider/widgets/custom_snackbar.dart';

import '../../../commons/app_colors.dart';
import '../../../widgets/custom_button.dart';

// import '../bottom_navigation_bar/bottom_nav_bar.dart';
// import 'confirm_panic_mode_screen.dart';

class ActiveMapFragment extends StatefulWidget {
  const ActiveMapFragment({super.key});

  @override
  State<ActiveMapFragment> createState() => _ActiveMapFragmentState();
}

class _ActiveMapFragmentState extends State<ActiveMapFragment> {
  GoogleMapController? _controller;
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(0, 0);
  Polygon? _polygon;
  final Set<Marker> _markers = {};
  final List<LatLng> _polygonPoints = [
    const LatLng(6.624817855552845, -1.5592559427022934),
    const LatLng(6.6653878051726165, -1.5202757343649864),
    const LatLng(6.711667342584775, -1.5319094806909561),
    const LatLng(6.758078989513978, -1.5578397363424301),
    const LatLng(6.75661169168325, -1.6349267587065697),
    const LatLng(6.716492509189284, -1.659025065600872),
    const LatLng(6.7092236077089735, -1.681736335158348),
    const LatLng(6.674028338909542, -1.68003648519516),
    const LatLng(6.6504151150914685, -1.6604369133710861),
    const LatLng(6.640962247640602, -1.6326314583420753),
    const LatLng(6.638599418680993, -1.596560776233673),
    const LatLng(6.624817855552845, -1.5592559427022934),
  ];
  final bool _drawing = false;

  final LatLng _initialPosition =
      const LatLng(6.743493, -1.598324); // Default initial position

  @override
  void initState() {
    super.initState();
    _completePolygon();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet(context);
    });
  }

  // Start drawing the polygon when the user taps on the map
  void _onMapTapped(LatLng position) {
    if (_drawing) {
      setState(() {
        _polygonPoints.add(position);
        print(position);
        final isIn = _isPointInPolygon(position, _polygonPoints);
        print(isIn);
        _markers.add(
          Marker(
            markerId: MarkerId(position.toString()),
            position: position,
          ),
        );
      });
    }
  }

  bool _isPointInPolygon(LatLng point, List<LatLng> polygon) {
    int intersections = 0;
    for (int i = 0; i < polygon.length - 1; i++) {
      LatLng vertex1 = polygon[i];
      LatLng vertex2 = polygon[i + 1];

      // Check if the point's latitude is between the y-bounds of the edge
      if ((point.latitude > vertex1.latitude) !=
          (point.latitude > vertex2.latitude)) {
        // Calculate the intersection point of the edge with the ray
        double intersectLon = vertex1.longitude +
            (point.latitude - vertex1.latitude) *
                (vertex2.longitude - vertex1.longitude) /
                (vertex2.latitude - vertex1.latitude);

        // Check if the intersection point is to the right of the point
        if (point.longitude < intersectLon) {
          intersections++;
        }
      }
    }

    // If the number of intersections is odd, the point is inside
    return intersections % 2 != 0;
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  // Complete the polygon and log its area when the drawing is finished
  void _completePolygon() async {
    print('Polygon Points:');
    for (var point in _polygonPoints) {
      print('(${point.latitude}, ${point.longitude})');
    }
    if (_polygonPoints.length < 3) {
      print('A polygon requires at least 3 points.');
      return;
    }

    // Create a polygon with the points
    setState(() {
      _polygon = Polygon(
        polygonId: const PolygonId('polygon1'),
        points: _polygonPoints,
        strokeWidth: 3,
        strokeColor: Colors.blue,
        fillColor: Colors.blue.withOpacity(0.2),
      );
    });

    // Calculate the area (approximation based on the points)
    double area = _calculatePolygonArea(_polygonPoints);
    print('Polygon Area: $area square kilometers');
    await _getCurrentLocation();
  }

  // Calculate the area of the polygon (simple approximation)
  double _calculatePolygonArea(List<LatLng> points) {
    double area = 0;
    for (int i = 0; i < points.length - 1; i++) {
      area += points[i].latitude * points[i + 1].longitude;
      area -= points[i].longitude * points[i + 1].latitude;
    }
    area += points[points.length - 1].latitude * points[0].longitude;
    area -= points[points.length - 1].longitude * points[0].latitude;
    area = area.abs() / 2.0;
    // Convert area from square degrees to square kilometers (approximation)
    return area * 40008000 / 360.0; // Earth's circumference / 360 for degrees
  }

  // Handle map creation and setup camera position
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  // Getting the current location
  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return default location
      return const LatLng(6.7296388965779785, -1.6601084660966479);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return default location
        return const LatLng(6.7296388965779785, -1.6601084660966479);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, return default location
      return const LatLng(6.7296388965779785, -1.6601084660966479);
    }

    Position position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  // Default location @override void initState() { super.initState(); _setCurrentLocation(); } Future<void> _setCurrentLocation() async { LatLng currentLocation = await getCurrentLocation(); setState(() { _initialPosition = currentLocation; }); }

  final bool _isNewOrder = false;

  void _showBottomSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.06, vertical: size.height * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.cardColor,
                ),
                width: size.width * 0.54,
                height: size.height * 0.0068,
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Active Zone',
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.026),
              const Text(
                'You must be in an active zone to check in',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              _buildCustomButton(
                'Check In',
                () {
                  final isInLocation =
                      _isPointInPolygon(_currentPosition, _polygonPoints);

                  if (isInLocation) {
                    showCustomSnackbar(
                        context: context, message: 'check will be successful');
                  } else {
                    showCustomSnackbar(
                        context: context, message: 'You can\'t check in');
                  }

                  // setState(() {
                  //   Navigator.pop(context);
                  //   _isNewOrder = true;
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => SwipeToConfirm(
                  //         onConfirm: () {
                  //           showCustomAlertDialog(
                  //               context: context,
                  //               title: 'Do you want to accept this order?',
                  //               body: Row(
                  //                 children: [
                  //                   const Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.end,
                  //                     children: [
                  //                       Text('Order ID:'),
                  //                       Text('Item:'),
                  //                       Text('Pick Up Location:'),
                  //                       Text('Delivery Location:'),
                  //                     ],
                  //                   ),
                  //                   SizedBox(width: size.width * 0.04),
                  //                   const Column(
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Text('#0001'),
                  //                       Text('2x Classic..',
                  //                           overflow: TextOverflow.ellipsis),
                  //                       Text('KFC (KNUS..',
                  //                           overflow: TextOverflow.ellipsis),
                  //                       Text('Kotei (..',
                  //                           overflow: TextOverflow.ellipsis),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //               leftButtonText: 'No',
                  //               rightButtonText: 'Yes',
                  //               onTapLeft: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             const DashboardPage()));
                  //               },
                  //               onTapRight: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                       builder: (context) =>
                  //                           const OrderDetailPage(
                  //                         orderNumber: '0002',
                  //                         number: '0243678745',
                  //                         customerName: 'John Agyin',
                  //                       ),
                  //                     ));
                  //               });
                  //         },
                  //       ),
                  //     ),
                  //   );
                  // });
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Active Map',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.028),
            child: const Icon(IconlyLight.search),
          ),
        ],
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Hero(
            tag: 'mapHero',
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialPosition, zoom: 11),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              polygons: _polygon != null ? {_polygon!} : {},
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
          ),
          Positioned(
            left: size.width * 0.05,
            right: size.width * 0.05,
            bottom: 0,
            child: _buildCustomButton('I\'m in Active Zone', () {
              final isInLocation =
                  _isPointInPolygon(_currentPosition, _polygonPoints);

              if (isInLocation) {
                showCustomSnackbar(
                    context: context, message: 'check will be successful');
              } else {
                showCustomSnackbar(
                    context: context,
                    message:
                        'You can\'t check in you are not in the operation area',
                    duration: const Duration(seconds: 10));
              }
              // _showBottomSheet(context);
            }),
          ),

          // Blur effect when the bottom sheet is visible
          if (_isNewOrder)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCustomButton(String title, VoidCallback onTap) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.onPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/services.dart' show rootBundle;

// import '../../../models/region_model.dart';

// // Import your Region model

// class ActiveMapFragment extends StatefulWidget {
//   const ActiveMapFragment({super.key});

//   @override
//   _ActiveMapFragmentState createState() => _ActiveMapFragmentState();
// }

// class _ActiveMapFragmentState extends State<ActiveMapFragment> {
//   GoogleMapController? _mapController;
//   List<Region> _regions = [];
//   String? _selectedRegion;
//   Set<Polygon> _polygons = {};

//   @override
//   void initState() {
//     super.initState();
//     _loadRegions();
//   }

//   Future<void> _loadRegions() async {
//     final jsonString =
//         await rootBundle.loadString('assets/images/ghana_regions.json');
//     final regions = parseRegions(jsonString);

//     setState(() {
//       _regions = regions;
//     });
//     print(regions);
//   }

//   _onRegionSelected(String regionName) {
//     // if (regionName == null) return;
//     final selectedRegion =
//         _regions.firstWhere((region) => region.name == regionName);

//     final polygon = Polygon(
//       polygonId: PolygonId(regionName),
//       points: selectedRegion.coordinates
//           .map((coord) => LatLng(coord[1], coord[0]))
//           .toList(),
//       fillColor: Colors.orange.withOpacity(0.4),
//       strokeColor: Colors.white,
//       strokeWidth: 2,
//     );

//     setState(() {
//       _polygons = {polygon};
//       _selectedRegion = regionName;
//     });

//     // Move the map camera to the selected region
//     final bounds = _calculateBounds(polygon.points);
//     _mapController?.moveCamera(CameraUpdate.newLatLngBounds(bounds, 50));
//   }

//   LatLngBounds _calculateBounds(List<LatLng> points) {
//     final latitudes = points.map((p) => p.latitude).toList();
//     final longitudes = points.map((p) => p.longitude).toList();

//     return LatLngBounds(
//       southwest: LatLng(latitudes.reduce((a, b) => a < b ? a : b),
//           longitudes.reduce((a, b) => a < b ? a : b)),
//       northeast: LatLng(latitudes.reduce((a, b) => a > b ? a : b),
//           longitudes.reduce((a, b) => a > b ? a : b)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Acitive map for riders and opertions"),
//       ),
//       body: Column(
//         children: [
//           if (_regions.isNotEmpty)
//             DropdownButton<String>(
//               value: _selectedRegion,
//               hint: const Text("Select a Region"),
//               items: _regions.map((region) {
//                 return DropdownMenuItem(
//                   value: region.name,
//                   child: Text(region.name),
//                 );
//               }).toList(),
//               onChanged: (value) => _onRegionSelected(value!),
//             ),
//           Expanded(
//             child: GoogleMap(
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(7.9465, -1.0232), // Center of Ghana
//                 zoom: 14,
//               ),
//               polygons: _polygons,
//               onMapCreated: (controller) => _mapController = controller,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
