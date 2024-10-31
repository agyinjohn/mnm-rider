import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mnm_vendor/screens/bussiness_info.dart';
// import 'package:mnm_vendor/screens/dashboard_page.dart';
// import 'package:mnm_vendor/screens/face_id_page.dart';
// import 'package:mnm_vendor/screens/upload_id_page.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/providers/provider.dart';
import '../../widgets/bussiness_info.dart';
import 'face_id_page.dart';
import 'home_page.dart';
import 'upload_id_page.dart';

class KycVerificationScreen extends ConsumerStatefulWidget {
  const KycVerificationScreen({super.key});
  static const routeName = '/verification-page';
  @override
  _KycVerificationScreenState createState() => _KycVerificationScreenState();
}

class _KycVerificationScreenState extends ConsumerState<KycVerificationScreen> {
  final int _currentStep = 0; // 0-based index for steps

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final completedSteps = ref.watch(stepStateProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.04),
            _buildSegmentedProgressBar(completedSteps),
            SizedBox(height: size.height * 0.04),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.025),
                child: ListView(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/ID Card.gif',
                          height: size.height * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    const Text(
                      "Let's verify your identity",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.height * 0.008),
                    const Text(
                      "Please upload these documents to verify your KYC.",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.height * 0.008),
                    _buildStepItem(
                        0,
                        'Take a picture of your Ghana Card.',
                        'assets/images/image 35.png',
                        IDVerificationScreen.routeName),
                    _buildStepItem(
                        1,
                        'Take a picture of your face.',
                        'assets/images/image 37.png',
                        FaceDetectionPage.routeName),
                    _buildStepItem(2, 'Enter your business info.',
                        'assets/images/image 37.png', BussinessInfo.routeName),
                    SizedBox(height: size.height * 0.028),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the "Why is this needed?" info page

                          Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                duration: const Duration(milliseconds: 1000),
                                child: const RiderHomeScreen(),
                                type: PageTransitionType.rightToLeft,
                              ),
                              (route) => false);
                        },
                        child: const Text(
                          'Skip for now',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom segmented progress bar with gaps
  Widget _buildSegmentedProgressBar(List<bool> completedSteps) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: _buildProgressSegment(isCompleted: completedSteps[0])),
          _buildProgressGap(),
          Expanded(
              child: _buildProgressSegment(isCompleted: completedSteps[1])),
          _buildProgressGap(),
          Expanded(
              child: _buildProgressSegment(isCompleted: completedSteps[2])),
        ],
      ),
    );
  }

  // Function to build individual progress segment
  Widget _buildProgressSegment({required bool isCompleted}) {
    return Container(
      // width: 80,
      height: 8,
      decoration: BoxDecoration(
        color: isCompleted ? Colors.orange : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // Function to build a gap between progress segments
  Widget _buildProgressGap() {
    return const SizedBox(width: 8); // Adjust the gap width if needed
  }

  // Function to build each step item with checkmark
  Widget _buildStepItem(
      int index, String title, String iconPath, String routeName) {
    final completedSteps = ref.watch(stepStateProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Image.asset(iconPath, width: 40),
          title: Text(title),
          trailing: completedSteps[index]
              ? const Icon(Icons.check_circle, color: Colors.green)
              : const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: () {
            Navigator.pushNamed(context, routeName);
          },
        ),
      ),
    );
  }
}
