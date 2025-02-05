import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/appbar/appbar.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/address_controller.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
      appBar:
          const SAppBar(showBackArrow: true, title: Text('Add new Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.name,
                    validator: (value) => SValidator.validateEmptyText('Name', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.user), labelText: 'Name'),
                ),
                const SizedBox(height: SSizes.spaceBtwInputFields),

                TextFormField(
                    controller: controller.phoneNumber,
                    validator: SValidator.validatePhoneNumber,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.mobile),
                        labelText: 'Phone Number'),
                ),
                const SizedBox(height: SSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          controller: controller.street,
                          validator: (value) => SValidator.validateEmptyText('Street', value),
                          decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building_31),
                                labelText: 'Street'),
                        ),
                    ),
                    const SizedBox(width: SSizes.spaceBtwInputFields),
                    Expanded(
                        child: TextFormField(
                            controller: controller.postalCode,
                            validator: (value) => SValidator.validateEmptyText('Postal Code', value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.code),
                                labelText: 'Postal Code'),
                        ),
                    ),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            controller: controller.city,
                            validator: (value) => SValidator.validateEmptyText('City', value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.building),
                                labelText: 'City'),
                        ),
                    ),
                    const SizedBox(width: SSizes.spaceBtwInputFields),
                    Expanded(
                        child: TextFormField(
                            controller: controller.state,
                            validator: (value) => SValidator.validateEmptyText('State', value),
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Iconsax.activity),
                                labelText: 'State'),
                        ),
                    ),
                  ],
                ),
                const SizedBox(height: SSizes.spaceBtwInputFields),
                TextFormField(
                    controller: controller.country,
                    validator: (value) => SValidator.validateEmptyText('Country', value),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.global),
                        labelText: 'Country'),
                ),
                const SizedBox(height: SSizes.defaultSpace),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Save'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}