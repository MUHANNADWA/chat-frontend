import 'package:flutter/material.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key,
    required this.dividerText,
  });

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Line
        Flexible(
            child: Divider(
          color: AppHelper.isDarkMode ? AppColors.darkGrey : AppColors.grey,
          thickness: 0.5,
          indent: 60,
          endIndent: 5,
        )),

        // OrSignInWith Text
        Text(
          dividerText,
          style: Theme.of(context).textTheme.labelMedium,
        ),

        // Right Line
        Flexible(
          child: Divider(
            color: AppHelper.isDarkMode ? AppColors.darkGrey : AppColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
