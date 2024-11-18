import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:m_n_m_rider/widgets/custom_snackbar.dart';

import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commons/app_colors.dart';
import '../models/user_model.dart';
import '../screens/new_screens/verification_page.dart';
import 'providers/user_provider.dart';

// State class to manage loading, error, and success states
class AuthState {
  final bool isLoading;
  final String? error;
  final bool loggedIn;

  AuthState({this.isLoading = false, this.error, this.loggedIn = false});

  AuthState copyWith({
    bool? isLoading,
    String? error,
    bool? loggedIn,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      loggedIn: loggedIn ?? this.loggedIn,
    );
  }
}

// State Notifier for Authentication
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  Future<bool> login(
      String id, String password, BuildContext context, WidgetRef ref) async {
    state = state.copyWith(isLoading: true, error: null);

    final url = Uri.parse('${AppColors.baseUrl}/login');

    try {
      final response = await http
          .post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': id,
          'password': password,
        }),
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException(
              'The connection has timed out, please try again');
        },
      );

      if (response.statusCode == 200) {
        // Parse the response
        final data = jsonDecode(response.body);
        print(data);
        String token = data['token'];
        Map<String, dynamic> user = data['user'];

        // Save the token and user data to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isUser', true);
        await prefs.setString('token', token);

        // User userData = User(
        //     id: user['_id'],
        //     name: user['name'],
        //     email: user['email'],
        //     phoneNumber: user['phoneNumber'],
        //     role: user['role']);
        // ref.read(userProvider.notifier).saveUser(userData);
        // print(userData.email);
        // Update state to indicate login success
        state = state.copyWith(
          isLoading: false,
          loggedIn: true,
        );
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            child: const KycVerificationScreen(),
            type: PageTransitionType.bottomToTop,
            duration: const Duration(milliseconds: 1000),
          ),
          (route) => false,
        );
        return true;
      } else if (response.statusCode == 400) {
        // Handle bad request errors
        final errorData = jsonDecode(response.body);
        print(errorData);
        state = state.copyWith(
          isLoading: false,
          error: errorData['message'],
        );
        showCustomSnackbar(context: context, message: state.error!);
        return false;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Unexpected status code ${response.statusCode}',
        );
        showCustomSnackbar(context: context, message: state.error!);
        return false;
      }
    } on TimeoutException catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'The connection has timed out, please try again',
      );
      showCustomSnackbar(context: context, message: state.error!);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Error during login: $e',
      );
      showCustomSnackbar(context: context, message: state.error!);
      // print(e);
      return false;
    }
    // finally {
    //   state = state.copyWith(
    //     isLoading: false,
    //     error: 'Error during login: ',
    //   );
    // }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
