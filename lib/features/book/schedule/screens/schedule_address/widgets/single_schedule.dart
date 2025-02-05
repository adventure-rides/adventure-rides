import 'package:adventure_rides/features/personalization/controllers/schedule_controller.dart';
import 'package:adventure_rides/features/personalization/models/schedule_model.dart';
import 'package:adventure_rides/utils/constraints/sizes.dart';
import 'package:adventure_rides/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../common/container/rounded_container.dart';
import '../../../../../../utils/constraints/colors.dart';

class SingleSchedule extends StatelessWidget {
  const SingleSchedule({
    super.key,
    required this.schedule,
    required this.onTap,
  });

  final ScheduleModel schedule;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = ScheduleController.instance;
    final dark = SHelperFunctions().isDarkMode(context);

    return Obx(() {
      final selectedScheduleId = controller.selectedSchedule.value.id;
      final selectedSchedule = selectedScheduleId == schedule.id;
      return InkWell(
        onTap: onTap,
        child: SRoundedContainer(
          width: double.infinity,
          padding: const EdgeInsets.all(SSizes.md),
          showBorder: true,
          backgroundColor: selectedSchedule ? SColors.primary.withOpacity(0.5) : Colors.transparent,
          borderColor: selectedSchedule ? Colors.transparent : dark ? SColors.darkerGrey : SColors.grey,
          margin: const EdgeInsets.only(bottom: SSizes.spaceBtwItems),
          child: Stack(
            children: [
              // Tick icon visibility
              Positioned(
                right: 5,
                top: 0,
                child: Icon(
                  selectedSchedule ? Iconsax.tick_circle5 : null,
                  color: selectedSchedule ? dark ? SColors.light : SColors.dark: null,
                ),
              ),
              // Schedule details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pickup Location: ${schedule.pickupLocation}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: SSizes.sm / 2),
                  Text("Dropoff Location: ${schedule.dropoffLocation}", maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: SSizes.sm / 2),
                  Text(schedule.toString(), softWrap: true),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}