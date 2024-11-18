import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:m_n_m_rider/widgets/alert_dialog.dart';
import '../../../commons/app_colors.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  final bool isAccountSetupComplete = true;
  bool _isBottomSheetVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: theme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Main content of the profile page
          SingleChildScrollView(
            padding: EdgeInsets.all(size.width * 0.018),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Switch Accounts', style: theme.titleMedium),
                SizedBox(height: size.height * 0.025),
                Center(
                    child: Column(
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.10,
                      backgroundImage:
                          const AssetImage('assets/images/profile-pic.png'),
                    ),
                    Text(
                      'John Kwaku Agyin',
                      style: theme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '+1234 567 890',
                      style: theme.bodyMedium,
                    ),
                    Text(
                      'johnkwakuagyin@gmail.com',
                      style: theme.bodyMedium,
                    ),
                  ],
                )),

                SizedBox(height: size.height * 0.035),
                Text('Account Information', style: theme.titleMedium),
                SizedBox(height: size.height * 0.025),
                Row(
                  children: [
                    SizedBox(
                      height: 35,
                      width: 35,
                      child: Image.asset(
                          'assets/images/identification-documents.png',
                          fit: BoxFit.cover),
                    ),
                    SizedBox(width: size.width * 0.022),
                    Text('Verification Status', style: theme.bodyLarge),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                            vertical: size.height * 0.012),
                        child: Center(
                          child: Text(
                            'Verified',
                            style:
                                theme.bodySmall?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildInformation(
                  context,
                  'assets/images/pencil-drawing.png',
                  'Edit account details',
                  () {
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                ),
                _buildInformation(
                  context,
                  'assets/images/card-payment.png',
                  'Payment methods',
                  () {
                    Navigator.pushNamed(context, '/payment-methods');
                  },
                ),
                _buildInformation(
                  context,
                  'assets/images/waste.png',
                  'Remove account',
                  () {
                    setState(() {
                      _isBottomSheetVisible = true;
                    });
                    showCustomAlertDialog(
                      context: context,
                      title: 'Remove Account',
                      body: const Text(
                          'Are you sure you want to remove your account?'),
                      onTapLeft: () {
                        setState(() {
                          _isBottomSheetVisible = false;
                        });
                        Navigator.pop(context);
                      },
                      onTapRight: () {
                        setState(() {
                          _isBottomSheetVisible = false;
                        });
                        Navigator.pushNamed(context, '/remove-account');
                        // Navigator.pop(context); // Close the dialog
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Account deleted successfully'),
                        //   ),
                        // );
                      },
                    );
                  },
                ),
                SizedBox(height: size.height * 0.028),
                const Divider(),
                SizedBox(height: size.height * 0.035),
                Text('Utilities', style: theme.titleMedium),
                SizedBox(height: size.height * 0.025),
                _buildInformation(
                  context,
                  'assets/images/online-support.png',
                  'Make a report',
                  () {},
                ),
                _buildInformation(
                  context,
                  'assets/images/protect.png',
                  'Privacy & Policy',
                  () {},
                ),
                _buildInformation(
                  context,
                  'assets/images/terms-and-conditions.png',
                  'Terms & Conditions',
                  () {},
                ),
                SizedBox(height: size.height * 0.028),
                const Divider(),
                SizedBox(height: size.height * 0.035),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Version 1.0.0.0', style: theme.bodySmall),
                  ],
                ),
              ],
            ),
          ),

          // Positioned prompt for account setup
          if (!isAccountSetupComplete)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.amber[800],
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Text(
                        'Complete your account setup to start selling!',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width: 1,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to account setup page or trigger setup action
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                        ),
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Blurred background when bottom sheet is visible
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

  Widget _buildInformation(BuildContext ctx, String imageUrl,
      String description, VoidCallback onTap) {
    final size = MediaQuery.of(ctx).size;
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            height: 35,
            width: 35,
            child: Image.asset(imageUrl, fit: BoxFit.cover),
          ),
          SizedBox(width: size.width * 0.022),
          Text(description),
          const Spacer(),
          const Icon(IconlyLight.arrow_right_2),
        ],
      ),
    );
  }
}
