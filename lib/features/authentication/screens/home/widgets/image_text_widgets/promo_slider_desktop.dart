import 'package:adventure_rides/common/widgets/images/desktop_rounded_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/custom_shapes/containers/circular_container.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../Effects/shimmer.dart';
import '../../../../../book/controllers/banner_controller.dart';

class PromoSliderDesktop extends StatelessWidget {
  const PromoSliderDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
        (){
          //Loader
          if (controller.isLoading.value) return const SShimmerEffect(width: double.infinity, height: 190);

          // No data found
          if(controller.banners.isEmpty){
            return const Center(child: Text('No Data Found!'));
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 420, // Fixed height for the slider
                  width: double.infinity, // Ensures full width
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      autoPlayCurve: Curves.linear,
                      onPageChanged: (index, _) => controller.updatePageIndicator(index),
                    ),
                    items: controller.banners.map((banner) {
                      return Positioned.fill(
                        child: DesktopRoundedImage(
                          imageUrl: banner.imageUrl,
                          isNetworkImage: true,
                          fit: BoxFit.fitWidth, // Ensure it covers the entire area
                          onPressed: () => Get.toNamed(banner.targetScreen),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
                //CarouselSlider dots begins here
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
                )
              ],
            );
          }
        },
    );
  }
}