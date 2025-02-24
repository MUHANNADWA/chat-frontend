import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/styles/spacing_styles.dart';
import 'package:chatbotstudy/features/authentication/screens/login/widgets/login_Header.dart';
import 'package:chatbotstudy/features/authentication/screens/login/widgets/login_form.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: AppHelper.screenWidth < 800
            ? AppSpacingStyles.paddingWithAppBarHeight
            : EdgeInsets.symmetric(
                horizontal: AppHelper.screenWidth / 4,
                vertical: AppHelper.screenHeight / 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo, Title and SubTitle
            const LoginHeader(),

            // Login Form
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}
