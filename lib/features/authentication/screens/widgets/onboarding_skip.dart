import 'package:flutter/material.dart';

import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../controllers_onboarding/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: SDevicesUtils.getAppBarBarHeight(),
      right: SSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(OnBoardingController.instance.currentPageIndex.value),
        child: const Text('Skip'),
      ),
    );
  }
}