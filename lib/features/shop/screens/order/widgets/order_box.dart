import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:chatbotstudy/common/widgets/texts/product_price_text.dart';
import 'package:chatbotstudy/features/shop/controllers/orders/orders_controller.dart';
import 'package:chatbotstudy/features/shop/models/order_model.dart';
import 'package:chatbotstudy/features/shop/screens/order/order_details_screen.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class OrderBox extends StatelessWidget {
  const OrderBox({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OredrsController());

    return RoundedContainer(
      padding: const EdgeInsets.all(AppSizes.md),
      showBorder: true,
      backgroundColor: AppColors.darkLight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row
          Row(
            children: [
              // Icon
              const Icon(Iconsax.ship),
              const SizedBox(width: AppSizes.spaceBtwItems / 2),

              // Status & Date
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.status,
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: AppColors.primary,
                            fontWeightDelta: 1,
                          ),
                    ),
                    Text(order.createdAt,
                        style: Theme.of(context).textTheme.headlineSmall!),
                  ],
                ),
              ),

              // Icon
              IconButton(
                onPressed: () => Get.to(() => OrderDetailsScreen(order: order)),
                icon: const Icon(Iconsax.arrow_right_34),
                iconSize: AppSizes.iconSm,
              ),
            ],
          ),

          const SizedBox(height: AppSizes.spaceBtwItems),

          //Row 2
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    // Icon
                    const Icon(Iconsax.money),
                    const SizedBox(width: AppSizes.spaceBtwItems / 2),

                    // Status & Date
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Price',
                              style: Theme.of(context).textTheme.labelMedium),
                          PriceText(price: order.totalPrice),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    // Icon
                    const Icon(Iconsax.tag),
                    const SizedBox(width: AppSizes.spaceBtwItems / 2),

                    // Status & Date
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Order',
                              style: Theme.of(context).textTheme.labelMedium),
                          Text('# ${order.id}',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => controller.deleteOrderById(order.id),
                icon: const Icon(Iconsax.trash),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
