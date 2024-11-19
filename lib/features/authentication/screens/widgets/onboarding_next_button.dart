import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers_onboarding/onboarding_controller.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    return Positioned(
      right: SSizes.defaultSpace,
      bottom: SDevicesUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(OnBoardingController.instance.currentPageIndex.value + 1),
        style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: dark ? SColors.primary: Colors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}