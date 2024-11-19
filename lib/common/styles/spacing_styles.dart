import 'package:flutter/material.dart';

import '../../utils/constraints/sizes.dart';

class SSPacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: SSizes.appBarHeight,
    left: SSizes.defaultSpace,
    bottom: SSizes.defaultSpace,
    right: SSizes.defaultSpace,
  );
}