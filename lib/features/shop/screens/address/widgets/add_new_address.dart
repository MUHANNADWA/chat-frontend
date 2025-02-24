import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/features/shop/controllers/addresses/addresses_controller.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/validator/validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatController());

    return Scaffold(
      appBar: const AppAppBar(
        showBackArrow: true,
        title: Text('Add new Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                //
                TextFormField(
                  validator: (value) =>
                      AppValidator.validateEmptyText('Name', value),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),

                SizedBox(height: AppSizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: null,
                        validator: (value) =>
                            AppValidator.validateEmptyText('Address', value),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controller.address,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'Address',
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSizes.defaultSpace),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => controller.addSite(),
                      child: Text('Save')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
