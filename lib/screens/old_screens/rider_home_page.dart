import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:m_n_m_rider/screens/old_screens/map_navigation.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({super.key});

  @override
  State<RiderHomePage> createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {
  bool isAvailable = true; // Status for rider's availability
  bool hasNewOrder = true; // For demo: Simulate incoming order

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rider Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to profile/settings screen
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                // Rider Availability Toggle
                _buildAvailabilityToggle(),
                const SizedBox(height: 16),
                // Earnings Summary Section
                _buildEarningsSummary(),
                const SizedBox(height: 16),
                // Ongoing Orders Section
                _buildOngoingOrdersSection(),
                const SizedBox(height: 20),
                // Map Navigation Section
                _buildMapNavigationButton(),
              ],
            ),
          ),

          // Incoming Order Modal
          if (hasNewOrder) _buildIncomingOrderPopup(),
        ],
      ),
    );
  }

  Widget _buildAvailabilityToggle() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Status:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Switch(
              value: isAvailable,
              onChanged: (value) {
                setState(() {
                  isAvailable = value;
                });
              },
            ),
            Text(
              isAvailable ? 'Available' : 'Unavailable',
              style: TextStyle(
                color: isAvailable ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsSummary() {
    return Card(
      elevation: 4,
      color: Colors.lightGreen[50],
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Earnings Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Earnings:'),
                Text(
                  'GHS 150',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Completed Orders:'),
                Text(
                  '5',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOngoingOrdersSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ongoing Orders',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        OrderCard(
          orderId: "001",
          pickUpLocation: "Restaurant A",
          dropOffLocation: "Customer B",
          orderAmount: "GHS 20",
          estimatedTime: "10 mins",
        ),
        OrderCard(
          orderId: "002",
          pickUpLocation: "Store C",
          dropOffLocation: "Customer D",
          orderAmount: "GHS 15",
          estimatedTime: "15 mins",
        ),
        OrderCard(
          orderId: "003",
          pickUpLocation: "Pharmacy E",
          dropOffLocation: "Customer F",
          orderAmount: "GHS 30",
          estimatedTime: "12 mins",
        ),
      ],
    );
  }

  Widget _buildMapNavigationButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Navigate to Map screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MapNavigationScreen(
                    pickupLocation: LatLng(5.6037, -0.1870),
                    deliveryLocation: LatLng(5.6637, -0.1878))));
      },
      icon: const Icon(Icons.map),
      label: const Text('Go to Map'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }

  Widget _buildIncomingOrderPopup() {
    return Align(
      alignment: Alignment.center,
      child: Card(
        elevation: 4,
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'New Order Available',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text('Pick-up: Restaurant G'),
              const Text('Drop-off: Customer H'),
              const SizedBox(height: 8),
              const Text('Amount: GHS 25'),
              const Text('Estimated Time: 10 mins'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        hasNewOrder = false; // Accept order
                      });
                    },
                    child: const Text('Accept'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        hasNewOrder = false; // Reject order
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Reject'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final String pickUpLocation;
  final String dropOffLocation;
  final String orderAmount;
  final String estimatedTime;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.pickUpLocation,
    required this.dropOffLocation,
    required this.orderAmount,
    required this.estimatedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: $orderId', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pick-up: $pickUpLocation'),
                    Text('Drop-off: $dropOffLocation'),
                  ],
                ),
                Text('Amount: $orderAmount',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estimated time: $estimatedTime'),
                ElevatedButton(
                  onPressed: () {
                    // Functionality to view order details
                  },
                  child: const Text('Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
