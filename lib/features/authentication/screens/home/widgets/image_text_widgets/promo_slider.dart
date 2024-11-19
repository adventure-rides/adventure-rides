import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/custom_shapes/containers/circular_container.dart';
import '../../../../../../common/widgets/images/s_rounded_image.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../Effects/shimmer.dart';
import '../../../../../book/controllers/banner_controller.dart';

class SPromoSlider extends StatelessWidget {
  const SPromoSlider({
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
                CarouselSlider(
                  options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      autoPlayCurve: Curves.linear,
                      onPageChanged: (index, _) =>
                          controller.updatePageIndicator(index)),
                  items: controller.banners
                      .map((banner) => SRoundedImage(
                    imageUrl: banner.imageUrl,
                    isNetworkImage: true,
                    onPressed: () => Get.toNamed(banner.targetScreen),
                  ))
                      .toList(),
                ),
                const SizedBox(height: SSizes.spaceBtwItems),
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
