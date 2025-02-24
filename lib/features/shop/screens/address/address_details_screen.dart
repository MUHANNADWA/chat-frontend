import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:chatbotstudy/common/widgets/products/cart/cart_item.dart';
import 'package:chatbotstudy/features/authentication/screens/signup/success_screen.dart';
import 'package:chatbotstudy/features/shop/models/product_model.dart';
import 'package:chatbotstudy/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:chatbotstudy/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:chatbotstudy/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:chatbotstudy/main_screen.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/image_strings.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.cartItems});

  final Map<Product, RxInt> cartItems;

  @override
  Widget build(BuildContext context) {
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
          padding: EdgeInsets.all(AppSizes.defaultSpace),
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

              const SizedBox(height: AppSizes.spaceBtwSections),

              // Billing Section
              RoundedContainer(
                padding: EdgeInsets.all(AppSizes.md),
                showBorder: true,
                backgroundColor: AppColors.darkLight,
                child: Column(
                  children: [
                    // Pricing
                    BillingAmountSection(),

                    const SizedBox(height: AppSizes.spaceBtwItems),

                    const Divider(),

                    // Payment Methods
                    BillingPaymentSection(),

                    SizedBox(height: AppSizes.spaceBtwItems),

                    const Divider(),

                    // Address
                    BillingAddressSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(
            () => SuccessScreen(
              image: AppImages.successfulPaymentIcon,
              title: 'Payment Success!',
              subTitle: 'Your Item Will Be Shipped Soon!',
              onPressed: () => Get.offAll(() => const MainScreen()),
            ),
          ),
          child: Text('Checkout \$256.0'),
        ),
      ),
    );
  }
}
