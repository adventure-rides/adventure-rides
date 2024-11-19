import 'package:adventure_rides/common/cars/favourite_icon/guide_favourite_icon.dart';
import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_rides/features/book/controllers/tour_guide/guide_images_controller.dart';
import '../../../../../common/appbar/appbar.dart';
import '../../../../../common/custom_shapes/curved_edges/curved_edges_widgets.dart';
import '../../../../../common/widgets/images/s_rounded_image.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';


class SGuideImageSlider extends StatelessWidget {
  const SGuideImageSlider({
    super.key,
    required this.guide,

  });
  final TourGuideModel guide;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    final controller = Get.put(GuideImagesController());
    final images = controller.getAllGuideImages(guide);
    return SCurvedEdgeWidget(
      child: Container(
        color: dark ? SColors.darkerGrey : SColors.light,
        child: Stack(
          children: [
            ///Main large image
            SizedBox(
              height: 400,
              child: Padding(
                padding:
                const EdgeInsets.all(SSizes.carImageRadius * 2),
                child: Center(
                    child: Obx( () {
                      final image = controller.selectedGuideImage.value;
                      return GestureDetector(
                        onTap: () => controller.showEnlargedImage(image),
                        child: CachedNetworkImage(imageUrl: image, progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress, color: SColors.primary),
                        ),
                      );
                    }
                    )),
              ),
            ),

            ///Image slider
            Positioned(
              right: 0,
              bottom: 30,
              left: SSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: SSizes.spaceBtwItems),
                  itemCount: images.length,
                  shrinkWrap: true, // to utilize the available screen
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Obx(
                    () {
                      final imageSelected = controller.selectedGuideImage.value == images[index];
                      return SRoundedImage(
                        width: 80,
                        isNetworkImage: true,
                        backgroundColor: dark ? SColors.dark : SColors.white,
                        onPressed: () => controller.selectedGuideImage.value = images[index],
                        border: Border.all(color: imageSelected ? SColors.primary : Colors.transparent),
                        padding: const EdgeInsets.all(SSizes.sm),
                        imageUrl: images[index],
                      );
                    },
                  ),
                ),
              ),
            ),
            ///Appbar
            SAppBar(
              showBackArrow: true,
              actions: [GuideFavouriteIcon(guideId: guide.id)],
            ),
          ],
        ),
      ),
    );
  }
}
