// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../commons/app_colors.dart';
// import '../../app_colors.dart';

class ActiveMapFragment extends StatelessWidget {
  const ActiveMapFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme; // Access the TextTheme

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Active Map',
          style: theme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Active Map Here!'),
      ),
    );
  }
}
