import 'package:flutter/material.dart';

import '../commons/app_colors.dart';

// import '../app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final String title;

  const CustomButton({
    super.key,
    this.onLongPress,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.primaryColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.onPrimaryColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
