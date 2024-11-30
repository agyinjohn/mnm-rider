import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../commons/app_colors.dart';

// Notification model class
class NotificationItem {
  final String value, status;
  bool isPayment;
  double amount;

  NotificationItem({
    this.value = '',
    this.amount = 0.00,
    required this.status,
    this.isPayment = false,
  });
}

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});
  static const routeName = '/notifications-page';

  // Dummy notification data
  final List<NotificationItem> notificationsList = [
    NotificationItem(value: '0001', status: 'You rejected this order'),
    NotificationItem(value: '0002', status: 'You rejected this order'),
    NotificationItem(
        amount: 100.0, status: 'Withdrawal successful', isPayment: true),
    NotificationItem(value: '0003', status: 'You rejected this orderrr'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(IconlyLight.arrow_left_2),
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),
        title: Text(
          'Notifications',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.028),
            child: const Icon(IconlyLight.search),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notificationsList.length,
        itemBuilder: (context, index) {
          final notification = notificationsList[index];
          return _buildNotificationCard(
            context,
            notification.amount,
            notification.value,
            notification.status,
            notification.isPayment,
          );
        },
      ),
    );
  }

  // Build a notification card widget
  Widget _buildNotificationCard(BuildContext context, double amount,
      String value, String status, bool isPayment) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.cardColor,
        ),
        width: double.infinity,
        height: size.height * 0.12,
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isPayment ? 'Payment' : 'Order',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        color:
                            isPayment ? Colors.green : AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      Text(isPayment
                          ? 'Payment requested: '
                          : 'You rejected order: '),
                      Text(
                        isPayment
                            ? 'GHC ${amount.toStringAsFixed(2)}'
                            : '#$value',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Status: '),
                      Text(
                        status,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                  onTap: () {},
                  child: const Icon(IconlyLight.delete,
                      color: AppColors.errorColor2)),
            ],
          ),
        ),
      ),
    );
  }
}
