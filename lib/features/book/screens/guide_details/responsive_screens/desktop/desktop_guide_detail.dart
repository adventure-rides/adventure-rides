import 'package:adventure_rides/features/Effects/vertical_guide_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/bottom_add_to_book_guide_widget.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/guide_meta_data.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/guide_languages.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/rating_share_widget.dart';
import '../../../../../../common/tour_guide/guide_cards/Desktop/desktop_guide_card_vertical.dart';
import '../../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../../common/widgets/layouts/grids/guide_desktop_grid_layout.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/popups/loaders.dart';
import '../../../../controllers/car/cart_controller.dart';
import '../../../../controllers/tour_guide/guide_controller.dart';
import '../../../cart/cart.dart';

class DesktopGuideDetail extends StatelessWidget {
  DesktopGuideDetail({super.key, required this.guide}) {
    Get.put(CartController());
    final guideController = Get.put(GuideController());

    // Fetch guides excluding the current guide
    guideController.fetchAvailableGuidesExcludingCurrent(guide.id);
  }

  final TourGuideModel guide;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    final cartController = CartController.instance;
    final guideController = GuideController.instance;

    return Scaffold(
      bottomNavigationBar: SBottomAddToBookCart(guide: guide),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Section: Guide Image & Details
            Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Guide Image
                  SizedBox(
                    width: 400,
                    height: 400,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        guide.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(width: SSizes.spaceBtwItems),

                  /// Guide Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Rating & Share Button
                        SRatingAndShare(),

                        /// Guide fee, name, experience, and availability
                        SGuideMetaData(guide: guide),

                        /// Languages spoken
                        SGuideLanguages(languages: guide.languages),

                        /// Description
                        const Divider(),
                        const SSectionHeading(
                          title: 'Description',
                          showActionButton: false,
                        ),
                        const SizedBox(height: SSizes.spaceBtwItems),
                        ReadMoreText(
                          guide.description ?? '',
                          trimLines: 2,
                          trimCollapsedText: ' Show more ',
                          trimMode: TrimMode.Line,
                          trimExpandedText: ' Less ',
                          moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                          lessStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        /// Book Now Button
                        const SizedBox(height: SSizes.spaceBtwSections),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (cartController.itemQuantityInCart.value > 0) {
                                cartController.addToCart(guide);
                                Get.to(() => CartScreen());
                              } else {
                                SLoaders.customToast(
                                    message:
                                    'Select a quantity to proceed to bookings');
                              }
                            },
                            child: const Text('Book Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),

            const SizedBox(height: SSizes.spaceBtwSections),

            /// Available Guides Section
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SSectionHeading(
                      title: 'Other Guides You May Like',
                      showActionButton: false),
                  const SizedBox(height: SSizes.spaceBtwItems),

                  /// List of available guides
                  Obx(() {
                    if (guideController.isLoading.value) {
                      return const Center(child: SVerticalGuideShimmer());
                    }

                    return GuideDesktopGridLayout(
                      itemCount: guideController.availableGuides.length,
                      itemBuilder: (context, index) {
                        final otherGuide = guideController.availableGuides[index];
                        return DesktopGuideCardVertical(guide: otherGuide);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}