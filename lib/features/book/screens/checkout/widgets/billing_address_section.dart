import 'package:flutter/material.dart';
import 'package:adventure_rides/common/widgets/Text/section_heading.dart';
import 'package:get/get.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../personalization/controllers/address_controller.dart';
import '../../../../personalization/controllers/schedule_controller.dart';
import '../../../schedule/controllers/travel_schedule_controller.dart';

class SBillingAddressSection extends StatelessWidget {
  const SBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    final scheduleController = Get.put(ScheduleController()); //scheduleController
    final travelController = TravelScheduleController(); // Ensure correct instance is used

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SSectionHeading(
          title: 'My Travel Schedule',
          buttonTitle: 'Change',
          onPressed: () => scheduleController.selectNewSchedulePopup(context),
          //onPressed: () => addressController.selectedNewAddressPopup(context),
        ),
        // Display schedule information
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Book with us ...', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: SSizes.spaceBtwItems / 2),
            /*
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 16),
                const SizedBox(width: SSizes.spaceBtwItems),
                Text('+255 345 456789', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: SSizes.spaceBtwItems),
            Row(
              children: [
                const Icon(Icons.location_history, color: Colors.grey, size: 16),
                const SizedBox(width: SSizes.spaceBtwItems),
                Expanded(
                  child: Text(
                    'Nambala, Arusha, Northern Tanzania, Tanzania',
                    style: Theme.of(context).textTheme.bodyMedium,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            */
            const SizedBox(height: SSizes.spaceBtwItems),
            // Display saved schedule information using ValueListenableBuilder
            ValueListenableBuilder<bool>(
              valueListenable: travelController.isRoundTrip,
              builder: (context, isRoundTrip, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey, size: 16),
                        const SizedBox(width: SSizes.spaceBtwItems),
                        Text('Pickup Location: ${travelController.pickupLocationController.text}', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: SSizes.spaceBtwItems /4),
                    Row(
                      children: [
                        const Icon(Icons.date_range, color: Colors.grey, size: 16),
                        const SizedBox(width: SSizes.spaceBtwItems),
                        Text('Pickup Date: ${travelController.pickupDateController.text}', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: SSizes.spaceBtwItems /4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.grey, size: 16),
                        const SizedBox(width: SSizes.spaceBtwItems),
                        Text('Pickup Time: ${travelController.pickupTimeController.text}', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: SSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey, size: 16),
                        const SizedBox(width: SSizes.spaceBtwItems),
                        Text('Dropoff Location: ${travelController.dropoffLocationController.text}', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: SSizes.spaceBtwItems /4),
                    Row(
                      children: [
                        const Icon(Icons.date_range, color: Colors.grey, size: 16),
                        const SizedBox(width: SSizes.spaceBtwItems),
                        Text('Dropoff Date: ${travelController.dropoffDateController.text}', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: SSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.grey, size: 16),
                        const SizedBox(width: SSizes.spaceBtwItems),
                        Text('Dropoff Time: ${travelController.dropoffTimeController.text}', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    const SizedBox(height: SSizes.spaceBtwItems / 2),
                    Row(
                      children: [
                        const Icon(Icons.roundabout_right, color: Colors.grey, size: 16),
                        const SizedBox(width: SSizes.spaceBtwItems),
                        Text('Round Trip: ${isRoundTrip ? 'Yes' : 'No'}', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}