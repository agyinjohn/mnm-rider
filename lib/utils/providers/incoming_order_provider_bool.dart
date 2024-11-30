import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier to manage the bool variable
class IncomingOrderNotifier extends StateNotifier<bool> {
  Timer? _timer;

  IncomingOrderNotifier() : super(false);

  // Method to set the order state to true and start a timer
  void setIncomingOrder() {
    state = true;

    // Cancel any existing timer
    _timer?.cancel();

    // Start a new timer to reset the state after 1 minute
    _timer = Timer(const Duration(minutes: 1), () {
      state = false; // Automatically turn off the order status
    });
  }

  // Method to manually turn off the order state
  void clearIncomingOrder() {
    _timer?.cancel(); // Cancel the timer if any
    state = false;
  }

  @override
  void dispose() {
    _timer?.cancel(); // Ensure timer is canceled when notifier is disposed
    super.dispose();
  }
}

// Riverpod provider for the IncomingOrderNotifier
final incomingOrderProvider =
    StateNotifierProvider<IncomingOrderNotifier, bool>(
  (ref) => IncomingOrderNotifier(),
);
