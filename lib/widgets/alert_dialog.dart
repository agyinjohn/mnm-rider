import 'package:flutter/material.dart';
import '../commons/app_colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String leftButtonText, rightButtonText, title;
  final Widget body;
  final VoidCallback onTapLeft, onTapRight;

  const CustomAlertDialog({
    super.key,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.onTapLeft,
    required this.onTapRight,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Center(child: Text(title)),
      content: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: body,
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  onTapLeft();
                },
                child: Container(
                  height: size.height * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.errorColor,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        leftButtonText,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.onPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: size.width * 0.03),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  onTapRight();
                },
                child: Container(
                  height: size.height * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.green,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        rightButtonText,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.onPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

void showCustomAlertDialog({
  required BuildContext context,
  required String title,
  required Widget body,
  required String leftButtonText,
  required String rightButtonText,
  required VoidCallback onTapLeft,
  required VoidCallback onTapRight,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialog(
        title: title,
        body: body,
        leftButtonText: leftButtonText,
        rightButtonText: rightButtonText,
        onTapLeft: onTapLeft,
        onTapRight: onTapRight,
      );
    },
  );
}
