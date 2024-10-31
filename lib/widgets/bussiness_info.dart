import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:permission_handler/permission_handler.dart';

import 'custom_button.dart';

class BussinessInfo extends StatefulWidget {
  const BussinessInfo({super.key, required this.onComplete});
  static const routeName = '/business-info';
  final VoidCallback onComplete;

  @override
  _BussinessInfoState createState() => _BussinessInfoState();
}

class _BussinessInfoState extends State<BussinessInfo> {
  late GoogleMapController mapController;

  // To store the user's current location
  LatLng? _currentPosition;

  // To store the selected location
  LatLng? _selectedLocation;

  // List to hold the markers
  Set<Marker> _markers = {};

  // Controllers for the form fields
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _saveBusinessInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('BusinessName', _businessNameController.text);
    sharedPreferences.setString('BusinessType', _businessTypeController.text);
    sharedPreferences.setDouble('lat', _selectedLocation!.latitude);
    sharedPreferences.setDouble('long', _selectedLocation!.longitude);
  }

  Future<void> _getCurrentLocation() async {
    // Request location permission
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    } else {
      // Handle the case where the user denied the permission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission is required')),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_currentPosition != null) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentPosition!, zoom: 15),
        ),
      );
    }
  }

  // Function to handle long press to place a pin (marker)
  void _onLongPress(LatLng position) {
    setState(() {
      _selectedLocation = position;
      _markers = {
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: 'Pinned Location',
            snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Info'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Register your business',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please fill in the details below to register your account with us.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            // Business name field
            TextField(
              controller: _businessNameController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Business name',
                prefixIcon: Icon(Icons.business),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Business type dropdown
            DropdownButtonFormField<String>(
              items: ['Retail', 'Food', 'Services', 'Technology']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                _businessTypeController.text = value!;
              },
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Business type',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Business location
            const Text(
              'Business location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Tap on the map to search for precise location'),
            const SizedBox(height: 8),
            // Map section
            SizedBox(
              height: 300,
              child: _currentPosition == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _currentPosition ??
                            const LatLng(40.712776,
                                -74.005974), // Default if location fails
                        zoom: 10.0,
                      ),
                      markers: _markers,
                      onLongPress:
                          _onLongPress, // Allow user to pin location on long press
                      myLocationEnabled: true, // Enable 'My Location' button
                    ),
            ),
            const SizedBox(height: 16),
            // Submit button
            SizedBox(
                width: double.infinity,
                child: CustomButton(
                    onTap: () {
                      if (_selectedLocation != null) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Confirm Submission'),
                              content: Text(
                                'Business Name: ${_businessNameController.text}\n'
                                'Business Type: ${_businessTypeController.text}\n'
                                'Lat: ${_selectedLocation!.latitude}, Lng: ${_selectedLocation!.longitude}',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    widget.onComplete();
                                    // Here, you can submit the data to your backend
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Submit'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please select a location on the map'),
                          ),
                        );
                      }
                    },
                    title: 'Submit business Info')),
          ],
        ),
      ),
    );
  }
}
