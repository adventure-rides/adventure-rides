import 'package:flutter/material.dart';

import '../../common/chips/chip_theme.dart';
import 'custom_themes/appbar_themes.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/elevated_button_theme.dart';
import 'custom_themes/outlined_button_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  //Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    chipTheme: SChipTheme.lightChipTheme,
    checkboxTheme: SCheckboxTheme.lightCheckBoxTheme,
    bottomSheetTheme: SBottomSheetTheme.lightBottomSheetTheme,
    appBarTheme: SAppBarTheme.lightAppBarTheme,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: SElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.lightInputDecorationTheme,
  );

  //Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    chipTheme: SChipTheme.darkChipTheme,
    checkboxTheme: SCheckboxTheme.darkCheckBoxTheme,
    bottomSheetTheme: SBottomSheetTheme.darkBottomSheetTheme,
    appBarTheme: SAppBarTheme.darkAppBarTheme,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    outlinedButtonTheme: SOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: SElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: STextFormFieldTheme.darkInputDecorationTheme,
  );
}