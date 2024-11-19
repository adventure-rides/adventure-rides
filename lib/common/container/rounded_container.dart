import 'package:flutter/material.dart';

import '../../utils/constraints/colors.dart';
import '../../utils/constraints/sizes.dart';

class SRoundedContainer extends StatelessWidget {
  const SRoundedContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = SSizes.cardRadiusLg,
      this.child,
      this.border,
      this.borderColor = SColors.primary,
      this.backgroundColor = SColors.white,
      this.padding,
      this.margin,
      this.showBorder = false,
      });

  final double? width;
  final double? height;
  final double radius;
  final Widget? child;
  final bool showBorder;
  final BoxBorder? border;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: borderColor) : null,
      ),
      child: child,
    );
  }
}
