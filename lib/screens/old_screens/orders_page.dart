import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Completed'),
            Tab(text: 'Canceled'),
          ],
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(fontSize: 16),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          OrdersList(status: 'Active'),
          OrdersList(status: 'Completed'),
          OrdersList(status: 'Canceled'),
        ],
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  final String status;

  const OrdersList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    // Mock orders for different statuses
    final List<Map<String, String>> orders = [
      {
        'orderId': '001',
        'customer': 'John Doe',
        'location': '123 Main St',
        'time': '12:30 PM',
        'status': status,
        'amount': 'GHS 20'
      },
      {
        'orderId': '002',
        'customer': 'Jane Smith',
        'location': '456 Oak St',
        'time': '1:00 PM',
        'status': status,
        'amount': 'GHS 15'
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order['orderId']} - ${order['customer']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Location: ${order['location']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Time: ${order['time']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Amount: ${order['amount']}',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Text(
                  'Status: ${order['status']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: getStatusColor(order['status']!),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    // Show order details logic
                  },
                  child: const Text('View Details',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.orange;
      case 'Completed':
        return Colors.green;
      case 'Canceled':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
