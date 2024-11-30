// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:m_n_m_rider/commons/app_colors.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// final locationProvider = Provider<LocationService>((ref) => LocationService());

// class LocationService {
//   late IO.Socket socket;

//   Future<void> initSocket() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     final authToken = sharedPreferences.getString('token');
//     print(authToken);
//     if (authToken == null || authToken.isEmpty) {
//       print('Auth token is missing');
//       return;
//     }

//     socket = IO.io(AppColors.baseUrl, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//       'auth': {
//         'token': authToken,
//       },
//     });

//     socket.onConnect((_) => print('Connected to server'));
//     socket.onDisconnect((_) => print('Disconnected from server'));
//   }

//   Future<void> startLocationUpdates() async {
//     // Request permissions
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       print('Location permissions are denied');
//       return;
//     }

//     // Ensure location services are enabled
//     bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!isLocationServiceEnabled) {
//       print('Location services are disabled');
//       return;
//     }

//     // Initialize socket
//     await initSocket();

//     // Start streaming location updates
//     Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
//     ).listen((position) {
//       final locationData = {
//         'latitude': position.latitude,
//         'longitude': position.longitude,
//       };
//       socket.emit('connection', locationData);
//       print('Location sent: $locationData');
//     });
//   }

//   void dispose() {
//     socket.dispose();
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:m_n_m_rider/screens/new_screens/swipe_to_confirm.dart';
import 'package:m_n_m_rider/utils/providers/incoming_order_provider_bool.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../commons/app_colors.dart';

final locationProvider =
    Provider<LocationService>((ref) => LocationService(ref));

class LocationService {
  late IO.Socket socket;
  Ref ref;
  LocationService(this.ref);
  Future<void> initSocket() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final authToken =
        sharedPreferences.getString('token'); // Retrieve the token

    if (authToken == null) {
      print("No token found");
      return;
    }
    final decodedToken = JwtDecoder.decode(authToken);
    // Initialize the socket connection with the token
    socket = IO.io(
      AppColors.url, // Replace with your backend URL
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'auth': {
          'token': authToken, // Pass token via `auth`
        },
      },
    );

    // Handle connection and disconnection
    socket.onConnect((_) => print('Connected to server'));
    socket.onDisconnect((_) => print('Disconnected from server'));
    socket.on('error', (data) => print('Socket error: $data'));

    socket.on('riderOrder', (data) {
      ref.read(incomingOrderProvider.notifier).setIncomingOrder();

      print('New Order Received: $data');
      // You can handle the data here, such as updating UI or state
    });
  }

  Future<void> startLocationUpdates() async {
    await initSocket();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final authToken =
        sharedPreferences.getString('token'); // Retrieve the token

    if (authToken == null) {
      print("No token found");
      return;
    }
    final decodedToken = JwtDecoder.decode(authToken);
    print(decodedToken['_id']);
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((position) {
      final locationData = {
        'userId': decodedToken['_id'],
        'latitude': position.latitude,
        'longitude': position.longitude,
      };
      if (socket.connected) {
        socket.emit(
            'currentDriverLocation', locationData); // Emit location updates

        // socket.emit('riderOrder', (data) {
        //   // print(data);
        //   // print('New  Order: ${data['order']}');
        // });
        print('Location sent: $locationData');
      } else {
        print('Socket is not connected');
      }
    });
  }

  void dispose() {
    socket.dispose();
  }
}



// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
//     as bg;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:m_n_m_rider/commons/app_colors.dart';

// final locationProvider = Provider<LocationService>((ref) => LocationService());

// class LocationService {
//   late IO.Socket socket;

//   Future<void> initSocket() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     final authToken = sharedPreferences.getString('token');

//     if (authToken == null || authToken.isEmpty) {
//       print('Auth token is missing');
//       return;
//     }

//     socket = IO.io(AppColors.baseUrl, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//       'extraHeaders': {
//         'Authorization': 'Bearer $authToken',
//       },
//     });

//     socket.onConnect((_) => print('Connected to server'));
//     socket.onDisconnect((_) => print('Disconnected from server'));
//   }

//   Future<void> startLocationUpdates() async {
//     // Initialize the socket connection
//     await initSocket();

//     // Configure BackgroundGeolocation
//     bg.BackgroundGeolocation.onLocation((bg.Location location) {
//       // Send location to the server
//       final locationData = {
//         'latitude': location.coords.latitude,
//         'longitude': location.coords.longitude,
//       };
//       socket.emit('locationUpdate', locationData);
//       print('Location sent: $locationData');
//     });

//     bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
//       if (!event.enabled) {
//         print('Location provider is disabled');
//       }
//     });

//     bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
//       print('[onMotionChange] location: ${location.coords}');
//     });

//     // Set up the configuration
//     await bg.BackgroundGeolocation.ready(bg.Config(
//       desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
//       distanceFilter: 10.0, // Minimum distance for updates (meters)
//       stopOnTerminate: false, // Continue tracking after app termination
//       startOnBoot: true, // Start tracking after device reboot
//       notification: bg.Notification(
//         title: "Tracking Location",
//         text: "Your location is being tracked in the background.",
//       ),
//       debug: false, // Set to true for debug notifications
//     ));

//     // Start tracking
//     await bg.BackgroundGeolocation.start();
//     print('Background location tracking started');
//   }

//   void stopLocationUpdates() {
//     bg.BackgroundGeolocation.stop();
//     socket.dispose();
//     print('Background location tracking stopped');
//   }
// }
