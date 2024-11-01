import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import '../../../commons/app_colors.dart';
import '../../../utils/providers/user_provider.dart';

class HomeFragment extends ConsumerStatefulWidget {
  const HomeFragment({super.key});

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends ConsumerState<HomeFragment> {
  bool isAvailable = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final user = ref.read(userProvider);

    return SingleChildScrollView(
      child: Padding(
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
                          radius: size.width * 0.018,
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
                                    : AppColors.primaryColor,
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
                        });
                      },
                      activeColor: Colors.green,
                      inactiveThumbColor: AppColors.primaryColor,
                      inactiveTrackColor: Colors.black45,
                      activeTrackColor: Colors.white54,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size.height * 0.015),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.cardColor,
              ),
              width: size.width,
              height: size.height * 0.12,
              child: Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: const Center(child: Text('data'))),
            ),
            SizedBox(height: size.height * 0.015),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: AppColors.cardColor,
              ),
              width: size.width * 0.6,
              height: size.height * 0.12,
              child: Padding(
                  padding: EdgeInsets.all(size.width * 0.02),
                  child: const Center(child: Text('data'))),
            ),
            SizedBox(height: size.height * 0.015),
            Text(
              'Ongoing Orders',
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
                  child: const Center(child: Text('No ongoing orders'))),
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
                  child: const Center(child: Text('No ongoing orders'))),
            ),
          ],
        ),
      ),
    );
  }
}
