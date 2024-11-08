import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:geolocator/geolocator.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/dashboard_page.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/orders_thread/order_details_page.dart';
import 'package:m_n_m_rider/screens/new_screens/swipe_to_confirm.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBottomSheet(context);
    });
  }

  Future<void> _setCurrentLocation() async {
    LatLng currentLocation = await getCurrentLocation();
    setState(() {
      _initialPosition = currentLocation as CameraPosition;
    });
  }

  bool _isNewOrder = false;

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
                  setState(() {
                    Navigator.pop(context);
                    _isNewOrder = true;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SwipeToConfirm(
                          onConfirm: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OrderDetailPage(
                                    orderNumber: '0002',
                                    number: '0243678745',
                                    customerName: 'John Agyin',
                                  ),
                                ));
                          },
                        ),
                      ),
                    );
                  });
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
              initialCameraPosition: _initialPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
            ),
          ),
          Positioned(
            left: size.width * 0.05,
            right: size.width * 0.05,
            bottom: 0,
            child: _buildCustomButton('I\'m in Active Zone', () {
              _showBottomSheet(context);
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
