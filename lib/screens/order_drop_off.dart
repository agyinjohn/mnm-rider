import 'package:flutter/material.dart';

class OrderDropOffScreen extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String deliveryAddress;

  const OrderDropOffScreen({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.deliveryAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Drop-Off Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order ID: $orderId',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Customer: $customerName',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Delivery Address: $deliveryAddress',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please confirm that you have successfully delivered the order.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Optional: Upload photo button
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Upload Proof of Delivery'),
              onPressed: () {
                // Functionality for uploading photo
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),

            // Optional: Customer signature field (if needed)
            const Text(
              'Customer Signature:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey[200],
              child: const Center(child: Text('Signature Pad (Optional)')),
            ),
            const SizedBox(height: 30),

            // Confirm drop-off button
            ElevatedButton(
              onPressed: () {
                _confirmDelivery(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize:
                    const Size(double.infinity, 50), // Full width button
              ),
              child: const Text('Confirm Drop-Off'),
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle delivery confirmation
  void _confirmDelivery(BuildContext context) {
    // Confirmation logic, e.g., sending status to the backend
    // You can use API to update the status of the order as 'delivered'

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delivery Confirmed'),
        content: const Text('The order has been successfully delivered!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to next screen or back to the orders list
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
