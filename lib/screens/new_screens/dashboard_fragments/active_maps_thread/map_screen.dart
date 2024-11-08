import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:geolocator/geolocator.dart';

// import '../bottom_navigation_bar/bottom_nav_bar.dart';
// import 'confirm_panic_mode_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;

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

  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(6.7296388965779785, -1.6601084660966479),
    zoom: 16,
  ); // Default location @override void initState() { super.initState(); _setCurrentLocation(); } Future<void> _setCurrentLocation() async { LatLng currentLocation = await getCurrentLocation(); setState(() { _initialPosition = currentLocation; }); }

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  Future<void> _setCurrentLocation() async {
    LatLng currentLocation = await getCurrentLocation();
    setState(() {
      _initialPosition = currentLocation as CameraPosition;
    });
  }

  // bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(IconlyLight.arrow_left_2),
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),
        title: Text(
          'Map',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Hero(
            tag: 'mapHero',
            child: GoogleMap(
              initialCameraPosition: _initialPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
