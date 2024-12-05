<<<<<<< HEAD
import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
=======
>>>>>>> 4b76d60b99720174ae25fd9ddff4e7b6f0f5fffe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/custom_shapes/curved_edges/curved_edges_widgets.dart';
import '../../../../../../common/widgets/images/s_rounded_image.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../controllers/car/images_controller.dart';
import '../../../../models/car_model.dart';

<<<<<<< HEAD
=======

>>>>>>> 4b76d60b99720174ae25fd9ddff4e7b6f0f5fffe
class DesktopCarImageSlider extends StatelessWidget {
  const DesktopCarImageSlider({
    super.key,
    required this.car,
<<<<<<< HEAD
=======

>>>>>>> 4b76d60b99720174ae25fd9ddff4e7b6f0f5fffe
  });
  final CarModel car;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    final controller = Get.put(ImageController());
    final images = controller.getAllCarImages(car);
    return SCurvedEdgeWidget(
      child: Container(
        color: dark ? SColors.darkerGrey : SColors.light,
        child: Stack(
          children: [
            ///Main large image
            SizedBox(
              height: 500,
              child: Padding(
<<<<<<< HEAD
                padding: EdgeInsets.all(SSizes.carImageRadius * 2),
                child: Center(child: Obx(() {
                  final image = controller.selectedCarImage.value;
                  return GestureDetector(
                    onTap: () => controller.showEnlargedImage(image),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      progressIndicatorBuilder: (_, __, downloadProgress) =>
                          CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: SColors.primary),
                    ),
                  );
                })),
=======
                padding:
                EdgeInsets.all(SSizes.carImageRadius * 2),
                child: Center(
                    child: Obx( () {
                      final image = controller.selectedCarImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(imageUrl: image, progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress, color: SColors.primary),
                        ),
                      );
                    }
                    )),
>>>>>>> 4b76d60b99720174ae25fd9ddff4e7b6f0f5fffe
              ),
            ),

            ///Image slider
            Positioned(
              right: 0,
              bottom: 20,
              left: SSizes.defaultSpace,
              child: Align(
                alignment: Alignment.center, // Centers the slider horizontally
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                    separatorBuilder: (_, __) =>
<<<<<<< HEAD
                        const SizedBox(width: SSizes.spaceBtwItems),
=======
                    const SizedBox(width: SSizes.spaceBtwItems),
>>>>>>> 4b76d60b99720174ae25fd9ddff4e7b6f0f5fffe
                    itemCount: images.length,
                    shrinkWrap: true, // to utilize the available screen
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => Obx(
                      () {
<<<<<<< HEAD
                        final imageSelected =
                            controller.selectedCarImage.value == images[index];
=======
                        final imageSelected = controller.selectedCarImage.value == images[index];
>>>>>>> 4b76d60b99720174ae25fd9ddff4e7b6f0f5fffe
                        return SRoundedImage(
                          width: 100,
                          isNetworkImage: true,
                          backgroundColor: dark ? SColors.dark : SColors.white,
<<<<<<< HEAD
                          onPressed: () =>
                              controller.selectedCarImage.value = images[index],
                          border: Border.all(
                              color: imageSelected
                                  ? SColors.primary
                                  : Colors.transparent),
=======
                          onPressed: () => controller.selectedCarImage.value = images[index],
                          border: Border.all(color: imageSelected ? SColors.primary : Colors.transparent),
>>>>>>> 4b76d60b99720174ae25fd9ddff4e7b6f0f5fffe
                          padding: const EdgeInsets.all(SSizes.sm),
                          imageUrl: images[index],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
<<<<<<< HEAD

            ///Appbar
            FixedScreenAppbar(),
=======
            ///Appbar
            //FixedScreenAppbar(),
>>>>>>> 4b76d60b99720174ae25fd9ddff4e7b6f0f5fffe
            //SAppBar(showBackArrow: true, actions: [SFavouriteIcon(carId: car.id)],),
          ],
        ),
      ),
    );
  }
}
