// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/device/device_utility.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.backArrowColor,
    this.showBackArrow = false,
  });

  final Widget? title;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final bool showBackArrow;
  final bool? backArrowColor;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: title,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: AppHelper.isRtl
                    ? Icon(
                        Iconsax.arrow_right_1,
                        color: backArrowColor ?? AppHelper.isDarkMode
                            ? AppColors.white
                            : AppColors.dark,
                      )
                    : Icon(
                        Iconsax.arrow_left,
                        color: backArrowColor ?? AppHelper.isDarkMode
                            ? AppColors.white
                            : AppColors.dark,
                      ),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon),
                  )
                : null,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppDeviceUtils.appBarHeight);
}
