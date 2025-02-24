import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/app_rounded_image.dart';
import 'package:chatbotstudy/common/widgets/products/cart/add_remove_button.dart';
import 'package:chatbotstudy/common/widgets/texts/product_price_text.dart';
import 'package:chatbotstudy/common/widgets/texts/product_title_text.dart';
import 'package:chatbotstudy/features/shop/controllers/cart/cart_controller.dart';
import 'package:chatbotstudy/features/shop/models/product_model.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.product,
    this.quantity,
    this.showAddRemoveButtons = true,
  });

  final Product product;
  final int? quantity;
  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Card
        ListTile(
          leading: RoundedImage(
            image: product.image,
            width: 60,
            height: 80,
            padding: EdgeInsets.all(AppSizes.sm),
            backgroundColor:
                AppHelper.isDarkMode ? AppColors.darkerGrey : AppColors.light,
          ),
          // TODO
          title: Text(product.storeId.toString()),
          subtitle: TitleText(title: product.name, maxLines: 1),
        ),

        // Quantity & Price
        showAddRemoveButtons
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 20),

                  /// Add Remove Buttons
                  ProductQuantityWithAddRemoveButton(product: product),

                  // Product Price
                  PriceText(price: product.price),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 20),

                  Text(
                      'Quantity: ${quantity ?? CartController.instance.getQuantity(product.id)}'),

                  // Product Price
                  PriceText(price: product.price),
                ],
              ),
      ],
    );
  }
}
