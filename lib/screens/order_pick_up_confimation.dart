import 'package:flutter/material.dart';

class OrderPickupConfirmationScreen extends StatelessWidget {
  final String orderId;
  final String storeName;
  final List<String> orderItems;
  final String customerName;
  final String customerAddress;

  const OrderPickupConfirmationScreen({
    super.key,
    required this.orderId,
    required this.storeName,
    required this.orderItems,
    required this.customerName,
    required this.customerAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Confirm Pickup', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #$orderId',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildStoreDetails(),
            const SizedBox(height: 16),
            _buildOrderDetails(),
            const SizedBox(height: 16),
            _buildCustomerDetails(),
            const Spacer(),
            _buildConfirmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreDetails() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.store, size: 40, color: Colors.teal),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text('Store/Restaurant'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...orderItems.map((item) => Text('- $item')),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerDetails() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(Icons.person, size: 40, color: Colors.teal),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text('Delivery Address:'),
                Text(customerAddress,
                    style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // Function to confirm order pickup
          _confirmPickup(context);
        },
        child: const Text(
          'Confirm Pickup',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  void _confirmPickup(BuildContext context) {
    // Perform the confirmation process and navigate to the delivery screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Pickup Confirmed! On the way to delivery.')),
    );
    Navigator.pop(context); // Pop to the previous screen or go to navigation
  }
}
