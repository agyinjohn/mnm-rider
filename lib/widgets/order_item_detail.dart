import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import '../commons/app_colors.dart';

class OrderItemDetailCompact extends StatelessWidget {
  final String orderId, description, customerName;
  final double totalAmount;
  final VoidCallback toggleView;

  const OrderItemDetailCompact({
    super.key,
    required this.description,
    required this.orderId,
    required this.customerName,
    required this.totalAmount,
    required this.toggleView,
  });

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
      height: size.width * 0.26,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              'assets/images/kfc 2.png',
              width: size.width * 0.26,
              height: size.width * 0.26,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Order #$orderId',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  customerName,
                  style: theme.textTheme.bodySmall,
                ),
                SizedBox(height: size.height * 0.004),
                Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.004),
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  DateTimeFormatter.getCurrentDateTime(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              'GHC ${totalAmount.toStringAsFixed(2)}',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.016),
              child: GestureDetector(
                onTap: toggleView,
                child: const Icon(IconlyLight.arrow_down_2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderItemDetailExpanded extends StatelessWidget {
  final String orderId, description, customerName;
  final double totalAmount;
  final VoidCallback toggleView;

  const OrderItemDetailExpanded({
    super.key,
    required this.description,
    required this.orderId,
    required this.customerName,
    required this.totalAmount,
    required this.toggleView,
  });

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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'assets/images/kfc 2.png',
                  width: size.width * 0.26,
                  height: size.width * 0.26,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.016),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Order #$orderId | ',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            customerName,
                            style: theme.textTheme.bodySmall,
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: toggleView,
                            child: const Icon(IconlyLight.arrow_up_2),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.004),
                      Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: size.height * 0.004),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              DateTimeFormatter.getCurrentDateTime(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text('Quantity: ',
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                          Text('2',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor)),
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Size:',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.006),
                                Text(
                                  'Medium',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Large',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  'Quantity',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.006),
                                Text(
                                  '1',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '1',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Center(
                                  child: Text(
                                    'Price',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.006),
                                Text(
                                  'GHC 70.00',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'GHC 90.00',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.026),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'GHC 160.00',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DateTimeFormatter {
  static String getCurrentDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('hh:mm a, EEE MMM d, yyyy').format(now);
  }
}
