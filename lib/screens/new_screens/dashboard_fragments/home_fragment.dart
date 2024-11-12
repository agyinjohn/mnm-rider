import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:m_n_m_rider/widgets/custom_button.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import '../../../commons/app_colors.dart';
import '../../../utils/providers/user_provider.dart';
import '../../../widgets/custom_bottom_sheet.dart';
import 'package:badges/badges.dart' as badges;

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  bool isAvailable = false;
  bool _isBottomSheetVisible = false;
  bool confirmedOffline = false;

  void showSuccessSheet(BuildContext context) {
    setState(() {
      _isBottomSheetVisible = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SuccessSheet(
        confirmed: confirmedOffline,
        title: isAvailable ? 'You are online!' : 'You are offline!',
        message: isAvailable
            ? 'You can now receive orders!\nLet\'s make some money this afternoon.'
            : 'You cannot receive orders!\nSorry, we are making money without you.',
        buttonText: 'Continue',
        onTapNavigation: '/dashboard',
      ),
    ).whenComplete(() {
      setState(() {
        _isBottomSheetVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final user = ref.read(userProvider);

    return SingleChildScrollView(
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              size.width * 0.04, size.height * 0.04, size.width * 0.04, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: size.width * 0.06,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person,
                        color: Colors.white, size: size.width * 0.08),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dashboard',
                        style: theme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            'John Doe',
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(width: size.width * 0.014),
                          CircleAvatar(
                            radius: size.width * 0.024,
                            backgroundColor:
                                const Color.fromARGB(255, 16, 145, 56),
                            child: CircleAvatar(
                              radius: size.width * 0.013,
                              backgroundColor:
                                  const Color.fromARGB(255, 32, 191, 85),
                              child: const Center(
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 10)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  badges.Badge(
                    badgeContent: (const Text(
                      '3',
                      style: TextStyle(color: AppColors.onPrimaryColor),
                    )),
                    badgeStyle: const badges.BadgeStyle(
                      badgeColor: AppColors.primaryColor,
                    ),
                    position: BadgePosition.topEnd(top: -10, end: -6),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        IconlyLight.notification,
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.01),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: size.width * 0.07,
                      decoration: BoxDecoration(
                          // color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(width: 2)),
                      child: Icon(Icons.help_sharp,
                          color: Colors.black26, size: size.width * 0.04),
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Status',
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: size.height * 0.01),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.cardColor,
                ),
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.circle,
                                  color: isAvailable
                                      ? Colors.green
                                      : AppColors.errorColor2,
                                  size: size.width * 0.03),
                              SizedBox(width: size.width * 0.014),
                              Text(
                                isAvailable ? 'Available' : 'Unavailable',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                          Text(
                            isAvailable
                                ? 'You can receive orders'
                                : 'You can\'t receive orders',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Switch(
                        value: isAvailable,
                        onChanged: (value) {
                          setState(() {
                            isAvailable = value;
                            confirmedOffline = !confirmedOffline;
                            showSuccessSheet(context);
                          });
                        },
                        activeColor: Colors.white,
                        inactiveThumbColor: AppColors.errorColor2,
                        inactiveTrackColor: Colors.black87,
                        activeTrackColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.024),
              Text(
                'Earnings Summary',
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: size.height * 0.015),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.cardColor,
                ),
                width: size.width,
                // height: size.height * 0.12,
                child: Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text('Amount earned:'),
                            const Spacer(),
                            Text(
                              'GHS 350.00',
                              style: theme.textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.006),
                        Row(
                          children: [
                            const Text('Amount payable:'),
                            const Spacer(),
                            Text(
                              'GHS -50.00',
                              style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.errorColor2),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.006),
                        Row(
                          children: [
                            const Text('Amount earned:'),
                            const Spacer(),
                            Text(
                              'GHS -50.00',
                              style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.errorColor2),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.01),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey.shade400,
                          ),
                          width: size.width,
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.02),
                            child: Row(
                              children: [
                                Text(
                                  'Total earnings:',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'GHS 300.00',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: const Color.fromARGB(
                                          255, 16, 145, 56)),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.024),
              CustomButton(onTap: () {}, title: 'Request Withdrawal'),
              SizedBox(height: size.height * 0.024),
              Text(
                'Orders Summary',
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: size.height * 0.015),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.cardColor,
                ),
                width: double.infinity,
                height: size.height * 0.14,
                child: Padding(
                    padding: EdgeInsets.all(size.width * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Active
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '4',
                              style: theme.textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      const Color.fromARGB(255, 252, 99, 43)),
                            ),
                            const Text('Active'),
                          ],
                        ),

                        // Completed
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '50',
                              style: theme.textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(255, 24, 122, 0)),
                            ),
                            const Text('Completed'),
                          ],
                        ),

                        // Cancelled
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '12',
                              style: theme.textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(255, 204, 51, 0)),
                            ),
                            const Text('Cancelled'),
                          ],
                        ),
                      ],
                    )),
              ),

              // Text(
              //   'Pending Orders',
              //   style: theme.textTheme.titleMedium,
              // ),
              // SizedBox(height: size.height * 0.015),
              // OrderListCard(
              //     orderId: '0001',
              //     pickUp: 'KFC (KNUST)',
              //     dropOff: 'Celia Royal',
              //     totalAmount: 100.00),
            ],
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
      ]),
    );
  }
}
