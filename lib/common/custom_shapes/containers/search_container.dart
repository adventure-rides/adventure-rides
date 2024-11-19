import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/sizes.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class SSearchContainer extends StatelessWidget {
  const SSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace),
        child: Container(
          width: SDevicesUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(SSizes.md),
          decoration: BoxDecoration(
              color: showBackground
                  ? dark
                      ? SColors.dark
                      : SColors.light
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(SSizes.cardRadiusLg),
              border: showBorder ? Border.all(color: SColors.grey) : null),
          child: Row(
            children: [
              Icon(icon, color: SColors.darkerGrey),
              const SizedBox(width: SSizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
