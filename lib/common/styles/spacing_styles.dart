import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppSpacingStyles {
  static const paddingWithAppBarHeight = EdgeInsets.fromLTRB(
    AppSizes.defaultSpace,
    AppSizes.appBarHeight,
    AppSizes.defaultSpace,
    AppSizes.defaultSpace,
  );
  static const paddingWithoutBottom = EdgeInsets.fromLTRB(
    AppSizes.defaultSpace,
    AppSizes.defaultSpace,
    AppSizes.defaultSpace,
    0,
  );

  static const paddingWithoutTop = EdgeInsets.fromLTRB(
    AppSizes.defaultSpace,
    0,
    AppSizes.defaultSpace,
    AppSizes.defaultSpace,
  );
}
