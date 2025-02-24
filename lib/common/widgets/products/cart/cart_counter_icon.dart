import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/products/cart/cart_badge.dart';
import 'package:chatbotstudy/features/shop/screens/cart/cart_screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
    this.cartColor,
    this.badgeColor,
  });

  final Color? cartColor, badgeColor;

  @override
  Widget build(BuildContext context) {
    return CartBadge(
      badgeColor: badgeColor,
      child: IconButton(
        onPressed: () => Get.to(() => CartScreen()),
        icon: Icon(
          Iconsax.shopping_bag,
          color: cartColor ?? (AppColors.darkLightInvert),
        ),
      ),
    );
  }
}
