import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:page_transition/page_transition.dart';

import '../screens/new_screens/customized_ui_image_picker.dart';
import '../screens/new_screens/dashboard_fragments/dashboard_page.dart';
import '../screens/new_screens/dashboard_fragments/home_thread/notifications_page.dart';
import '../screens/new_screens/dashboard_fragments/home_thread/request_withdrawal_page.dart';
import '../screens/new_screens/dashboard_fragments/profile_thread/add_account_page.dart';
import '../screens/new_screens/dashboard_fragments/profile_thread/edit_profile_page.dart';
import '../screens/new_screens/dashboard_fragments/profile_thread/payment_methods_page.dart';
import '../screens/new_screens/dashboard_fragments/profile_thread/remove_account_page.dart';
import '../screens/new_screens/face_id_page.dart';
import '../screens/new_screens/home_page.dart';
import '../screens/new_screens/on_boarding_screen.dart';
import '../screens/new_screens/sign_in_screen.dart';
import '../screens/new_screens/sign_up_screen.dart';
import '../screens/new_screens/upload_id_page.dart';
import '../screens/new_screens/verification_page.dart';
import '../widgets/bussiness_info.dart';
import 'providers/provider.dart';

// import 'screens/dashboard_page.dart';
// import 'utils/providers/provider.dart';

Route<dynamic> onGenerateRoute(RouteSettings setting, WidgetRef ref) {
  switch (setting.name) {
    case SignUpScreen.routeName:
      return PageTransition(
          duration: const Duration(milliseconds: 1000),
          child: const SignUpScreen(),
          type: PageTransitionType.rightToLeft);
    case SignInScreen.routeName:
      return PageTransition(
          duration: const Duration(milliseconds: 1000),
          child: const SignInScreen(),
          type: PageTransitionType.rightToLeft);

    case RiderHomeScreen.routeName:
      return PageTransition(
          duration: const Duration(milliseconds: 1000),
          child: const RiderHomeScreen(),
          type: PageTransitionType.rightToLeft);

    case KycVerificationScreen.routeName:
      return PageTransition(
          duration: const Duration(milliseconds: 1000),
          child: const KycVerificationScreen(),
          type: PageTransitionType.rightToLeft);

    case IDVerificationScreen.routeName:
      return PageTransition(
          child: IDVerificationScreen(
            onComplete: () {
              ref.read(stepStateProvider.notifier).completeStep(0);
            },
          ),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 500));

    case FaceDetectionPage.routeName:
      return PageTransition(
          child: FaceDetectionPage(
            onComplete: () {
              ref.read(stepStateProvider.notifier).completeStep(1);
            },
          ),
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft);
    case BussinessInfo.routeName:
      return PageTransition(
          child: BussinessInfo(
            onComplete: () {
              ref.read(stepStateProvider.notifier).completeStep(2);
            },
          ),
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.rightToLeft);
    case OnboardingScreen.routeName:
      return PageTransition(
          child: const OnboardingScreen(),
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 500));
    case MultipleImagePicker.routeName:
      return PageTransition(
          child: const MultipleImagePicker(),
          type: PageTransitionType.rightToLeft);
    case NotificationsPage.routeName:
      return PageTransition(
          child: NotificationsPage(), type: PageTransitionType.rightToLeft);
    case DashboardPage.routeName:
      return PageTransition(
          child: const DashboardPage(), type: PageTransitionType.rightToLeft);
    case EditProfilePage.routeName:
      return PageTransition(
          child: const EditProfilePage(), type: PageTransitionType.rightToLeft);

    case PaymentMethodsPage.routeName:
      return PageTransition(
          child: const PaymentMethodsPage(),
          type: PageTransitionType.rightToLeft);
    case AddMomoAccountPage.routeName:
      return PageTransition(
          child: const AddMomoAccountPage(),
          type: PageTransitionType.rightToLeft);
    case RemoveAccountPage.routeName:
      return PageTransition(
          child: const RemoveAccountPage(),
          type: PageTransitionType.rightToLeft);
    case RequestWithdrawalPage.routeName:
      return PageTransition(
          child: RequestWithdrawalPage(), type: PageTransitionType.rightToLeft);
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text('Page not found'),
                ),
                body: const Center(
                  child: Text('Page does not exist'),
                ),
              ));
  }
}
