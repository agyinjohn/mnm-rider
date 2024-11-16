import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:m_n_m_rider/commons/app_colors.dart';
import 'package:m_n_m_rider/widgets/custom_button.dart';
import '../../../../widgets/custom_bottom_sheet.dart';
import '../../../../widgets/custom_textfield.dart';

class RemoveAccountPage extends StatefulWidget {
  const RemoveAccountPage({super.key});
  static const routeName = '/remove-account';
  @override
  State<RemoveAccountPage> createState() => _RemoveAccountPageState();
}

class _RemoveAccountPageState extends State<RemoveAccountPage> {
  final TextEditingController _controllerPassword = TextEditingController();
  bool _isBottomSheetVisible = false;
  bool confirmedOffline = true;

  void showSuccessSheet(BuildContext context) {
    setState(() {
      _isBottomSheetVisible = true;
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SuccessSheet(
        image: 'assets/images/offline.png',
        confirmed: confirmedOffline,
        title: 'Sorry to see you leave',
        message:
            'We will miss you!\nDon\'t forget to come back anytime you feel like',
        buttonText: 'Continue',
        onTapNavigation: '/dashboard',
      ),
    ).whenComplete(() {
      setState(() {
        _isBottomSheetVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.018),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(height: size.height * 0.013),
              Text(
                'Remove Account',
                style: theme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.005),
              Text(
                textAlign: TextAlign.center,
                'Kindly enter your password to remove \nyour account',
                style: theme.bodyMedium,
              ),
              SizedBox(height: size.height * 0.013),
              CustomTextField(
                controller: _controllerPassword,
                isPassword: true,
                prefixIcon: Icons.lock,
                hintText: 'Enter your password',
              ),
              SizedBox(height: size.height * 0.025),
              CustomButton(
                  onTap: () {
                    setState(() {
                      confirmedOffline = !confirmedOffline;
                      showSuccessSheet(context);
                    });
                  },
                  title: 'Confirm')
            ],
          ),
        ),
      ),
    );
  }
}
