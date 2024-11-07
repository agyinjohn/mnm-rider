import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:m_n_m_rider/widgets/custom_button.dart';
import '../../../../commons/app_colors.dart';
import '../../../../models/order_item.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/order_item_detail.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderNumber, customerName, number;

  const OrderDetailPage({
    super.key,
    required this.orderNumber,
    required this.customerName,
    required this.number,
  });

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final List<OrderItem> _orderItems = [
    OrderItem(
        orderId: '0001',
        customerName: 'John Doe',
        totalAmount: 160,
        description: '2x Burger'),
    OrderItem(
        orderId: '0002',
        customerName: 'Jane Smith',
        totalAmount: 200,
        description: '1x Pizza'),
    OrderItem(
        orderId: '0001',
        customerName: 'John Doe',
        totalAmount: 160,
        description: '2x Burger'),
    OrderItem(
        orderId: '0001',
        customerName: 'John Doe',
        totalAmount: 160,
        description: '2x Burger'),
    OrderItem(
        orderId: '0001',
        customerName: 'John Doe',
        totalAmount: 160,
        description: '2x Burger'),
    OrderItem(
        orderId: '0001',
        customerName: 'John Doe',
        totalAmount: 160,
        description: '2x Burger'),
    OrderItem(
        orderId: '0001',
        customerName: 'John Doe',
        totalAmount: 160,
        description: '2x Burger'),
    OrderItem(
        orderId: '0003',
        customerName: 'Alice Johnson',
        totalAmount: 80,
        description: '3x Salad'),
  ];

  void _toggleView(int index) {
    setState(() {
      _orderItems[index].isCompact = !_orderItems[index].isCompact;
    });
  }

  bool isOrderCollected = false,
      isOrderDelivered = false,
      isCustomerConfirmed = false;

  bool _isBottomSheetVisible = false;

  void confirmOrderCollection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Collection'),
          content: const Text(
              'Do you confirm the collection of the item from the store?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: AppColors.errorColor),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isOrderCollected = true;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  void showSuccessSheet(BuildContext context) {
    setState(() {
      _isBottomSheetVisible = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SuccessSheet(
        image: isCustomerConfirmed
            ? 'assets/images/Verification.png'
            : 'assets/images/customer-wait.png',
        title: isCustomerConfirmed
            ? 'Order delivered successfully!'
            : 'Waiting for customer confirmation',
        message: isCustomerConfirmed
            ? 'Order successfully delivered!\nGreat work, continue to your next delivery.'
            : 'Please wait for customer to confirm that package has been received.',
        buttonText:
            isCustomerConfirmed ? 'Continue' : 'After Customer Approves',
        // onTapNavigation: '/dashboard',
      ),
    ).whenComplete(() {
      setState(() {
        _isBottomSheetVisible = false;
      });
    });
  }

  void confirmOrderDelivery(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delivery'),
          content: const Text(
              'Do you confirm the delivery of the item to the customer?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: AppColors.errorColor),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // isOrderDelivered = true;
                  // _isBottomSheetVisible = true;
                  Navigator.of(context).pop(); // Close the dialog
                  showSuccessSheet(context);
                });
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
          'Order Details',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04, vertical: size.height * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(IconlyBroken.paper, size: size.width * 0.16),
                        SizedBox(width: size.width * 0.02),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Order No.:'),
                            Text('Customer:'),
                            Text('Number:'),
                            Text('Location:'),
                          ],
                        ),
                        SizedBox(width: size.width * 0.04),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '#${widget.orderNumber}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.customerName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.number,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                'Ayeduase Gate',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: size.height * 0.042,
                            width: size.width * 0.18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.primaryColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(size.width * 0.008),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    IconlyBroken.calling,
                                    size: size.width * 0.05,
                                    color: AppColors.onPrimaryColor,
                                  ),
                                  SizedBox(width: size.width * 0.01),
                                  Text('Call',
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                              color: AppColors.onPrimaryColor,
                                              fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                    Text(
                      'Items purchased',
                      style: theme.textTheme.titleMedium,
                    ),
                    SizedBox(height: size.height * 0.015),

                    // Render the list of order items
                    Column(
                      children: List.generate(_orderItems.length, (index) {
                        final item = _orderItems[index];
                        return Column(
                          children: [
                            item.isCompact
                                ? OrderItemDetailCompact(
                                    orderId: item.orderId,
                                    customerName: item.customerName,
                                    totalAmount: item.totalAmount,
                                    description: item.description,
                                    toggleView: () => _toggleView(index),
                                  )
                                : OrderItemDetailExpanded(
                                    orderId: item.orderId,
                                    customerName: item.customerName,
                                    totalAmount: item.totalAmount,
                                    description: item.description,
                                    toggleView: () => _toggleView(index),
                                  ),
                            SizedBox(height: size.height * 0.015),
                          ],
                        );
                      }),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Total:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: size.width * 0.058),
                        Text(
                          'GHC 420.00',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),

                    // Payment Details

                    Row(
                      children: [
                        Image.asset(
                          'assets/images/payment.png',
                        ),
                        SizedBox(width: size.width * 0.015),
                        Text(
                          'Payment Details',
                          style: theme.textTheme.titleMedium,
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.015),

                    // Payment on delivery

                    _buildPaymentDetailCard(context,
                        imageUrl: 'assets/images/payment.png',
                        title: 'Payment on delivery',
                        isChecked: true),

                    SizedBox(height: size.height * 0.015),

                    _buildPaymentDetailCard(context,
                        imageUrl: 'assets/images/cash.png',
                        title: 'Mobile money',
                        isChecked: false),

                    SizedBox(height: size.height * 0.015),

                    // Delivery Location

                    Text(
                      'Delivery Location',
                      style: theme.textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        Icon(
                          IconlyLight.info_circle,
                          size: size.width * 0.048,
                        ),
                        SizedBox(width: size.width * 0.01),
                        Text(
                          'Kindly tap on the button on the map for a larger view',
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.015),

                    // Map

                    Container(
                      width: double.infinity,
                      height: size.height * 0.22,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColors.cardColor),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.025),
                          child: const Center(
                            child: Text('Map Showing the location of the user'),
                          )),
                    ),

                    SizedBox(height: size.height * 0.015),

                    // Button to confirm collection of order item from store
                    CustomButton(
                        onTap: () {
                          isOrderCollected
                              ? confirmOrderDelivery(context)
                              : confirmOrderCollection(context);
                          // :
                        },
                        title: isOrderCollected
                            ? 'Order Delivered'
                            : 'Order Collected'),
                  ],
                ),
              ),
            ),
          ),

          // Blur effect when the bottom sheet is visible
          if (_isBottomSheetVisible)
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetailCard(BuildContext context,
      {required String imageUrl,
      required String title,
      required bool isChecked}) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: AppColors.cardColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
            ),
            SizedBox(width: size.width * 0.015),
            Text(
              title,
              style: isChecked
                  ? theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)
                  : theme.textTheme.bodyMedium?.copyWith(color: Colors.black54),
            ),

            const Spacer(),

            // Radio button here, reflecting what the customer already selected; thus it is read - only here
            Radio(
              groupValue: true,
              value: isChecked,
              onChanged: null,
              fillColor: isChecked
                  ? const WidgetStatePropertyAll(Colors.black)
                  : const WidgetStatePropertyAll(Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
