import 'package:adventure_rides/common/widgets/images/desktop_rounded_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/custom_shapes/containers/circular_container.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../Effects/shimmer.dart';
import '../../../../../book/controllers/banner_controller.dart';

class PromoSliderDesktop extends StatelessWidget {
  const PromoSliderDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());

    return Obx(() {
      // Loader
      if (controller.isLoading.value) {
        return const SShimmerEffect(width: double.infinity, height: 190);
      }

      // No data found
      if (controller.banners.isEmpty) {
        return const Center(child: Text('No Data Found!'));
      } else {
        return Column(
          children: [
            SizedBox(
              height: 420, // Fixed height for the slider
              width: double.infinity, // Ensures full width
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: controller.banners.length,
                    itemBuilder: (context, index) {
                      final banner = controller.banners[index];
                      return AnimatedOpacity(
                        duration: const Duration(seconds: 1),
                        opacity: controller.carousalCurrentIndex.value == index ? 1.0 : 0.0,
                        child: DesktopRoundedImage(
                          imageUrl: banner.imageUrl,
                          isNetworkImage: true,
                          onPressed: () => Get.toNamed(banner.targetScreen),
                        ),
                      );
                    },
                    onPageChanged: (index) {
                      controller.updatePageIndicator(index);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwItems),
            // Dots indicator
            Center(
              child: Obx(
                    () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      SCircularContainer(
                        width: 20,
                        height: 4,
                        margin: const EdgeInsets.only(right: 10),
                        backgroundColor: controller.carousalCurrentIndex.value == i
                            ? SColors.primary
                            : SColors.grey,
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}