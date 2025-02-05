import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/bottom_add_to_book_guide_widget.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/guide_detail_image_slider.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/guide_meta_data.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/guide_languages.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/rating_share_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../controllers/car/cart_controller.dart';
import '../../../car_details/detail_buttons/mobile_book_guide_detail.dart';
import '../../../car_reviews/car_reviews_screen.dart';

class MobileGuideDetail extends StatelessWidget {
  MobileGuideDetail({super.key, required this.guide}) {
    Get.put(CartController());
  }

  final TourGuideModel guide;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    final cartController = CartController.instance;
    return Scaffold(
      bottomNavigationBar: SBottomAddToBookCart(guide: guide), // Custom widget for booking guide
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Guide image slider
            SGuideImageSlider(guide: guide),

            /// Guide details
            Padding(
              padding: EdgeInsets.only(
                  right: SSizes.defaultSpace,
                  left: SSizes.defaultSpace,
                  bottom: SSizes.defaultSpace),
              child: Column(
                children: [
                  /// Rating & share Button
                  SRatingAndShare(),

                  /// Guide fee, name, experience, and availability status
                  SGuideMetaData(guide: guide),

                  /// Languages spoken by the guide
                  const SizedBox(height: SSizes.spaceBtwSections),
                  SGuideLanguages(languages: guide.languages),

                  /// Checkout button
                  const SizedBox(height: SSizes.spaceBtwSections),
                  MobileBookNowGuideDetail(cartController: cartController, guide: guide),

                  const SizedBox(height: SSizes.spaceBtwSections),
                  /// Description
                  const SSectionHeading(title: 'Description', showActionButton: false),
                  const SizedBox(height: SSizes.spaceBtwItems),

                  ReadMoreText(
                    guide.description ?? '',
                    trimLines: 2,
                    trimCollapsedText: ' Show more ',
                    trimMode: TrimMode.Line,
                    trimExpandedText: ' Less ',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// Reviews section
                  const Divider(),
                  const SizedBox(height: SSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SSectionHeading(title: ' Review (199) ', showActionButton: false),
                      IconButton(
                        icon: const Icon(Iconsax.arrow_right3, size: 18),
                        onPressed: () => Get.to(() => const CarReviewsScreen()),
                      ),
                    ],
                  ),
                  const SizedBox(height: SSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}