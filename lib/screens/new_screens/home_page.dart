import 'package:flutter/material.dart';
import 'package:m_n_m_rider/commons/pages_list.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({super.key});
  static const routeName = '/homepage';
  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen>
    with SingleTickerProviderStateMixin {
  bool hasNewOrder = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  int index = 0;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);

    _animation = Tween<double>(begin: 0, end: 2).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward(); // Stops the animation after completion
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey[200],
        // appBar: AppBar(
        //   title:
        //       const Text("Active Orders", style: TextStyle(color: Colors.white)),
        //   centerTitle: true,
        //   backgroundColor: Colors.teal,
        // ),
        body: hasNewOrder
            ? Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          child: Center(
                              child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // First expanding circle (wave)
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              // print(_animation.value)
                              return Container(
                                width: 100 + _animation.value * 100,
                                height: 100 + _animation.value * 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue.withOpacity(1),
                                ),
                              );
                            },
                          ),
                          // Second expanding circle (wave)
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return Container(
                                width: 150 + _animation.value * 100,
                                height: 150 + _animation.value * 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blueAccent.withOpacity(0.5),
                                ),
                              );
                            },
                          ),
                          // The GIF or image in the center
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset('assets/images/fulfillment.gif'),
                          ),
                        ],
                      ))),
                    ),
                  ],
                ),
              )
            : PagesList.pages[index],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.teal,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        floatingActionButton: hasNewOrder
            ? Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_bag),
                  onPressed: () {
                    setState(() {
                      hasNewOrder = false;
                    });
                  },
                  label: const Text('View incoming order'),
                ),
              )
            : null);
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
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #$orderId',
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
                  'Pickup: $pickUpLocation',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Dropoff: $dropOffLocation',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Amount: $orderAmount',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              'ETA: $estimatedTime',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    // Accept order logic
                  },
                  child: const Text('Accept', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  onPressed: () {
                    // Decline order logic
                  },
                  child: const Text('Decline', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
