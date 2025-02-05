import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_rides/features/book/controllers/tour_guide/guide_images_controller.dart';
import '../../../../../common/custom_shapes/curved_edges/curved_edges_widgets.dart';
import '../../../../../utils/constraints/colors.dart';
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
            /// Main large image
            SizedBox(
              height: 300, // Set the desired height here
              width: double.infinity, // Ensure it spans the full width
              child: Obx(() {
                final image = controller.selectedGuideImage.value;
                return GestureDetector(
                  onTap: () => controller.showEnlargedImage(image),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover, //fill// Ensure the image fills the height and width
                    progressIndicatorBuilder: (_, __, downloadProgress) =>
                        Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: SColors.primary,
                          ),
                        ),
                    errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}