import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:chatbotstudy/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

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
          Expanded(
            child: ListView(
                padding: EdgeInsets.symmetric(vertical: AppSizes.sm),
                children: [
                  ListTile(
                    title: 'Discover the library',
                    icon: Iconsax.book,
                  ),
                  ListTile(
                    title: 'Generate tests',
                    icon: Iconsax.teacher,
                  ),
                  ListTile(
                    title: 'Parental Control',
                    icon: Iconsax.safe_home,
                  ),
                  ListTile(
                    title: 'Gamification System',
                    icon: Iconsax.gameboy,
                  ),
                  ListTile(
                    title: 'Recent Activities',
                    icon: Iconsax.receipt_minus,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class ListTile extends StatelessWidget {
  const ListTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.lg, vertical: AppSizes.sm),
        child: RoundedContainer(
          height: 115,
          showBorder: true,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: AppSizes.iconLg),
            SizedBox(width: AppSizes.md),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
          ]),
        ),
      ),
    );
  }
}
