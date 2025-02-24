import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/pages/app_default_page.dart';
import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:chatbotstudy/common/widgets/layouts/grid_layout.dart';
import 'package:chatbotstudy/common/widgets/products/product_card/product_card.dart';
import 'package:chatbotstudy/common/widgets/shimmer/app_shimmer.dart';
import 'package:chatbotstudy/common/widgets/texts/section_heading.dart';
import 'package:chatbotstudy/features/shop/controllers/search/search_controller.dart';
import 'package:chatbotstudy/features/shop/screens/store/widgets/store_card.dart';
import 'package:chatbotstudy/utils/constants/image_strings.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:get/get.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppSearchController());

    return Scaffold(
      appBar: AppAppBar(
        title: Text(
          'Search Results',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => controller.isLoading.value
                    ? AppShimmer(
                        child: GridLayout(
                          itemCount: 4,
                          itemBuilder: (_, __) => const RoundedContainer(
                              height: 282, backgroundColor: Colors.black),
                        ),
                      )
                    : controller.hasError.value
                        ? const AppDefaultPage(
                            image: AppImages.disconnected,
                            title: 'Oops! Something Went Wrong ',
                            subTitle:
                                'We encountered an error while fetching the product details.')
                        : controller.products.isEmpty &&
                                controller.stores.isEmpty
                            ? const AppDefaultPage(
                                image: AppImages.disconnected,
                                title: 'There Are No Products',
                                subTitle:
                                    'It looks like you haven’t added any Products yet.')
                            : Column(
                                children: [
                                  // Products
                                  if (controller.products.isNotEmpty)
                                    Column(
                                      children: [
                                        const SectionHeading(title: 'Products'),
                                        const SizedBox(
                                            height: AppSizes.defaultSpace),
                                        GridLayout(
                                          itemCount: controller.products.length,
                                          itemBuilder: (_, index) =>
                                              ProductCard(
                                                  product: controller
                                                      .products[index]),
                                        ),
                                      ],
                                    ),

                                  const SizedBox(
                                      height: AppSizes.spaceBtwSections),

                                  // Stores
                                  if (controller.stores.isNotEmpty)
                                    Column(
                                      children: [
                                        const SectionHeading(title: 'Stores'),
                                        const SizedBox(
                                            height: AppSizes.defaultSpace),
                                        GridLayout(
                                          crossAxisCount: 1,
                                          mainAxisExtent: 80,
                                          itemCount: controller.stores.length,
                                          itemBuilder: (_, index) => StoreCard(
                                              store: controller.stores[index]),
                                        ),
                                      ],
                                    )
                                ],
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
