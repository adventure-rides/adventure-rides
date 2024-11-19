import 'package:flutter/material.dart';

import '../../utils/constraints/colors.dart';
import '../../utils/constraints/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class SCircularIcon extends StatelessWidget {
  /// A custom circular icon widget with a background color
  ///

  const SCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = SSizes.lg,
    this.backgroundColor,
    this.color,
    required this.icon,
    this.onPressed,
  });

  final double? width, height, size;
  final Color? backgroundColor, color;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor != null
          ? backgroundColor!
        : SHelperFunctions().isDarkMode(context)
          ? SColors.black.withOpacity(0.9)
        : SColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(100),

      ),
      child: IconButton(onPressed: onPressed, icon: Icon(icon, color: color, size: size)),
    );
  }
}
