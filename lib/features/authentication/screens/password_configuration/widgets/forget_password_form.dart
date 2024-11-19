import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers_backend/forget_password/forget_password_controller.dart';

class ForgetPasswordForm extends StatelessWidget {
  const ForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Headings
          IconButton(onPressed: () => Get.back(), icon: const Icon(Iconsax.arrow_left)),
          const SizedBox(height: SSizes.spaceBtwItems),
          Text(SText.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: SSizes.spaceBtwItems),
          Text(SText.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: SSizes.spaceBtwSections * 2),

          ///Text field
          Form(
            key: controller.forgetPasswordFormKey,
            child: TextFormField(
              controller: controller.email,
              validator: SValidator.validateEmail,
              decoration: const InputDecoration(labelText: SText.email, prefixIcon: Icon(Iconsax.direct_right)),

            ),
          ),
          const SizedBox(height: SSizes.spaceBtwSections),
          ///Submit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () => controller.sendPasswordResetEmail(), child: const Text(SText.submit)),
          ),
          const SizedBox(height: SSizes.spaceBtwSections * 2),
        ],

      );
  }
}
