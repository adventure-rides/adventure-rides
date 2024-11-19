import 'package:flutter/material.dart';
import '../common/container/rounded_container.dart';
import '../common/widgets/Text/s_brand_title_text_with_verified_icon.dart';
import '../common/widgets/images/s_circular_image.dart';
import '../features/book/models/brand_model.dart';
import '../utils/constraints/enums.dart';
import '../utils/constraints/sizes.dart';
import '../utils/helpers/helper_functions.dart';


class SBrandCard extends StatelessWidget {
  const SBrandCard({
    super.key,
    this.onTap,
    required this.showBorder,
    required this.brand,
  });
  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = SHelperFunctions().isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      ///Container design
      child: SRoundedContainer(
        padding: const EdgeInsets.all(SSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            ///Icon
            Flexible(   //Wrap with flexible widget to adjust the space accordingly
              child: SCircularImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                //overlayColor: isDark ? SColors.white : SColors.black,
              ),
            ),
            const SizedBox(width: SSizes.spaceBtwSections / 2),

            /// text

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min, // to align the text vertically
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SBrandTitleWithVerifiedIcon(title: brand.name, brandTextSize: TextSizes.large),
                  Text(
                    '${brand.productsCount ?? 0} products ', //Wrap with a string since 0 is not a string
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,

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
