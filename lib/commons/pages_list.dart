import 'package:flutter/material.dart';

import 'package:m_n_m_rider/screens/orders_page.dart';
import 'package:m_n_m_rider/screens/profile_screen.dart';
import 'package:m_n_m_rider/screens/rider_home_page.dart';

class PagesList {
  static const List<Widget> pages = [
    RiderHomePage(),
    OrdersPage(),
    RiderProfileScreen(),
  ];
}
