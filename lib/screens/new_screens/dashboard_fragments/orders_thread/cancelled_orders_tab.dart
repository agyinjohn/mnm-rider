import 'package:flutter/material.dart';
import 'package:m_n_m_rider/widgets/order_list_card.dart';

import '../../../../utils/data.dart';

class CancelledOrdersTab extends StatefulWidget {
  const CancelledOrdersTab({super.key});

  @override
  State<CancelledOrdersTab> createState() => _CancelledOrdersTabState();
}

class _CancelledOrdersTabState extends State<CancelledOrdersTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return cancelledOrders.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/no orders.gif',
                  width: size.width * 0.28,
                  height: size.width * 0.28,
                  fit: BoxFit.cover),
              SizedBox(height: size.height * 0.03),
              const Text('You have no cancelled orders'),
            ],
          ))
        : ListView.builder(
            itemCount: activeOrders.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
                child: Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 204, 51, 0),
                        radius: size.width * 0.02),
                    SizedBox(width: size.width * 0.02),
                    Expanded(child: activeOrders[index]),
                  ],
                ),
              );
            });
  }
}
