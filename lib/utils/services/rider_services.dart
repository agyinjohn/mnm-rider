// import 'package:background_locator_2/background_locator.dart';
// import 'package:background_locator_2/settings/ios_settings.dart';
// import 'package:background_locator_2/settings/locator_settings.dart';
// import 'package:m_n_m_rider/commons/app_colors.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class LocationService {
//   static late IO.Socket socket;

//   static void initSocket() {
//     socket = IO.io(AppColors.url, <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//     });

//     socket.onConnect((_) => print('Connected to server'));
//     socket.onDisconnect((_) => print('Disconnected from server'));
//   }

//   static Future<void> startService() async {
//     BackgroundLocator.initialize();
//     initSocket();

//     BackgroundLocator.registerLocationUpdate((location) {
//       final data = {
//         'latitude': location.latitude,
//         'longitude': location.longitude,
//       };
//       socket.emit('connect', data);
//       print('Location sent: $data');
//     },
//         iosSettings: const IOSSettings(
//           accuracy: LocationAccuracy.NAVIGATION,
//           distanceFilter: 10, // Send updates only if the user moves 10 meters
//         ));
//   }

//   static void stopService() {
//     BackgroundLocator.unRegisterLocationUpdate();
//     socket.dispose();
//   }
// }
