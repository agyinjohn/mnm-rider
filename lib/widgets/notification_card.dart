import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../commons/app_colors.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.cardColor,
      ),
      width: double.infinity,
      height: size.height * 0.14,
      child: Padding(
          padding: EdgeInsets.all(size.width * 0.02),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Order'),
              Icon(IconlyLight.delete),
            ],
          )),
    );
  }
}
