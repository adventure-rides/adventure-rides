import 'package:adventure_rides/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../data/repositories/authentication/general_auth_repository.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers_backend/login/login_controller.dart';
import '../../signup/signup.dart';

class SLoginForm extends StatelessWidget {
  const SLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SSizes.spaceBtwSections),
        child: Column(
          children: [
            ///Email
            TextFormField(
              controller: controller.email,
              validator: (value) => SValidator.validateEmail(value),
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right),labelText: SText.email),
            ),
            const SizedBox(height: SSizes.spaceBtwInputFields),

            ///Password
            Obx( //Observes the value of the hide password field, whenever it change it will redraw
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

            const SizedBox(height: SSizes.spaceBtwInputFields / 2),
            ///Remember me and Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember me
                Row(
                  children: [
                    Obx(() => Checkbox(value: controller.rememberMe.value, onChanged: (value) => controller.rememberMe.value = !controller.rememberMe.value)),
                    const Text(SText.rememberMe),
                  ],
                ),
                ///Forget Password
                TextButton(onPressed: () => Get.toNamed(SRoutes.forgetPassword), child: const Text(SText.forgetPassword),)
              ],
            ),
            const SizedBox(height: SSizes.spaceBtwSections),
            ///Sign In Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Register AuthenticationRepository only when Sign In button is pressed
                  Get.put(GeneralAuthRepository.instance);

                  // Now call the email and password sign-in function
                  await controller.emailAndPasswordSignIn();
                },
                child: const Text(SText.signIn),
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwItems),
            ///Create account Button
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Get.to(() => const SignupScreen()), child: const Text(SText.createAccount))),

          ],
        ),
      ),
    );
  }
}
