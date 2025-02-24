import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chatbotstudy/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/device/device_utility.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppDeviceUtils.bottomNavigationBarHeight,
      right: AppHelper.isRtl ? null : AppSizes.defaultSpace,
      left: AppHelper.isRtl ? AppSizes.defaultSpace : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor:
              AppHelper.isDarkMode ? AppColors.primary : AppColors.black,
        ),
        onPressed: OnBoardingController.instance.nextPage,
        child: Icon(
            AppHelper.isRtl ? Iconsax.arrow_left_2 : Iconsax.arrow_right_3),
      ),
    );
  }
}
