import 'package:flutter/material.dart';

import '../../../utils/constraints/enums.dart';

class SBrandTitleText extends StatelessWidget {
  const SBrandTitleText({
    super.key,
    this.color,
    this.maxLines = 1,
    required this.title,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });
  final String title;
  final int maxLines;
  final Color? color;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      //Check which brand size is required and check that style
      style: brandTextSize == TextSizes.small
        ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : brandTextSize == TextSizes.medium
          ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
          : brandTextSize == TextSizes.large
          ? Theme.of(context).textTheme.bodyMedium!.apply(color: color)
          : Theme.of(context).textTheme.bodyMedium!.apply(color: color),

    );
  }
}
