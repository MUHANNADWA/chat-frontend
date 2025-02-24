import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:chatbotstudy/common/widgets/layouts/grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:chatbotstudy/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PrimaryHeaderContainer(
            child: Column(
              children: [
                const HomeAppBar(),
                const SizedBox(height: AppSizes.spaceBtwSections),
              ],
            ),
          ),

          // Choose
          GridLayout(
            itemCount: 4,
            itemBuilder: (context, index) => RoundedContainer(
              // backgroundColor: AppColors.darkerGrey,
              showBorder: true,
              height: 20,
              width: 50,
              child: Center(child: Text('data')),
            ),
          )
        ],
      ),
    );
  }
}
