import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:chatbotstudy/common/widgets/app_bar/app_app_bar.dart';
import 'package:chatbotstudy/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:chatbotstudy/common/widgets/texts/product_title_text.dart';
import 'package:chatbotstudy/common/widgets/texts/section_heading.dart';
import 'package:chatbotstudy/features/authentication/services/auth_service.dart';
import 'package:chatbotstudy/features/shop/controllers/settings/profile_controller.dart';
import 'package:chatbotstudy/features/shop/screens/profile/widgets/edit_profile_menu.dart';
import 'package:chatbotstudy/features/shop/controllers/settings/image_picker_controller.dart';
import 'package:chatbotstudy/utils/constants/image_strings.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';
import 'package:chatbotstudy/utils/constants/text_strings.dart';
import 'package:chatbotstudy/utils/validator/validator.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final imageController = Get.put(ImagePickerController());
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppAppBar(title: Text(AppTexts.profile), showBackArrow: true),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Form(
            key: controller.formKey,
            child: Column(children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    // Profile Picture
                    Center(
                      child: RoundedContainer(
                        radius: 100,
                        height: 80,
                        width: 80,
                        child: Obx(() => imageController.image.value != null
                            ? Image.file(
                                imageController.image.value!,
                                fit: BoxFit.cover,
                              )
                            : AuthService.currentUser.image == AppImages.user
                                ? Image.asset(AppImages.user, fit: BoxFit.cover)
                                : CachedNetworkImage(
                                    imageUrl: AuthService.currentUser.image,
                                    fit: BoxFit.cover)),
                      ),
                    ),

                    TextButton(
                      onPressed: () => imageController.pickImage(),
                      child: TitleText(title: 'Change Profile Picture'),
                    ),
                  ],
                ),
              ),

              // Details
              const SizedBox(height: AppSizes.spaceBtwItems / 2),

              const Divider(),

              const SizedBox(height: AppSizes.spaceBtwItems),

              // Heading Personal Info
              const SectionHeading(title: 'Profile Information'),

              const SizedBox(height: AppSizes.spaceBtwItems),

              EditProfileMenu(
                title: AppTexts.firstName,
                icon: Iconsax.user_edit,
                controller: controller.firstName,
              ),

              EditProfileMenu(
                title: AppTexts.lastName,
                icon: Iconsax.user_edit,
                controller: controller.lastName,
              ),

              EditProfileMenu(
                title: AppTexts.username,
                icon: Iconsax.user_edit,
                controller: controller.username,
              ),

              EditProfileMenu(
                title: AppTexts.email,
                icon: Iconsax.direct,
                controller: controller.email,
                keyboardType: TextInputType.emailAddress,
              ),

              EditProfileMenu(
                title: AppTexts.phoneNo,
                icon: Iconsax.call,
                controller: controller.phone,
                keyboardType: TextInputType.number,
              ),

              EditProfileMenu(
                title: AppTexts.password,
                icon: Iconsax.password_check,
                controller: controller.password,
                showToggle: true,
                validator: (value) =>
                    AppValidator.validateEmptyText(AppTexts.password, value),
              ),

              const SizedBox(height: AppSizes.spaceBtwSections),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.updateUserInfo(
                      profileImage: imageController.image.value),
                  child: const Text('Save Changes'),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
