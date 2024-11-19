import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/appbar/appbar.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../../authentication/controllers_backend/update/update_name_controller.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      ///Custom Appbar
      appBar: SAppBar(
        showBackArrow: true,
        title: Text('Change Name', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Headings
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            //Text field and button
            Form(
              key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) => SValidator.validateEmptyText('First name', value),
                      expands: false,
                      decoration: const InputDecoration(labelText: SText.firstName, prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(height: SSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) => SValidator.validateEmptyText('Last name', value),
                      expands: false,
                      decoration: const InputDecoration(labelText: SText.lastName, prefixIcon: Icon(Iconsax.user)),
                    ),
                  ],
                )
            ),
            const SizedBox(height: SSizes.spaceBtwSections),
            
            ///Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.updateUserName(), child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
