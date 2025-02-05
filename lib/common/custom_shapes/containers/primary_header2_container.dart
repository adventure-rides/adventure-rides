import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/custom_shapes/containers/circular_container.dart';
import '../../../../../../common/widgets/images/desktop_rounded_image.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../features/Effects/shimmer.dart';
import '../../../features/book/controllers/tour_guide/banner_header_controller.dart';
import '../curved_edges/curved_edges_widgets.dart';

class SPrimaryHeader2Container extends StatelessWidget {
  const SPrimaryHeader2Container({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BannerHeaderController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const SShimmerEffect(width: double.infinity, height: 200);
      }

      if (controller.banners.isEmpty) {
        return SCurvedEdgeWidget(
          child: Container(
            color: SColors.bootColor,
            child: const Center(child: Text('No Display Images Found')),
          ),
        );
      }

      return SCurvedEdgeWidget(
        child: Stack(
          children: [
            // Auto-Playing Image with Fading Effect
            SizedBox(
              height: 250,
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 2),
                child: ShaderMask(
                  key: ValueKey(controller.carousalCurrentIndex.value),
                  shaderCallback: (rect) => LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                  ).createShader(rect),
                  blendMode: BlendMode.darken,
                  child: IgnorePointer(
                    child: DesktopRoundedImage(
                      imageUrl: controller
                          .banners[controller.carousalCurrentIndex.value].imageUrl,
                      isNetworkImage: true,
                    ),
                  ),
                ),
              ),
            ),

            // Title and Button
            Positioned(
              bottom: 30,
              left: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.banners[controller.carousalCurrentIndex.value].title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      final route = controller
                          .banners[controller.carousalCurrentIndex.value]
                          .buttonTargetScreen;
                      Get.toNamed(route);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(controller
                          .banners[controller.carousalCurrentIndex.value].buttonText),
                    ),
                  ),
                ],
              ),
            ),

            // Dark Gradient Overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [SColors.black.withOpacity(0.5), Colors.transparent],
                  ),
                ),
              ),
            ),

            // Background Shapes
            Positioned(
              top: -150,
              right: -250,
              child: SCircularContainer(
                backgroundColor: SColors.textWhite.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: SCircularContainer(
                backgroundColor: SColors.textWhite.withOpacity(0.1),
              ),
            ),

            // Child Content
            Positioned.fill(child: child),

            // Dots Indicator
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      SCircularContainer(
                        width: 20,
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        backgroundColor: controller.carousalCurrentIndex.value == i
                            ? SColors.primary
                            : SColors.grey,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}