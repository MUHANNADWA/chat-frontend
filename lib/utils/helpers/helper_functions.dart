import 'dart:math';

import 'package:chatbotstudy/features/authentication/models/user_model.dart';
import 'package:flutter/services.dart';
import '/utils/constants/image_strings.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:universal_html/html.dart';

class AppHelper {
  static User get exampleUser => User(
        id: Random().nextInt(1000),
        firstName: 'John',
        lastName: 'Doe',
        phone: '1234567890',
        image: AppImages.user,
        fatherName: 'father',
        motherName: 'mother',
        fatherPhone: '6413248646',
      );

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
    // enable
    //     ? document.documentElement?.requestFullscreen()
    //     : document.exitFullscreen();
  }

  static void hideKeyboard() {
    Get.focusScope?.unfocus();
  }

  static bool get isDarkMode => Get.isDarkMode;

  static String get currentTheme => Get.theme.toString();

  static String get currentLang => Get.locale.toString().substring(0, 2);
  static String get deviceLang => Get.deviceLocale.toString().substring(0, 2);

  static bool get isRtl => currentLang == 'ar';

  static Size get screenSize => Get.size;
  static double get screenHeight => Get.height;
  static double get screenWidth => Get.width;

  static bool isNetworkImage(String image) =>
      image != AppImages.appLogo &&
      image != AppImages.user &&
      image != AppImages.productImage;

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }
}
