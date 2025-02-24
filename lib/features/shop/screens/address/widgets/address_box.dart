import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:chatbotstudy/features/shop/controllers/addresses/addresses_controller.dart';
import 'package:chatbotstudy/features/shop/controllers/cart/cart_controller.dart';
import 'package:chatbotstudy/features/shop/models/site_model.dart';
import 'package:chatbotstudy/features/shop/screens/address/widgets/edit_address_screen.dart';
import 'package:chatbotstudy/utils/constants/colors.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddressBox extends StatelessWidget {
  const AddressBox(
      {super.key, required this.address, this.activateChangeAddress});

  final Site address;
  final bool? activateChangeAddress;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());
    final cartController = Get.put(CartController());

    return GestureDetector(
      onTap: activateChangeAddress == true
          ? () {
              cartController.activeAddress.value = address;
              Get.back();
            }
          : null,
      child: RoundedContainer(
        padding: const EdgeInsets.all(AppSizes.md),
        width: double.infinity,
        showBorder: true,
        backgroundColor: Colors.transparent,
        borderColor:
            AppHelper.isDarkMode ? AppColors.darkerGrey : AppColors.dark,
        margin: EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  Text(
                    address.address,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  // Edit
                  IconButton(
                      onPressed: () =>
                          Get.to(() => EditAddressScreen(address: address)),
                      icon: Icon(Iconsax.edit)),
                  // Delete
                  IconButton(
                      onPressed: () => controller.deleteSiteById(address.id),
                      icon: Icon(Iconsax.trash)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
