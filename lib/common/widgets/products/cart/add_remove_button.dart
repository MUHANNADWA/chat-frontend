import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/icons/app_circular_icons.dart';
import 'package:chatbotstudy/features/shop/controllers/cart/cart_controller.dart';
import 'package:chatbotstudy/features/shop/models/product_model.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductQuantityWithAddRemoveButton extends StatelessWidget {
  const ProductQuantityWithAddRemoveButton({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decrease
        CircularIcon(
          onPressed: () => controller.decreaseQuantity(product),
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: AppSizes.md,
          color: AppColors.darkLightInvert,
          backgroundColor:
              AppHelper.isDarkMode ? AppColors.darkerGrey : AppColors.light,
        ),

        const SizedBox(width: AppSizes.spaceBtwItems),

        // Quantity
        Obx(
          () => Text(controller.getQuantity(product.id).toString(),
              style: Theme.of(context).textTheme.titleSmall),
        ),

        const SizedBox(width: AppSizes.spaceBtwItems),

        // Increase
        CircularIcon(
          onPressed: () => controller.increaseQuantity(product),
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: AppSizes.md,
          color: AppColors.white,
          backgroundColor: AppColors.primary,
        ),
      ],
    );
  }
}
