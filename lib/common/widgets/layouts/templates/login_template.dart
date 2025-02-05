import 'package:flutter/material.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/spacing_styles.dart';

/// Template for the login page layout
class SLoginTemplate extends StatelessWidget {
  const SLoginTemplate({super.key, required this.child});

  /// The widget to be displayed inside the login template
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    return Center(
      child: SizedBox(
        width: 500, // initial 550
        child: SingleChildScrollView(
          child: Container(
            padding: SSPacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SSizes.cardRadiusLg),
              color: dark ? SColors.black : Colors.white,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}