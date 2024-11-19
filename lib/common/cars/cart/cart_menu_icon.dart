import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/book/controllers/car/cart_controller.dart';
import '../../../features/book/screens/cart/cart.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class SCartCounterIcon extends StatelessWidget {
  const SCartCounterIcon({
    super.key,
    this.iconColor,
    this.counterBgColor,
    this.counterTextColor,
  });

  final Color? iconColor, counterBgColor, counterTextColor;

  @override
  Widget build(BuildContext context) {
    // Get an instance of the cart controller
    final controller = Get.put(CartController());

    final dark = SHelperFunctions().isDarkMode(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: Icon(Icons.book_online, color: iconColor),
              onPressed: () => Get.to(() => const CartScreen()),
            ),
            Positioned(
              top: 2, // Adjust the vertical position of the badge
              right: 2, // Adjust the horizontal position of the badge
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: counterBgColor ?? (dark ? SColors.white : SColors.black),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Obx(
                        () => Text(
                      controller.noOfCartItems.value.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .apply(
                        color: counterTextColor ?? (dark ? SColors.black : SColors.white),
                        fontSizeFactor: 0.8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4), // Space between icon and label
        Text(
          "Bookings", // Label text
          style: TextStyle(color: SColors.white),
        ),
      ],
    );
  }
}
