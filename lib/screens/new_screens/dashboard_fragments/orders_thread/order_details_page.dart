import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iconly/iconly.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/active_maps_thread/map_screen.dart';
import 'package:m_n_m_rider/widgets/alert_dialog.dart';
import 'package:m_n_m_rider/widgets/custom_button.dart';
import '../../../../commons/app_colors.dart';
import '../../../../models/order_item.dart';
import '../../../../utils/data.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/order_item_detail.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  GoogleMapController? _controller;

  // Getting the current location
  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, return default location
      return const LatLng(6.7296388965779785, -1.6601084660966479);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, return default location
        return const LatLng(6.7296388965779785, -1.6601084660966479);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, return default location
      return const LatLng(6.7296388965779785, -1.6601084660966479);
    }

    Position position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }

  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(6.7296388965779785, -1.6601084660966479),
    zoom: 16,
  );

  void _toggleView(int index) {
    setState(() {
      orderItems[index].isCompact = !orderItems[index].isCompact;
    });
  }

  bool isOrderCollected = false,
      isOrderDelivered = false,
      isCustomerConfirmed = false;

  bool _isBottomSheetVisible = false;

  void confirmOrderCollection(BuildContext context) {
    showCustomAlertDialog(
        context: context,
        title: 'Confirm Collection',
        body: const Text(
            'Do you confirm the collection of the item from the store?'),
        leftButtonText: 'No',
        rightButtonText: 'Yes',
        onTapLeft: () {
          // Navigator.of(context).pop();
        },
        onTapRight: () {
          setState(() {
            isOrderCollected = true;
            showSuccessSheet(context);
          });
          Navigator.of(context).pop();
        });
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
        buttonText: isCustomerConfirmed ? 'Continue' : '',
        onTapNavigation: '/dashboard',
      ),
    ).whenComplete(() {
      setState(() {
        _isBottomSheetVisible = false;
      });
    });
  }

  void confirmOrderDelivery(BuildContext context) {
    showCustomAlertDialog(
      context: context,
      title: 'Confirm Delivery',
      body: const Text(
          'Do you confirm the delivery of the item to the customer?'),
      leftButtonText: 'No',
      rightButtonText: 'Yes',
      onTapLeft: () {
        Navigator.of(context).pop();
      },
      onTapRight: () {
        setState(() {
          isOrderDelivered = true;

          Navigator.of(context).pop(); // Close the dialog
          showSuccessSheet(context);
        });
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
                      children: List.generate(orderItems.length, (index) {
                        final item = orderItems[index];
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

                    Stack(
                      children: [
                        Hero(
                          tag: 'mapHero',
                          child: Container(
                            height: size.height * 0.3,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: GoogleMap(
                                initialCameraPosition: _initialPosition,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller = controller;
                                },
                                myLocationButtonEnabled: true,
                                myLocationEnabled: true,
                              ),
                            ),
                          ),
                        ),

                        // To expand the map
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MapScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Expand Map',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * 0.015),

                    // Button to confirm collection of order item from store
                    CustomButton(
                        onLongPress: () {
                          setState() {
                            isCustomerConfirmed = true;
                            showSuccessSheet(context);
                          }
                        },
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
