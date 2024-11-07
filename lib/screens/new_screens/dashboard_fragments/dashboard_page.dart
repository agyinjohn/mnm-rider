import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/communities_fragment.dart';

import '../../../commons/app_colors.dart';
import 'active_map_fragment.dart';
import 'home_fragment.dart';
import 'orders_fragment.dart';
import 'profile_fragment.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static const routeName = '/dashboard';
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int index = 0;

  List<Map<String, dynamic>> menu = [
    {
      'icon': const Icon(IconlyBroken.home),
      'icon_active': const Icon(IconlyBold.home),
      'label': 'Home',
      'fragment': const HomeFragment(),
    },
    // {
    //   'icon': SvgPicture.asset('assets/images/motor-scooter.svg'),
    //   'icon_active': SvgPicture.asset('assets/images/motor-scooter-bold.svg'),
    //   'label': 'Orders',
    //   'fragment': const OrdersFragment(),
    // },
    {
      'icon': const Icon(Icons.star),
      'icon_active': const Icon(IconlyBold.star),
      'label': 'Orders',
      'fragment': const OrdersFragment(),
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
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: menu[index]['fragment'] as Widget,
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
