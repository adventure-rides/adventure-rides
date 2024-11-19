import 'package:adventure_rides/common/widgets/Text/s_brand_title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/enums.dart';
import '../../../utils/constraints/sizes.dart';


class SBrandTitleWithVerifiedIcon extends StatelessWidget {
  const SBrandTitleWithVerifiedIcon({
    super.key,
    this.textColor,
    this.maxLines = 1,
    required this.title,
    this.iconColor = SColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });
  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: SBrandTitleText(
              title: title,
              color: textColor,
              maxLines: maxLines,
              brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: SSizes.xs),
        const Icon(Iconsax.verify5,
            color: SColors.primary, size: SSizes.iconXs),
      ],
    );
  }
}