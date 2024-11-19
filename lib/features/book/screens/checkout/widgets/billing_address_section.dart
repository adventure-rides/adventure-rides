import 'package:adventure_rides/common/widgets/Text/section_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constraints/sizes.dart';
import '../../../../personalization/controllers/address_controller.dart';

class SBillingAddressSection extends StatelessWidget {
  const SBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SSectionHeading(title: 'Pick up Location', buttonTitle: 'Change', onPressed: () => addressController.selectedNewAddressPopup(context)),
        addressController.selectedAddress.value.id.isNotEmpty
            ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Book your tourist car with us', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: SSizes.spaceBtwItems / 2),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 16),
                const SizedBox(width: SSizes.spaceBtwItems),
                Text('+255 345 456789', style: Theme.of(context).textTheme.bodyMedium),

              ],
            ),
            const SizedBox(width: SSizes.spaceBtwItems),
            Row(
              children: [
                const Icon(Icons.location_history, color: Colors.grey, size: 16),
                const SizedBox(height: SSizes.spaceBtwItems),
                Expanded(child: Text('Nambala, Arusha, Nothern Tanzania, Tanzania', style: Theme.of(context).textTheme.bodyMedium, softWrap: true)),

              ],
            ),
          ],
        )
            : Text('Select Address', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
