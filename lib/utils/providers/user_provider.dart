// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// import '../../models/user_model.dart'; // For JSON encoding and decoding

// final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
//   return UserNotifier();
// });

// class UserNotifier extends StateNotifier<User?> {
//   UserNotifier() : super(null) {
//     loadUser(); // Load user on initialization
//   }

//   // Load user from SharedPreferences
//   Future<void> loadUser() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userJson = prefs.getString('user');
//     if (userJson != null) {
//       state = User.fromJson(jsonDecode(userJson));
//     }
//   }

//   // Save user to SharedPreferences
//   Future<void> saveUser(User user) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('user', jsonEncode(user.toJson()));
//     state = user; // Update Riverpod state
//   }

//   // Log out and clear user data
//   Future<void> logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('user');
//     state = null; // Clear Riverpod state
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = StateNotifierProvider<AuthNotifier, String?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<String?> {
  AuthNotifier() : super(null) {
    loadToken(); // Load token on initialization
  }
  bool isTokenExpired(String token) {
    return JwtDecoder.isExpired(token);
  }

  // Load token from SharedPreferences
  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Retrieve the token
    if (token != null) {
      print("token has expires:${isTokenExpired(token)}");
      if (isTokenExpired(token)) {
        state = null;
      } else {
        state = token;
      }
    }
    print(state);
  }

  // Save token to SharedPreferences
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token); // Save token to local storage
    state = token; // Update Riverpod state with token
  }

  // Clear token on logout
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Remove token from storage
    state = null; // Clear Riverpod state
  }

  // Check if user is authenticated by verifying token existence
  bool isAuthenticated() {
    return state != null;
  }
}
