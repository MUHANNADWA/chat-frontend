import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: Text(AppTexts.wishlist,
            style: Theme.of(context).textTheme.headlineMedium),
      ),
    );
  }
}
