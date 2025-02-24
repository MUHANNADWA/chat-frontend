import 'package:flutter/material.dart';
import 'package:chatbotstudy/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';
import 'package:chatbotstudy/utils/device/device_utility.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppDeviceUtils.appBarHeight,
      right: AppHelper.isRtl ? null : AppSizes.defaultSpace,
      left: AppHelper.isRtl ? AppSizes.defaultSpace : null,
      child: TextButton(
          onPressed: OnBoardingController.instance.skipPage,
          child: Text(AppTexts.skip)),
    );
  }
}
