import 'package:flutter/material.dart';
import 'package:m_n_m_rider/widgets/order_list_card.dart';

import '../../../../utils/data.dart';

class ActiveOrdersTab extends StatefulWidget {
  const ActiveOrdersTab({super.key});

  @override
  State<ActiveOrdersTab> createState() => _ActiveOrdersTabState();
}

class _ActiveOrdersTabState extends State<ActiveOrdersTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
        itemCount: activeOrders.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 252, 99, 43),
                    radius: size.width * 0.02),
                SizedBox(width: size.width * 0.02),
                Expanded(child: activeOrders[index]),
              ],
            ),
          );
        });
  }
}
