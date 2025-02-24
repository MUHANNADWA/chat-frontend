import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';
import 'package:chatbotstudy/utils/device/device_utility.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';
import 'package:chatbotstudy/utils/locale/locale_controller.dart';

class OnBoardingChangeLang extends StatelessWidget {
  const OnBoardingChangeLang({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: AppDeviceUtils.appBarHeight,
      right: AppHelper.isRtl ? AppSizes.defaultSpace : null,
      left: AppHelper.isRtl ? null : AppSizes.defaultSpace,
      child: TextButton(
          onPressed: () => AppLocaleController.instance.toggleLang(),
          child: Row(
            children: [
              Text('${AppTexts.changeLang}  '),
              CountryFlag.fromLanguageCode(
                AppHelper.currentLang == 'ar' ? 'en' : 'ar-sy',
                width: 18,
                height: 12,
              ),
            ],
          )),
    );
  }
}
