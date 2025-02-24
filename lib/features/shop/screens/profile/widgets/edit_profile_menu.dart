import 'package:flutter/material.dart';
import 'package:chatbotstudy/features/shop/controllers/settings/profile_controller.dart';
import 'package:get/get.dart';
import 'package:chatbotstudy/utils/constants/sizes.dart';

class EditProfileMenu extends StatelessWidget {
  const EditProfileMenu({
    super.key,
    required this.title,
    required this.icon,
    this.showToggle = false,
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.visiblePassword,
  });

  final String title;
  final bool showToggle;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppSizes.spaceBtwInputFields / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: TextFormField(
                keyboardType: keyboardType,
                obscuringCharacter: '※',
                obscureText:
                    showToggle ? controller.isPasswordObscured.value : false,
                controller: this.controller,
                validator: validator,
                decoration: InputDecoration(
                  prefixIcon: Icon(icon),
                  suffixIcon: showToggle
                      ? Obx(
                          () => IconButton(
                              icon: controller.passwordIcon.value,
                              onPressed: () =>
                                  controller.togglePasswordVisibility()),
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
