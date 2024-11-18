import 'package:flutter/material.dart';
// import 'package:mnm_vendor/screens/dashboard_fragments/verification_page.dart';
import 'package:iconly/iconly.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../commons/app_colors.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key});

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  final bool isAccountSetupComplete = true;
  String userId = "";
  String name = "";
  String email = "";
  String phoneNumber = "";
  String role = "";
  DateTime createdAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Retrieve token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      try {
        // Decode the JWT token
        final jwt = JwtDecoder.decode(token);
        setState(() {
          userId = jwt['_id'];
          name = jwt['name'];
          email = jwt['email'];
          phoneNumber = jwt['phoneNumber'];
          role = jwt['role'];
          createdAt = DateTime.parse(jwt['created_at']);
        });
      } catch (e) {
        print('Error decoding token: $e');
      }
    }
  }

  void _logout() async {
    // Clear the token and navigate to the login page or home
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('x-auth-token');

    // Navigate back to login or home page
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile',
          style: theme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [const PopupMenuItem(child: Text('Logout'))];
            },
          )
        ],
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
                    Image.asset('assets/images/main-logo.png',
                        height: size.width * 0.22,
                        width: size.width * 0.22,
                        fit: BoxFit.cover),
                    Text(
                      name,
                      style: theme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      phoneNumber,
                      style: theme.bodyMedium,
                    ),
                    Text(
                      email,
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
                _buildInformation(context, 'assets/images/pencil-drawing.png',
                    'Edit account details'),
                _buildInformation(context, 'assets/images/card-payment.png',
                    'Payment methods'),
                _buildInformation(
                    context, 'assets/images/waste.png', 'Remove account'),
                SizedBox(height: size.height * 0.028),
                const Divider(),
                SizedBox(height: size.height * 0.035),
                Text('Utilities', style: theme.titleMedium),
                SizedBox(height: size.height * 0.025),
                _buildInformation(context, 'assets/images/online-support.png',
                    'Make a report'),
                _buildInformation(
                    context, 'assets/images/protect.png', 'Privacy & Policy'),
                _buildInformation(
                    context,
                    'assets/images/terms-and-conditions.png',
                    'Terms & Conditions'),
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
                        // Navigator.pushNamed(
                        //     context, KycVerificationScreen.routeName);
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
        ],
      ),
    );
  }

  Widget _buildInformation(
      BuildContext ctx, String imageUrl, String description) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
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



//import 'package:flutter/material.dart';
// // import 'package:mnm_vendor/screens/dashboard_fragments/verification_page.dart';
// import 'package:iconly/iconly.dart';

// import '../../../commons/app_colors.dart';
// // import '../../app_colors.dart';

// class ProfileFragment extends StatefulWidget {
//   const ProfileFragment({super.key});

//   @override
//   State<ProfileFragment> createState() => _ProfileFragmentState();
// }

// class _ProfileFragmentState extends State<ProfileFragment> {
//   final bool isAccountSetupComplete = true;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final theme = Theme.of(context).textTheme;

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Profile',
//           style: theme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.transparent,
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Stack(
//         children: [
//           // Main content of the profile page
//           SingleChildScrollView(
//             padding: EdgeInsets.all(size.width * 0.018),
//             child: const Column(
//               children: [Text('1')],
//             ),
//           ),

//           // Positioned prompt for account setup
//           if (!isAccountSetupComplete)
//             Positioned(
//               top: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 color: Colors.amber[800],
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Expanded(
//                       child: Text(
//                         'Complete your account setup to start selling!',
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 1,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Navigator.pushNamed(
//                         //     context, KycVerificationScreen.routeName);
//                         // Navigate to account setup page or trigger setup action
//                       },
//                       style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.circular(10), // Rounded corners
//                         ),
//                         backgroundColor: AppColors.primaryColor,
//                       ),
//                       child: const Icon(
//                         Icons.arrow_forward,
//                         size: 18,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInformation(
//       BuildContext ctx, String imageUrl, String description) {
//     final size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () {},
//       child: Row(
//         children: [
//           SizedBox(
//             height: 35,
//             width: 35,
//             child: Image.asset(imageUrl, fit: BoxFit.cover),
//           ),
//           SizedBox(width: size.width * 0.022),
//           Text(description),
//           const Spacer(),
//           const Icon(IconlyLight.arrow_right_2),
//         ],
//       ),
//     );
//   }
// }
