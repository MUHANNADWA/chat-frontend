import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/styles/spacing_styles.dart';
import 'package:chatbotstudy/features/authentication/screens/login/widgets/login_Header.dart';
import 'package:chatbotstudy/common/widgets/login_signup/form_divider.dart';
import 'package:chatbotstudy/features/authentication/screens/login/widgets/login_form.dart';
import 'package:chatbotstudy/common/widgets/login_signup/other_ways_to_login_buttons.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppHelper.screenWidth < 800
              ? AppSpacingStyles.paddingWithAppBarHeight
              : EdgeInsets.symmetric(
                  horizontal: AppHelper.screenWidth / 4,
                  vertical: AppHelper.screenHeight / 10),
          child: Column(
            children: [
              // Logo, Title and SubTitle
              const LoginHeader(),

              // Login Form
              const LoginForm(),

              // Divider
              FormDivider(dividerText: AppTexts.orSignInWith.toUpperCase()),

              const SizedBox(height: AppSizes.spaceBtwSections),

              // Footer
              const OtherWaysToLoginButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
