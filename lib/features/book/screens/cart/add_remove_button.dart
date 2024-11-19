import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/icons/s_circular_icon.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SCarQualityWithAddRemoveButton extends StatelessWidget {
  const SCarQualityWithAddRemoveButton({
    super.key, required this.quantity, this.add, this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: SSizes.md,
          color: SHelperFunctions().isDarkMode(context) ? SColors.white: SColors.black,
          backgroundColor: SHelperFunctions().isDarkMode(context) ? SColors.darkerGrey: SColors.light,
          onPressed: remove,
        ),
        const SizedBox(width: SSizes.spaceBtwItems),
        Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: SSizes.spaceBtwItems),

        SCircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: SSizes.md,
          color: SColors.white,
          backgroundColor: SColors.primary,
          onPressed: add,
        ),
      ],
    );
  }
}
