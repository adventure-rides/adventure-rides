import 'package:adventure_rides/features/authentication/screens/signup/signup_widgets/terms_conditions_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers_backend/signup/signup_controller.dart';

class SSignupForm extends StatelessWidget {
  const SSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          /// First & Last Name
          Wrap(
            spacing: SSizes.spaceBtwInputFields,
            runSpacing: SSizes.spaceBtwInputFields,
            children: [
              TextFormField(
                controller: controller.firstName,
                validator: (value) => SValidator.validateEmptyText('First name', value),//Validate the form field
                decoration: const InputDecoration(
                  labelText: SText.firstName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
              ///Last name
              TextFormField(
                controller: controller.lastName,
                validator: (value) => SValidator.validateEmptyText('Last name', value),//Validate the form field
                decoration: const InputDecoration(
                  labelText: SText.lastName,
                  prefixIcon: Icon(Iconsax.user),
                ),
              ),
            ],
          ),
          const SizedBox(height: SSizes.spaceBtwInputFields),

          /// Username
          TextFormField(
            controller: controller.username,
            validator: (value) => SValidator.validateEmptyText('Username', value),//Validate the form field
            decoration: const InputDecoration(
              labelText: SText.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: SSizes.spaceBtwInputFields),
          ///Email
          TextFormField(
            controller: controller.email,
            validator: (value) => SValidator.validateEmail(value),//Validate the form field
            decoration: const InputDecoration(
              labelText: SText.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: SSizes.spaceBtwInputFields),
          ///Phone number
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => SValidator.validatePhoneNumber(value),//Validate the form field
            decoration: const InputDecoration(
              labelText: SText.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: SSizes.spaceBtwInputFields),
          ///Password
          Obx(
            () => TextFormField(   //Flat arrow returns only one thing
              controller: controller.password,
              validator: (value) => SValidator.validatePassword(value),//Validate the form field
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: SText.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye),
                ),
              ),
            ),
          ),
          const SizedBox(height: SSizes.spaceBtwSections),

          /// Terms & Conditions Check Box
          const STermsAndConditions(),
          const SizedBox(height: SSizes.spaceBtwSections),

          /// Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(SText.createAccount)),
          ),
        ],
      ),
    );
  }
}
