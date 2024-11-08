import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/orders_thread/active_orders_tab.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/orders_thread/cancelled_orders_tab.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/orders_thread/completed_orders_tab.dart';

import '../../../commons/app_colors.dart';

// import '../../app_colors.dart';
// import '../../utils/order_list_data.dart';
// import '../order_list_page.dart';
// import '../utils/order_list_data.dart';
// import 'orders_thread/orders_list_initial_page.dart';
// import 'orders_thread/orders_list_page.dart';

class OrdersFragment extends StatelessWidget {
  const OrdersFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
          color: const Color.fromARGB(255, 217, 217, 217),
          height: size.height * 0.1),
      Padding(
        padding: EdgeInsets.fromLTRB(
            size.width * 0.04, size.height * 0.04, size.width * 0.04, 0),
        child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.007),
                  child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabAlignment: TabAlignment.fill,
                    dividerColor: Colors.transparent,
                    indicatorWeight: 6,
                    indicatorColor: AppColors.primaryColor,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black),
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.normal),
                    tabs: [
                      Tab(text: 'Active'),
                      Tab(text: 'Completed'),
                      Tab(text: 'Cancelled'),
                    ],
                  ),
                ),
                const Expanded(
                    child: TabBarView(children: [
                  ActiveOrdersTab(),
                  CompletedOrdersTab(),
                  CancelledOrdersTab(),
                ]))
              ],
            )),
      ),
    ]);
  }
}

// class OrderContainer extends StatelessWidget {
//   final String title, subtitle;
//   final Color color;

//   const OrderContainer({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.cardColor,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       height: 72,
//       width: double.infinity,
//       child: Row(
//         children: [
//           const SizedBox(width: 14),
//           CircleAvatar(
//             radius: 12,
//             backgroundColor: color,
//           ),
//           const SizedBox(width: 10),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 textAlign: TextAlign.start,
//                 title,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 textAlign: TextAlign.start,
//                 subtitle,
//                 style: const TextStyle(fontSize: 11),
//               ),
//             ],
//           ),
//           const Spacer(),
//           const Icon(IconlyLight.arrow_right_2),
//           const SizedBox(width: 14),
//         ],
//       ),
//     );
//   }
// }


