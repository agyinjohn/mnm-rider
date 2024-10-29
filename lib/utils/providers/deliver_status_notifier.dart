import 'package:flutter_riverpod/flutter_riverpod.dart';

// Model for a delivery
class Delivery {
  final String id;
  final String status; // 'ongoing', 'upcoming'
  final String destination;
  final String customerName;

  Delivery({
    required this.id,
    required this.status,
    required this.destination,
    required this.customerName,
  });
}

// Model for the delivery person's status and earnings
class DeliveryStatus {
  final bool isOnline;
  final double totalEarnings;
  final List<Delivery> deliveries;

  DeliveryStatus({
    required this.isOnline,
    required this.totalEarnings,
    required this.deliveries,
  });
}

// StateNotifier to manage the delivery boy's state
class DeliveryStatusNotifier extends StateNotifier<DeliveryStatus> {
  DeliveryStatusNotifier()
      : super(DeliveryStatus(
          isOnline: false,
          totalEarnings: 0.0,
          deliveries: [],
        ));

  // Toggle online/offline status
  void toggleOnlineStatus() {
    state = DeliveryStatus(
      isOnline: !state.isOnline,
      totalEarnings: state.totalEarnings,
      deliveries: state.deliveries,
    );
  }

  // Add new delivery (for demonstration)
  void addDelivery(Delivery delivery) {
    state = DeliveryStatus(
      isOnline: state.isOnline,
      totalEarnings: state.totalEarnings,
      deliveries: [...state.deliveries, delivery],
    );
  }

  // Set total earnings
  void setTotalEarnings(double earnings) {
    state = DeliveryStatus(
      isOnline: state.isOnline,
      totalEarnings: earnings,
      deliveries: state.deliveries,
    );
  }
}

// Provider for the DeliveryStatusNotifier
final deliveryStatusProvider =
    StateNotifierProvider<DeliveryStatusNotifier, DeliveryStatus>(
        (ref) => DeliveryStatusNotifier());
