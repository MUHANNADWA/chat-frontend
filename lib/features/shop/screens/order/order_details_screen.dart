import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/pages/app_default_page.dart';
import 'package:chatbotstudy/common/styles/spacing_styles.dart';
import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:chatbotstudy/common/widgets/products/cart/cart_item.dart';
import 'package:chatbotstudy/common/widgets/shimmer/app_shimmer.dart';
import 'package:chatbotstudy/features/shop/controllers/orders/order_products_controller.dart';
import 'package:chatbotstudy/features/shop/models/order_model.dart';
import 'package:chatbotstudy/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:chatbotstudy/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:chatbotstudy/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/image_strings.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderItemsController());
    controller.getOrderItemsByOrderId(order.id);

    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text(
          'Order Details',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Expanded(
        child: RefreshIndicator(
          onRefresh: () => controller.fetchOrderItemsByOrderId(order.id),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: Obx(
              () => controller.isLoading.value
                  ? AppShimmer(
                      child: CartItem(
                        product: AppHelper.exampleProduct,
                        showAddRemoveButtons: false,
                      ),
                    )
                  : controller.hasError.value
                      ? AppDefaultPage(
                          image: AppImages.disconnected,
                          title: 'Oops! Something Went Wrong',
                          subTitle:
                              'We encountered an error while fetching the cart items.')
                      : controller.orderItems.isEmpty
                          ? AppDefaultPage(
                              image: AppImages.disconnected,
                              title: 'There Are No items in cart',
                              subTitle:
                                  'It looks like you haven’t added any items to the cart yet.')
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount:
                                  controller.orderItems[order.id]!.length,
                              separatorBuilder: (_, __) =>
                                  const Divider(height: AppSizes.spaceBtwItems),
                              itemBuilder: (_, index) => CartItem(
                                product: controller.orderItems[order.id]!.keys
                                    .elementAt(index),
                                quantity: controller
                                    .orderItems[order.id]!.values
                                    .elementAt(index),
                                showAddRemoveButtons: false,
                              ),
                            ),
            ),
          ),
        ),
      ),
      // Billing Section
      bottomNavigationBar: Padding(
        padding: AppSpacingStyles.paddingWithoutTop,
        child: RoundedContainer(
          padding: EdgeInsets.all(AppSizes.md),
          showBorder: true,
          backgroundColor: AppColors.darkLight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pricing
              BillingAmountSection(order: order),

              const SizedBox(height: AppSizes.spaceBtwItems),

              const Divider(),

              // Payment Methods
              BillingPaymentSection(),

              SizedBox(height: AppSizes.spaceBtwItems),

              const Divider(),

              // Address
              BillingAddressSection(
                  address: order.site, showChangeButton: false),
            ],
          ),
        ),
      ),
    );
  }
}
