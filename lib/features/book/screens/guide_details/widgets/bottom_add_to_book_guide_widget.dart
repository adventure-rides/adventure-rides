import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:adventure_rides/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/car/cart_controller.dart';

class SBottomAddToBookCart extends StatelessWidget {
  const SBottomAddToBookCart({super.key, required this.guide});

  final TourGuideModel guide;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    controller.updateAlreadyAddedGuideCount(
        guide); // Update count specifically for guide
    final dark = SHelperFunctions().isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SSizes.defaultSpace,
        vertical: SSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? SColors.darkerGrey : SColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(SSizes.cardRadiusLg),
          topRight: Radius.circular(SSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () => controller.itemQuantityInCart.value < 1
                ? null
                : controller.addToCart(guide),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(SSizes.md),
              backgroundColor: SColors.black,
              side: const BorderSide(color: SColors.black),
            ),
            child: const Text('Add to Bookings'),
          ),
        ],
      ),
    );
  }
}
