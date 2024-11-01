import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

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
    return const Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [Text('1')],
        ),
      ),
    );
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


