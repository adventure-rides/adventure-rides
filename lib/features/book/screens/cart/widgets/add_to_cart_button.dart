import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/enums.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../controllers/car/cart_controller.dart';
import '../../../models/car_model.dart';
import '../../car_details/car_detail.dart';

class CarCardAddToCartButton extends StatelessWidget {
  const CarCardAddToCartButton({super.key, required this.car});

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return InkWell(
      onTap: () {
        if (car.carType == CarType.single.toString()) {
          // Prepare the cart item and add it to the cart
          final cartItem = cartController.convertToCartItem(car, 1);
          cartController.addToCart(car); // Change this to add to cart directly
        } else {
          // Navigate to the car detail screen for multi-option cars
          Get.to(() => CarDetailScreen(car: car));
        }
      },
      child: Obx(() {
        // Get the current quantity of the car in the cart
        final carQuantityInCart = cartController.getCarQuantityInCart(car.id);

        return Container(
          decoration: BoxDecoration(
            color: carQuantityInCart > 0 ? SColors.primary : SColors.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(SSizes.cardRadiusMd),
              bottomRight: Radius.circular(SSizes.carImageRadius),
            ),
          ),
          child: SizedBox(
            width: SSizes.iconLg * 1.2,
            height: SSizes.iconLg * 1.2,
            child: carQuantityInCart > 0
                ? Text(
              carQuantityInCart.toString(),
              style: Theme.of(context).textTheme.bodyLarge!.apply(color: SColors.white),
            )
                : const Icon(Iconsax.add, color: SColors.white),
          ),
        );
      }),
    );
  }
}
