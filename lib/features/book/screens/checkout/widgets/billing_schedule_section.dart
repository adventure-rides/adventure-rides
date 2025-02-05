import 'package:adventure_rides/features/personalization/controllers/schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:adventure_rides/common/widgets/Text/section_heading.dart';
import 'package:get/get.dart';
import '../../../../../utils/constraints/sizes.dart';

class SBillingScheduleSection extends StatelessWidget {
  const SBillingScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleController = Get.find<ScheduleController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SSectionHeading(
          title: 'My Travel Schedule',
          buttonTitle: 'Change',
          onPressed: () => scheduleController.selectNewSchedulePopup(context),
        ),
        Obx(() {
          if (scheduleController.selectedSchedule.value.id.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Book with us ...', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: SSizes.spaceBtwItems / 2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup Location',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_history, color: Colors.grey, size: 16),
                        const SizedBox(width: SSizes.spaceBtwItems),
                        Text(
                          '${scheduleController.selectedSchedule.value.pickupLocation ?? ''} at ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Expanded(
                          child: Text(
                            '${scheduleController.selectedSchedule.value.pickupTime ?? ''} on ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Text(
                          scheduleController.selectedSchedule.value.pickupDate ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: SSizes.spaceBtwItems),
                    Text(
                      'Dropoff Location',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_history, color: Colors.grey, size: 16),
                        const SizedBox(width: SSizes.spaceBtwItems),
                        Text(
                          '${scheduleController.selectedSchedule.value.dropoffLocation ?? ''} on ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Expanded(
                          child: Text(
                            scheduleController.selectedSchedule.value.dropoffDate ?? '',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                )

              ],
            );
          } else {
            return Text('Select Schedule', style: Theme.of(context).textTheme.bodyMedium, softWrap: true);
          }
        }),
      ],
    );
  }
}