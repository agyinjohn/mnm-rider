import 'package:flutter/material.dart';

import 'package:m_n_m_rider/screens/old_screens/orders_page.dart';
import 'package:m_n_m_rider/screens/old_screens/profile_screen.dart';
import 'package:m_n_m_rider/screens/old_screens/rider_home_page.dart';

class PagesList {
  static const List<Widget> pages = [
    RiderHomePage(),
    OrdersPage(),
    RiderProfileScreen(),
  ];
}
