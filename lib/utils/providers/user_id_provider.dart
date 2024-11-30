import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// State provider to hold the user ID
final userIdProvider = StateProvider<String?>((ref) => null);

// Function to initialize the user ID from local storage
Future<void> initializeUserId(WidgetRef ref) async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final token = sharedPreferences.getString('token');

  if (token != null && token.isNotEmpty) {
    try {
      // Decode the JWT to extract the user ID
      final decodedToken = JwtDecoder.decode(token);
      final userId =
          decodedToken['user_id']; // Adjust key based on your JWT structure

      // Update the userIdProvider with the decoded user ID
      ref.read(userIdProvider.notifier).state = userId;
    } catch (e) {
      print('Error decoding token: $e');
    }
  } else {
    print('No token found in local storage');
  }
}
