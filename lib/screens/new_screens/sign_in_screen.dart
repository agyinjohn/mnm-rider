import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_n_m_rider/screens/new_screens/dashboard_fragments/dashboard_page.dart';
import 'package:m_n_m_rider/widgets/custom_snackbar.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:page_transition/page_transition.dart';

import '../../commons/app_colors.dart';
import '../../utils/providers/login_auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';
import 'home_page.dart';
import 'verification_page.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});
  static const routeName = '/sign-in-page';
  @override
  ConsumerState<SignInScreen> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInScreen> {
  final TextEditingController _controllerID = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final bool _showError = false;
  @override
  void dispose() {
    super.dispose();
    _controllerID.dispose();
    _controllerPassword.dispose();
  }

  final List<Image> accounts = [
    Image.asset('assets/images/g.png'),
    Image.asset('assets/images/a.png'),
    Image.asset('assets/images/f.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                14.0,
                size.height * 0.10,
                14.00,
                size.height * 0.06,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 100,
                      child: Image.asset(
                        'assets/images/main-logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    const Text(
                      'Welcome back!',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Kindly enter your details to login.',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            const SizedBox(height: 16),
                            CustomTextField(
                              controller: _controllerID,
                              isPassword: false,
                              prefixIcon: Icons.mail,
                              hintText: 'Enter your email or phone number',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field cannot be empty";
                                }
                                // if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                //     .hasMatch(value)) {
                                //   return "Enter a valid email";
                                // }
                                return null; // Input is valid
                              },
                            ),
                            // SizedBox(height: size.height * 0.015),
                            CustomTextField(
                              controller: _controllerPassword,
                              isPassword: true,
                              prefixIcon: Icons.lock,
                              hintText: 'Enter your password here',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field cannot be empty";
                                }
                                // if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                //     .hasMatch(value)) {
                                //   return "Enter a valid email";
                                // }
                                return null; // Input is valid
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/forgot_passoword');
                                },
                                child: const Text(
                                  'Forgot your password?',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(height: size.height * 0.03),
                    CustomButton(
                        // onTap: () {
                        //   Navigator.pushAndRemoveUntil(
                        //     context,
                        //     PageTransition(
                        //       child: const DashboardPage(),
                        //       // KycVerificationScreen(),
                        //       type: PageTransitionType.bottomToTop,
                        //       duration: const Duration(milliseconds: 1000),
                        //     ),
                        //     (route) => false,
                        //   );
                        // },
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            final isloginSuccess = await authNotifier.login(
                                _controllerID.text.trim(),
                                _controllerPassword.text.trim(),
                                context,
                                ref);
                          }
                        },
                        title: 'Login'),
                    const SizedBox(height: 24),
                    // const Text(
                    //   'Or continue with',
                    //   style: TextStyle(fontWeight: FontWeight.w900),
                    //   textAlign: TextAlign.center,
                    // ),
                    // const SizedBox(height: 12),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: accounts.map((image) {
                    //     return Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //       child: Container(
                    //         width: 54,
                    //         height: 54,
                    //         decoration: BoxDecoration(
                    //           color: Colors.grey[300],
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: image,
                    //         ),
                    //       ),
                    //     );
                    //   }).toList(),
                    // ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account? ',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/sign-up-page'),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            authState.isLoading
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white70,
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5)),
                        // color: Colors.transparent,
                        child: const NutsActivityIndicator(),
                      ),
                    ),
                  )
                : Container(
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }
}
