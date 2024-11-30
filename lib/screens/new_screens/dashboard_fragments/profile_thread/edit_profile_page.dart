import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:m_n_m_rider/commons/app_colors.dart';
import 'package:m_n_m_rider/widgets/custom_button.dart';
import '../../../../widgets/custom_textfield.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});
  static const routeName = '/edit-profile';
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(IconlyLight.arrow_left_2),
              onPressed: () {
                Navigator.of(context).pop();
              },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),
        title: Text(
          'Edit Account Details',
          style: theme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.018),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.025),
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: size.width * 0.16,
                        backgroundImage:
                            const AssetImage('assets/images/profile-pic.png'),
                      ),
                      Positioned(
                        bottom: 3,
                        right: 8,
                        child: Container(
                          width: size.width * 0.08,
                          height: size.width * 0.08,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              size: size.width * 0.06,
                              IconlyLight.camera,
                              color: AppColors.onPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.013),
                  Text(
                    'John Kwaku Agyin',
                    style:
                        theme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
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
              ),
            ),
            SizedBox(height: size.height * 0.028),
            Text('Number', style: theme.titleMedium),
            SizedBox(height: size.height * 0.008),
            const CustomTextField2(
              hintText: 'Enter new number',
              isPassword: false,
            ),
            SizedBox(height: size.height * 0.018),
            Text('Email', style: theme.titleMedium),
            SizedBox(height: size.height * 0.008),
            const CustomTextField2(
              hintText: 'Enter new email',
              isPassword: false,
            ),
            SizedBox(height: size.height * 0.018),
            Text('New password', style: theme.titleMedium),
            SizedBox(height: size.height * 0.008),
            const CustomTextField2(
              hintText: 'Enter new password',
              isPassword: true,
            ),
            SizedBox(height: size.height * 0.018),
            Text('Confirm new password', style: theme.titleMedium),
            SizedBox(height: size.height * 0.008),
            const CustomTextField2(
              hintText: 'Enter new password',
              isPassword: true,
            ),
            SizedBox(height: size.height * 0.028),
            CustomButton(onTap: () {}, title: 'Confirm'),
          ],
        ),
      ),
    );
  }
}
