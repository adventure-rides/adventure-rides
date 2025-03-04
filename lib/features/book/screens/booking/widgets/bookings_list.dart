import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../common/container/rounded_container.dart';
import '../../../../../common/loaders/animation_loader.dart';
import '../../../../../data/repositories/authentication/general_auth_repository.dart';
import '../../../../../navigation_menu.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/image_strings.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/car/booking_controller.dart';
import '../../../models/booking_model.dart';

class SBookingListItems extends StatelessWidget {
  const SBookingListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BookingController());
    final dark = SHelperFunctions().isDarkMode(context);

    return FutureBuilder(
      future: controller.fetchUserBookings(),
      builder: (_, snapshot) {
        /// Nothing found widget
        final emptyWidget = SAnimationLoaderWidget(
          text: 'Whoops! No Bookings Yet!',
          animation: SImages.pencilAnimation,
          showAction: true,
          actionText: 'Let’s fill it',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        /// Handle loader, no record, or error message
        final response = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, nothingFound: emptyWidget);
        if (response != null) return response;

        /// Retrieve user bookings
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
                  /// **Row 1 - Booking Status & Date**
                  Row(
                    children: [
                      const Icon(Iconsax.ship),
                      const SizedBox(width: SSizes.spaceBtwItems / 2),

                      /// **Status & Date**
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.bookingStatusText,
                              style: Theme.of(context).textTheme.bodyLarge!.apply(
                                  color: SColors.primary, fontWeightDelta: 1),
                            ),
                            Text(book.formattedBookingDate,
                                style: Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                      ),

                      /// **Arrow Icon**
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.arrow_right_14, size: SSizes.iconSm),
                      ),
                    ],
                  ),

                  const SizedBox(height: SSizes.spaceBtwItems),

                  /// **Row 2 - Booking Details**
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.tag),
                            const SizedBox(width: SSizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(book.id,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Iconsax.calendar),
                            const SizedBox(width: SSizes.spaceBtwItems / 2),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pickup Date',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  Text(book.formattedPickupDate,
                                      style: Theme.of(context).textTheme.titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: SSizes.spaceBtwItems),

                  /// **Cancellation Policy & Refund**
                  if (!book.isCanceled) ...[
                    Text("Cancel Booking Policy:"),
                    Text(
                      "• 100% refund if canceled 24 hours before pickup.\n"
                          "• 50% refund if canceled within 24 hours before pickup.\n"
                          "• No refund after pickup.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),

                    const SizedBox(height: SSizes.spaceBtwItems),

                    /// **Cancel Booking Button**
                    ElevatedButton(
                      onPressed: () => _cancelBooking(book, context),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          backgroundColor: Colors.red),
                      child: const Text("Cancel Booking"),
                    ),
                  ] else ...[
                    /// **Shows Refund Status if Canceled**
                    Text("Booking Canceled on ${book.formattedCancellationDate}",
                        style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.red)),
                    Text("Refund Status: ${book.refundStatus}",
                        style: Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.green)),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// **Cancel Booking Function**
  Future<void> _cancelBooking(BookingModel book, BuildContext context) async {
    try {
      DateTime now = DateTime.now();
      DateTime pickupDate = book.confirmDate ?? now;
      final userId = GeneralAuthRepository.instance.authUser.uid;

      double refundAmount = 0.0;
      if (now.isBefore(pickupDate.subtract(const Duration(hours: 24)))) {
        refundAmount = book.totalAmount; // 100% Refund
      } else if (now.isBefore(pickupDate)) {
        refundAmount = book.totalAmount * 0.5; // 50% Refund
      } else {
        refundAmount = 0.0; // No Refund
      }

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Bookings')
          .doc(book.id)
          .update({
        "isCanceled": true,
        "cancellationDate": Timestamp.fromDate(now),
        "refundAmount": refundAmount,
      });

      /// Show Alert with Refund Details
      Get.snackbar(
        "Booking Canceled",
        refundAmount > 0
            ? "You have been refunded \$${refundAmount.toStringAsFixed(2)}"
            : "No refund for this cancellation.",
        backgroundColor: refundAmount > 0 ? Colors.green : Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to cancel booking: $e", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}