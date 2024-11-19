import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/book/controllers/car/favourites_controller.dart';
import '../../icons/s_circular_icon.dart';

class GuideFavouriteIcon extends StatelessWidget {
  const GuideFavouriteIcon({super.key, required this.guideId});

  final String guideId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(() => SCircularIcon(
      icon: controller.isFavourite(guideId) ? Iconsax.heart5 : Iconsax.heart,
      color: controller.isFavourite(guideId) ? Colors.red : null,
      onPressed: () => controller.toggleFavouriteGuide(guideId),
    ));
  }
}
