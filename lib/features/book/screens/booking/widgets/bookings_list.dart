import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/container/rounded_container.dart';
import '../../../../../common/loaders/animation_loader.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/image_strings.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/car/booking_controller.dart';

class SBookingListItems extends StatelessWidget {
  const SBookingListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingController());
    final dark = SHelperFunctions().isDarkMode(context);
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        ///Nothing found widget
        final emptyWidget = SAnimationLoaderWidget(
            text: 'Whoops! No Orders Yet!',
            animation: SImages.pencilAnimation,
          showAction: true,
          actionText: 'Lets fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        ///Helper functions; handle loader, no record or error message
        final response = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        ///Congratulations, record found
        final bookings = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: bookings.length,
          separatorBuilder: (_, __) => const SizedBox(height: SSizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final book = bookings[index];
            return SRoundedContainer(
              showBorder: true,
              padding: const EdgeInsets.all(SSizes.md),
              backgroundColor: dark ? SColors.black : SColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  ///Row 1
                  Row(
                    children: [

                      /// 1 Icon
                      const Icon(Iconsax.ship),
                      const SizedBox(width: SSizes.spaceBtwItems / 2),

                      ///2 Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          //to take only the required space
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.bookingStatusText,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(
                                  color: SColors.primary, fontWeightDelta: 1),
                            ),
                            Text(book.formattedOrderDate, style: Theme
                                .of(context)
                                .textTheme
                                .headlineSmall),
                          ],
                        ),
                      ),

                      ///3 Icon
                      IconButton(onPressed: () {},
                          icon: const Icon(Iconsax.arrow_right_14, size: SSizes
                              .iconSm)),
                    ],
                  ),
                  const SizedBox(height: SSizes.spaceBtwItems),

                  ///Row 2
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [

                            /// 1 Icon
                            const Icon(Iconsax.tag),
                            const SizedBox(width: SSizes.spaceBtwItems / 2),

                            ///2 Status & Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                //to take only the required space
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(book.id,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelMedium),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [

                            /// 1 Icon
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: SSizes.spaceBtwItems / 2),

                            ///2 Status & Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                //to take only the required space
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Booking Date',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelMedium),
                                  Text(book.formattedPickupDate, style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        );
      }
    );
  }
}
