import 'package:adventure_rides/common/cars/favourite_icon/guide_favourite_icon.dart';
import 'package:adventure_rides/features/book/controllers/tour_guide/guide_controller.dart';
import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../features/book/screens/guide_details/guide_detail.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../container/rounded_container.dart';
import '../../styles/shadows.dart';
import '../../widgets/Text/guide_title_text.dart';
import '../../widgets/images/s_rounded_image.dart';

class SGuideCardVertical extends StatelessWidget {
  const SGuideCardVertical({super.key, required this.guide});

  final TourGuideModel guide;

  @override
  Widget build(BuildContext context) {
    final controller = GuideController.instance;
    final dark = SHelperFunctions().isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => GuideDetailScreen(guide: guide)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [SShadowStyle.verticalCarShadow],
          borderRadius: BorderRadius.circular(SSizes.guideImageRadius),
          color: dark ? SColors.darkerGrey : SColors.white,
        ),
        child: Column(
          children: [
            /// Thumbnail and Favourite Icon
            SRoundedContainer(
              height: 160,
              width: 160,
              padding: const EdgeInsets.all(SSizes.sm),
              backgroundColor: dark ? SColors.dark : SColors.light,
              child: Stack(
                children: [
                  /// Thumbnail Image
                  Center(
                    child: ClipOval(
                      child: SRoundedImage(
                        imageUrl: guide.image,
                        applyImageRadius: true,
                        isNetworkImage: true,
                        fit: BoxFit.cover, // Ensures the image fills the circle
                        width: 160, // Set the same size as height for a circle
                        height: 160,
                      ),
                    ),
                  ),
                  /// Favourite Icon
                  Positioned(
                    top: -8,
                    right: -5,
                    child: GuideFavouriteIcon(guideId: guide.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections / 2),

            /// Guide Details
            Padding(
              padding: const EdgeInsets.only(left: SSizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SGuideTitleText(title: guide.tName, smallSize: true),
                    const SizedBox(height: SSizes.spaceBtwItems / 4),

                    /// Experience
                    Text(
                      '${guide.experience} years of experience',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: SSizes.spaceBtwItems / 4),

                    /// Languages
                    Text(
                      'Languages: ${guide.languages.keys.join(", ")}',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: SSizes.spaceBtwItems / 4),

                    /// Rating
                    Text(
                      'Rating: ${guide.averageRating.toStringAsFixed(1)} ⭐',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),

            /// Guide Fee and Availability
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Fee
                  Flexible(
                    child: Text(
                      '\$${guide.guideFee.toStringAsFixed(2)} / hour',
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  /// Availability Icon

                  Icon(
                    guide.guideAvailability ? Icons.check_circle : Icons.cancel,
                    color: guide.guideAvailability ? SColors.success : SColors.error,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
