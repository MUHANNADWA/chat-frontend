import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/pages/app_default_page.dart';
import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:chatbotstudy/common/widgets/layouts/grid_layout.dart';
import 'package:chatbotstudy/common/widgets/products/cart/cart_counter_icon.dart';
import 'package:chatbotstudy/common/widgets/shimmer/app_shimmer.dart';
import 'package:chatbotstudy/features/shop/controllers/stores/stores_controller.dart';
import 'package:chatbotstudy/features/shop/screens/store/widgets/store_card.dart';
import 'package:chatbotstudy/utils/constants/image_strings.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StoresController());

    return Scaffold(
      appBar: AppAppBar(
        title: Text(
          AppTexts.stores,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [CartCounterIcon()],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshStores(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: AppSizes.spaceBtwItems),

              // Stores
              Obx(
                () => controller.isLoading.value
                    ? AppShimmer(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSizes.defaultSpace),
                          child: GridLayout(
                            crossAxisCount: 1,
                            mainAxisExtent: 80,
                            itemCount: 4,
                            itemBuilder: (_, __) => RoundedContainer(
                                height: 80, backgroundColor: Colors.black),
                          ),
                        ),
                      )
                    : controller.hasError.value
                        ? AppDefaultPage(
                            image: AppImages.disconnected,
                            title: 'Oops! Something Went Wrong',
                            subTitle:
                                'We encountered an error while fetching the Store details.')
                        : controller.stores.isEmpty
                            ? AppDefaultPage(
                                image: AppImages.disconnected,
                                title: 'There are no stores',
                                subTitle:
                                    'It looks like there are no stores yet.')
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.defaultSpace),
                                child: GridLayout(
                                  crossAxisCount: 1,
                                  mainAxisExtent: 80,
                                  itemCount: controller.stores.length,
                                  itemBuilder: (_, index) => StoreCard(
                                      store: controller.stores[index]),
                                ),
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
