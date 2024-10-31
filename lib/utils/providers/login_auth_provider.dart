import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../login_auth.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
