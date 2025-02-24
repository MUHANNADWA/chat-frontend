import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/styles/spacing_styles.dart';
import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:chatbotstudy/common/widgets/products/cart/cart_item.dart';
import 'package:chatbotstudy/features/shop/controllers/cart/cart_controller.dart';
import 'package:chatbotstudy/features/shop/controllers/orders/orders_controller.dart';
import 'package:chatbotstudy/features/shop/models/product_model.dart';
import 'package:chatbotstudy/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:chatbotstudy/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:chatbotstudy/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.cartItems});

  final Map<Product, RxInt> cartItems;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final orderController = Get.put(OredrsController());

    return Scaffold(
      appBar: AppAppBar(
        showBackArrow: true,
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              // Items In Cart
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (_, index) => CartItem(
                    product: cartItems.keys.elementAt(index),
                    showAddRemoveButtons: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Checkout Button
      bottomNavigationBar: Padding(
        padding: AppSpacingStyles.paddingWithoutTop,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Billing Section
            RoundedContainer(
              padding: const EdgeInsets.all(AppSizes.md),
              showBorder: true,
              backgroundColor: AppColors.darkLight,
              child: Column(
                children: [
                  // Pricing
                  BillingAmountSection(totalPrice: controller.getTotalPrice()),

                  const SizedBox(height: AppSizes.spaceBtwItems),

                  const Divider(),

                  // Payment Methods
                  const BillingPaymentSection(),

                  const SizedBox(height: AppSizes.spaceBtwItems),

                  const Divider(),

                  // Address
                  Obx(
                    () => BillingAddressSection(
                        address: controller.activeAddress.value),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwItems),

            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.activeAddress.value.address !=
                          AppHelper.exampleSite.address
                      ? () async {
                          await orderController.addOrder(controller.cartItems);
                          controller.clearCart();
                        }
                      : null,
                  child: const Text('Send The Genie! (Order Now)'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
