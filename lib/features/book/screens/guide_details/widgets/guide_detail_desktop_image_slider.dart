import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_rides/features/book/controllers/tour_guide/guide_images_controller.dart';
import '../../../../../common/custom_shapes/curved_edges/curved_edges_widgets.dart';
import '../../../../../common/styles/shadows.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class GuideDetailDesktopImageSlider extends StatelessWidget {
  const GuideDetailDesktopImageSlider({
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
            /// Main large image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(SSizes.carImageRadius * 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedGuideImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: SColors.primary,
                            ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            /// Image slider
            Positioned(
              right: 0,
              bottom: 30,
              left: SSizes.defaultSpace,
              child: SizedBox(
                height: 100,
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                  const SizedBox(width: SSizes.spaceBtwItems),
                  itemCount: images.length,
                  shrinkWrap: true, // to utilize the available screen
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Obx(
                        () {
                      final imageSelected =
                          controller.selectedGuideImage.value ==
                              images[index];
                      return GestureDetector(
                        onTap: () => controller.selectedGuideImage.value =
                        images[index],
                        child: ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              boxShadow: [SShadowStyle.verticalCarShadow],
                              borderRadius: BorderRadius.circular(SSizes.guideImageRadius),
                              color: dark ? SColors.darkerGrey : SColors.white,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: images[index],
                              fit: BoxFit.fill,
                              progressIndicatorBuilder:
                                  (_, __, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  color: SColors.primary,
                                ),
                              ),
                              errorWidget: (_, __, ___) =>
                                  Icon(Icons.error, color: SColors.error),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            /// Appbar
            //FixedScreenAppbar(),
          ],
        ),
      ),
    );
  }
}
