import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart'; // For navigation

class SearchContainerTablet extends StatelessWidget {
  const SearchContainerTablet({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace),
    required this.onSearchSelected,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Function(String) onSearchSelected;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SSizes.searchSpace),
        child: Container(
          width: SDevicesUtils.getScreenWidth(context),
          height: SSizes.searchHeight,
          padding: const EdgeInsets.all(SSizes.xs),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                ? SColors.dark
                : SColors.light
                : Colors.transparent,
            borderRadius: BorderRadius.circular(SSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: SColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: SColors.darkerGrey),
              const SizedBox(width: SSizes.spaceBtwItems),
              Flexible(child: Text(text, style: Theme.of(context).textTheme.bodySmall)),
              const Spacer(),
              DropdownButton<String>(
                hint: Text("Select..."),
                icon: const Icon(Icons.arrow_drop_down),
                items: [
                  DropdownMenuItem(
                    value: 'Cars',
                    child: Text('Cars'),
                  ),
                  DropdownMenuItem(
                    value: 'Guides',
                    child: Text('Guides'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    onSearchSelected(value); // Call the callback
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}