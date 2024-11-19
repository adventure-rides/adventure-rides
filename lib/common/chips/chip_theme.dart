import 'package:flutter/material.dart';

import '../../utils/constraints/colors.dart';

class SChipTheme {
  SChipTheme._();

  static ChipThemeData lightChipTheme = const ChipThemeData(
    disabledColor: SColors.grey,//add opacity
    labelStyle: TextStyle(color: SColors.black),
    selectedColor: SColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: SColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: SColors.darkerGrey,
    labelStyle: TextStyle(color: SColors.white),
    selectedColor: SColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: SColors.white,
  );
}