import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../controllers/car/cart_controller.dart';
import '../../../models/car_model.dart';
import '../../cart/cart.dart';

class MobileBookDetailButton extends StatelessWidget {
  const MobileBookDetailButton({
    super.key,
    required this.cartController,
    required this.car,
  });

  final CartController cartController;
  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center, //align button to the center right
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          if (cartController.itemQuantityInCart.value > 0) {
            cartController.addToCart(car); // Add car to cart
            Get.to(() => CartScreen()); // Navigate to CartScreen
          } else {
            SLoaders.customToast(message: 'Select a quantity to proceed to bookings');
          }
        },
        child: const Text('Book Now'),
      ),
    );
  }
}