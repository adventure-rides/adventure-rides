import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/Text/guide_fee_text.dart';
import '../../../../../common/widgets/Text/guide_title_text.dart';
import '../../../../../common/widgets/images/s_circular_image.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/tour_guide/guide_controller.dart';

class SGuideMetaData extends StatelessWidget {
  SGuideMetaData({super.key, required this.guide}) {
    Get.put(GuideController()); // Ensures the controller is available
  }

  final TourGuideModel guide;

  @override
  Widget build(BuildContext context) {
    final controller = GuideController.instance;
    final darkMode = SHelperFunctions().isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Guide Fee
        Row(
          children: [
            SGuideFeeText(
              fee: controller.getGuideFee(guide),
              isLarge: true,
            ),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 1.5),

        /// Guide Name
        SGuideTitleText(title: guide.tName),
        const SizedBox(height: SSizes.spaceBtwItems / 1.5),

        /// Guide Reg no
        //SGuideTitleText(title: guide.guideRegNo),
        SGuideTitleText(title: 'RegNo: ${guide.guideRegNo}'),
        const SizedBox(height: SSizes.spaceBtwItems / 1.5),

        /// Availability Status
        Row(
          children: [
            const SGuideTitleText(title: 'Availability'),
            const SizedBox(width: SSizes.spaceBtwItems),
            Text(
              guide.guideAvailability ? 'Available' : 'Not Available',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: guide.guideAvailability ? SColors.success : SColors.error,
              ),
            ),
          ],
        ),
        const SizedBox(height: SSizes.spaceBtwItems / 1.5),

        /// Profile Image and Languages
        Row(
          children: [
            SCircularImage(
              image: guide.image,
              width: 32,
              height: 32,
              overlayColor: darkMode ? SColors.white : SColors.dark,
            ),
            const SizedBox(width: SSizes.spaceBtwItems),
            Expanded(
              child: Text(
                'Languages: ${guide.languages.keys.join(", ")}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
