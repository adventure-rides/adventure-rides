import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../../personalization/controllers/user_controller.dart';

class ReAuthLoginForm extends StatelessWidget {
  const ReAuthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(title: const Text('Re-Authenticate User')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Form(
            key: controller.reAuthFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Email
                  TextFormField(
                    controller: controller.verifyEmail,
                    validator: SValidator.validateEmail,
                    decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: SText.email),
                  ),
                  const SizedBox(height: SSizes.spaceBtwInputFields),

                  ///Password
                  Obx( //Observes the value of the hide password field, whenever it change it will redraw
                        () => TextFormField(   //Flat arrow returns only one thing
                      controller: controller.verifyPassword,
                      validator: (value) => SValidator.validateEmptyText('Password', value),//Validate the form field
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

                  /// Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () => controller.reAuthenticateEmailAndPasswordUser(), child: const Text('Verify')),
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
}
