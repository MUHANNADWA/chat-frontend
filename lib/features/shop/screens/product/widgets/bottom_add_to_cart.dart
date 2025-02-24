import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/icons/app_circular_icons.dart';
import 'package:chatbotstudy/features/shop/controllers/cart/cart_controller.dart';
import 'package:chatbotstudy/features/shop/models/product_model.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.defaultSpace,
        vertical: AppSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: AppHelper.isDarkMode ? AppColors.darkerGrey : AppColors.light,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(AppSizes.cardRadiusLg),
          topLeft: Radius.circular(AppSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircularIcon(
                icon: Iconsax.minus,
                backgroundColor: AppColors.darkGrey,
                width: 40,
                height: 40,
                color: AppColors.white,
                onPressed: () => controller.decreaseQuantity(product),
              ),

              const SizedBox(width: AppSizes.spaceBtwItems),

              // Quantity
              Obx(
                () => Text(
                  controller.getQuantity(product.id).toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),

              const SizedBox(width: AppSizes.spaceBtwItems),

              CircularIcon(
                icon: Iconsax.add,
                backgroundColor: AppColors.black,
                width: 40,
                height: 40,
                color: AppColors.white,
                onPressed: () => controller.increaseQuantity(product),
              ),
            ],
          ),
          Obx(() {
            final productQuantity = controller.getQuantity(product.id);
            final isButtonEnabled = product.stock > 0 && productQuantity > 0;

            return ElevatedButton(
              onPressed:
                  isButtonEnabled ? () => controller.addToCart(product) : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(AppSizes.md),
                backgroundColor: AppColors.black,
                side: const BorderSide(color: AppColors.black),
              ),
              child: const Text('Add To Cart'),
            );
          }),
        ],
      ),
    );
  }
}
