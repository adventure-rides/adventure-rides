import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/custom_shapes/curved_edges/curved_edges_widgets.dart';
import '../../../../../common/widgets/images/s_rounded_image.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/car/images_controller.dart';
import '../../../models/car_model.dart';

class SCarImageSlider extends StatelessWidget {
  const SCarImageSlider({
    super.key,
    required this.car,
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
            /// Main large image
            SizedBox(
              height: 300,
              width: double.infinity, // Ensure it spans the full width
              child: Obx(() {
                final image = controller.selectedCarImage.value;
                return GestureDetector(
                  onTap: () => controller.showEnlargedImage(image),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover, // Fill the container while maintaining aspect ratio
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

            /// Image slider
            Positioned(
              right: 0,
              bottom: 30,
              left: SSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(width: SSizes.spaceBtwItems),
                  itemCount: images.length,
                  shrinkWrap: true, // Utilize available screen space
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected = controller.selectedCarImage.value == images[index];
                    return SRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      backgroundColor: dark ? SColors.dark : SColors.white,
                      onPressed: () => controller.selectedCarImage.value = images[index],
                      border: Border.all(color: imageSelected ? SColors.primary : Colors.transparent),
                      padding: const EdgeInsets.all(SSizes.sm),
                      imageUrl: images[index],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}