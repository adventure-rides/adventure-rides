import 'package:adventure_rides/utils/constraints/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/icons/s_circular_icon.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../controllers/car/cart_controller.dart';
import '../../../models/car_model.dart';

class SBottomAddToCart extends StatelessWidget {
  SBottomAddToCart({super.key, required this.car}){
    Get.put(CartController()); // Ensures the controller is available
  }

  final CarModel car;


  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    //final controller = Get.put(CartController());
    controller.updateAlreadyAddedCarCount(car); // Update the quantity if car already exists in the cart
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
      child: Obx(
            () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SCircularIcon(
                  icon: Iconsax.minus,
                  backgroundColor: SColors.darkGrey,
                  width: 40,
                  height: 40,
                  color: SColors.white,
                  onPressed: () {
                    if (controller.itemQuantityInCart.value > 0) {
                      controller.itemQuantityInCart.value -= 1; // Decrease quantity
                    }
                  },
                ),
                const SizedBox(width: SSizes.spaceBtwItems),
                Text(
                  controller.itemQuantityInCart.value.toString(),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: SSizes.spaceBtwItems),
                SCircularIcon(
                  icon: Iconsax.add,
                  backgroundColor: SColors.black,
                  width: 40,
                  height: 40,
                  color: SColors.white,
                  onPressed: () {
                    controller.itemQuantityInCart.value += 1; // Increase quantity
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.itemQuantityInCart.value > 0) {
                  controller.addToCart(car); // Add the car to the cart
                } else {
                  // Optionally, show a message if no quantity is selected
                  SLoaders.customToast(message: 'Select a quantity to add to bookings');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(SSizes.md),
                backgroundColor: SColors.black,
                side: const BorderSide(color: SColors.black),
              ),
              child: const Text('Add to Bookings'),
            ),
          ],
        ),
      ),
    );
  }
}