import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/pages/app_default_page.dart';
import 'package:chatbotstudy/common/styles/spacing_styles.dart';
import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:chatbotstudy/common/widgets/icons/app_circular_icons.dart';
import 'package:chatbotstudy/common/widgets/layouts/grid_layout.dart';
import 'package:chatbotstudy/common/widgets/products/product_card/product_card.dart';
import 'package:chatbotstudy/common/widgets/shimmer/app_shimmer.dart';
import 'package:chatbotstudy/features/shop/controllers/wishlist/wishlist_controller.dart';
import 'package:chatbotstudy/utils/constants/image_strings.dart';
import 'package:chatbotstudy/utils/constants/pages.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WishlistController());

    return Scaffold(
      appBar: AppAppBar(
          title: Text(AppTexts.wishlist,
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            CircularIcon(
                icon: Iconsax.add, onPressed: () => Get.toNamed(homeScreen))
          ]),
      body: RefreshIndicator(
        onRefresh: () => controller.fetchWishlist(),
        child: SingleChildScrollView(
          child: Padding(
            padding: AppSpacingStyles.paddingWithoutBottom,
            child: Obx(
              () => controller.isLoading.value
                  ? AppShimmer(
                      child: GridLayout(
                        itemCount: 4,
                        itemBuilder: (_, __) => RoundedContainer(
                            height: 282, backgroundColor: Colors.black),
                      ),
                    )
                  : controller.hasError.value
                      ? AppDefaultPage(
                          image: AppImages.canNotDeliver,
                          title: "Oops! Wishlist Fetch Failed",
                          subTitle:
                              "There was an issue retrieving your wishlist items. Please refresh or check back in a few moments.")
                      : controller.favourites.isEmpty
                          ? AppDefaultPage(
                              image: AppImages.prepairingOrder,
                              title: "Wishlist is Empty",
                              subTitle:
                                  "It looks like you haven’t added any items to your wishlist yet. Browse through our catalog and add your favorite items!")
                          : GridLayout(
                              itemCount: controller.favourites.length,
                              itemBuilder: (_, index) => ProductCard(
                                product: controller.favourites[index],
                              ),
                            ),
            ),
          ),
        ),
      ),
    );
  }
}
