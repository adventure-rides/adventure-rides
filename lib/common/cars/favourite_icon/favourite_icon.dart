import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/book/controllers/car/favourites_controller.dart';
import '../../icons/s_circular_icon.dart';

class SFavouriteIcon extends StatelessWidget {
  const SFavouriteIcon({super.key, required this.carId});

  final String carId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(() => SCircularIcon(
        icon: controller.isFavourite(carId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavourite(carId) ? Colors.red : null,
      onPressed: () => controller.toggleFavouriteCar(carId),
    ));
  }
}
