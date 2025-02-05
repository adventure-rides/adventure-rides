import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constraints/colors.dart';
import '../../utils/device/device_utility.dart';
import '../../utils/helpers/helper_functions.dart';

class SAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading, // Custom leading widget parameter
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,

  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Widget? leading; // New custom leading widget

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    return AppBar(
      automaticallyImplyLeading: false,
      leading: leading ?? // Use custom leading if provided
          (showBackArrow
              ? IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Iconsax.arrow_left, color: dark ? SColors.white : SColors.dark))
              : leadingIcon != null
              ? IconButton(
              onPressed: leadingOnPressed,
              icon: Icon(leadingIcon, color: dark ? SColors.white : SColors.dark))
              : null),
      title: title,
      actions: actions,
      backgroundColor: SColors.primary.withOpacity(0.7),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(SDevicesUtils.getAppBarBarHeight());
}