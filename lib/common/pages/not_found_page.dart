import 'package:chatbotstudy/common/pages/app_default_page.dart';
import 'package:chatbotstudy/utils/constants/image_strings.dart';
import 'package:chatbotstudy/utils/constants/pages.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDefaultPage(
      image: AppImages.onBoardingImage1,
      title: AppTexts.notFoundTitle,
      subTitle: AppTexts.notFoundSubTitle,
      showActionButton: true,
      actionButtonText: AppTexts.returnHome,
      onPressedActionButton: () => Get.offAllNamed(mainScreen),
    );
  }
}
