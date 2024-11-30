import 'package:flutter/material.dart';
import 'package:m_n_m_rider/widgets/order_list_card.dart';

import '../../../../utils/data.dart';

class CompletedOrdersTab extends StatefulWidget {
  const CompletedOrdersTab({super.key});

  @override
  State<CompletedOrdersTab> createState() => _CompletedOrdersTabState();
}

class _CompletedOrdersTabState extends State<CompletedOrdersTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return completedOrders.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/no orders.gif',
                  width: size.width * 0.28,
                  height: size.width * 0.28,
                  fit: BoxFit.cover),
              SizedBox(height: size.height * 0.03),
              const Text('You have no completed orders'),
            ],
          ))
        : ListView.builder(
            itemCount: completedOrders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 24, 122, 0),
                        radius: size.width * 0.02),
                    SizedBox(width: size.width * 0.02),
                    Expanded(child: activeOrders[index]),
                  ],
                ),
              );
            });
  }
}
