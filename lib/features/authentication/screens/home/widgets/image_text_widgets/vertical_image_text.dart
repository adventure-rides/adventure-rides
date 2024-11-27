import 'package:flutter/material.dart';
import '../../../../../../common/widgets/images/s_circular_image.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';

class SVerticalImageText extends StatelessWidget {
  const SVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = SColors.white,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.onTap,
  });
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: SSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular icon
            SCircularImage(
              image: image,
              fit: BoxFit.fill, //use also BoxFit.cover
              padding: 2,
              //padding: SSizes.sm * 1.4,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              //overlayColor: dark ? SColors.light : SColors.dark,
        ),

            const SizedBox(height: SSizes.spaceBtwItems / 2),
            SizedBox(
              width: 55,
              child: Text(
                title,  // Use title parameter instead of hardcoded text
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}