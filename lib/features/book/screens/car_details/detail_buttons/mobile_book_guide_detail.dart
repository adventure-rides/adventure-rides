import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/popups/loaders.dart';
import '../../../controllers/car/cart_controller.dart';
import '../../../models/tour_guide_model.dart';
import '../../cart/cart.dart';


class MobileBookNowGuideDetail extends StatelessWidget {
  const MobileBookNowGuideDetail({
    super.key,
    required this.cartController,
    required this.guide,
  });

  final CartController cartController;
  final TourGuideModel guide;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
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
            cartController.addToCart(guide);
            Get.to(() => CartScreen());
          } else {
            SLoaders.customToast(
                message:
                'Select a quantity to proceed to bookings');
          }
        },
        child: const Text('Book Now'),
      ),
    );
  }
}