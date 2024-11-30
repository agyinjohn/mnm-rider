import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/communities_fragment.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/orders_thread/order_details_page.dart';
import 'package:m_n_m_rider/screens/new_screens/swipe_to_confirm.dart';
import 'package:m_n_m_rider/utils/providers/incoming_order_provider_bool.dart';

import '../../../commons/app_colors.dart';
// import 'active_map_fragment.dart';
import '../../../utils/providers/location_provider.dart';
import '../../../widgets/alert_dialog.dart';
import 'home_fragment.dart';
import 'orders_fragment.dart';
import 'active_map_fragment.dart';
import 'profile_fragment.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});
  static const routeName = '/dashboard';
  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  int index = 0;

  List<Map<String, dynamic>> menu = [
    {
      'icon': const Icon(Icons.delivery_dining_outlined),
      'icon_active': const Icon(Icons.delivery_dining_rounded),
      'label': 'Orders',
      'fragment': const OrdersFragment(),
    },
    {
      'icon': const Icon(IconlyBroken.activity),
      'icon_active': const Icon(IconlyBold.activity),
      'label': 'Earnings',
      'fragment': const HomeFragment(),
    },
    {
      'icon': const Icon(IconlyLight.graph),
      'icon_active': const Icon(IconlyBold.graph),
      'label': 'Map',
      'fragment': const ActiveMapFragment(),
    },
    {
      'icon': const Icon(IconlyBroken.profile),
      'icon_active': const Icon(IconlyBold.profile),
      'label': 'Profile',
      'fragment': const ProfileFragment(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final locationService = ref.read(locationProvider);
    locationService.startLocationUpdates();
    final incomingOrder = ref.watch(incomingOrderProvider);
    print(incomingOrder);
    final size = MediaQuery.of(context).size;
    return incomingOrder
        ? SwipeToConfirm(
            onConfirm: () => showCustomAlertDialog(
                context: context,
                title: 'Do you want to accept this order?',
                body: Row(
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Order ID:'),
                        Text('Item:'),
                        Text('Pick Up Location:'),
                        Text('Delivery Location:'),
                      ],
                    ),
                    SizedBox(width: size.width * 0.04),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('#0001'),
                        Text('2x Classic..', overflow: TextOverflow.ellipsis),
                        Text('KFC (KNUS..', overflow: TextOverflow.ellipsis),
                        Text('Kotei (..', overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ],
                ),
                leftButtonText: 'No',
                rightButtonText: 'Yes',
                onTapLeft: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardPage()));
                },
                onTapRight: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderDetailPage(
                          orderNumber: '0002',
                          number: '0243678745',
                          customerName: 'John Agyin',
                        ),
                      ));
                }),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: SafeArea(child: menu[index]['fragment'] as Widget),
              bottomNavigationBar: SizedBox(
                height: 64,
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  showUnselectedLabels: true,
                  selectedLabelStyle: GoogleFonts.nunito().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  unselectedLabelStyle: GoogleFonts.nunito().copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                  backgroundColor: AppColors.backgroundColor,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.black45,
                  currentIndex: index,
                  onTap: (newIndex) {
                    setState(() {
                      index = newIndex;
                    });
                  },
                  items: menu.map((item) {
                    return BottomNavigationBarItem(
                      icon: item['icon'] as Icon,
                      activeIcon: item['icon_active'] as Icon,
                      label: item['label'] as String,
                    );
                  }).toList(),
                ),
              ),
            ),
          );
  }
}
