import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../features/book/controllers/tour_guide/guide_controller.dart';
import '../../../../features/book/models/tour_guide_model.dart';
import '../../../../features/book/screens/guide_details/guide_detail.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../cars/favourite_icon/guide_favourite_icon.dart';
import '../../../container/rounded_container.dart';
import '../../../styles/shadows.dart';
import '../../../widgets/Text/guide_title_text.dart';
import '../../../widgets/images/s_rounded_image.dart';
class DesktopGuideCardVertical extends StatelessWidget {
  const DesktopGuideCardVertical({super.key, required this.guide});

  final TourGuideModel guide;

  @override
  Widget build(BuildContext context) {
    final controller = GuideController.instance;
    final dark = SHelperFunctions().isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => GuideDetailScreen(guide: guide), preventDuplicates: false),
      child: Container(
        width: 300,
        constraints: const BoxConstraints(
        maxHeight: 330,
        ),
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [SShadowStyle.verticalCarShadow],
          borderRadius: BorderRadius.circular(SSizes.guideImageRadius),
          color: dark ? SColors.darkerGrey : SColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Tour guide image and favourite icon
            SRoundedContainer(
              height: 200,
              width: double.infinity,
              backgroundColor: dark ? SColors.dark : SColors.light,
              child: Stack(
                children: [
                  ///Tour guide image
                  Center(
                    child: ClipOval(
                      child: SRoundedImage(
                        imageUrl: guide.image,
                        applyImageRadius: true,
                        isNetworkImage: true,
                        fit: BoxFit.cover,
                        width: 200,
                        height: 200,
                      ),
                    ),
                  ),
                  /// Wishlist Icon
                  Positioned(
                    top: 3,
                    right: 3,
                    child: GuideFavouriteIcon(guideId: guide.id),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections / 2),
            /// Guide Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                    /// Guide Fee and Availability
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: SSizes.spaceBtwItems / 4),
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
            ),
          ],
        ),
      ),
    );
  }
}