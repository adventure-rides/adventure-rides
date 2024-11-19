import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/constraints/text_strings.dart';
import '../../controllers_onboarding/onboarding_controller.dart';
import '../widgets/onboarding_dot_navigation.dart';
import '../widgets/onboarding_next_button.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/onboarding_skip.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          ///Horizontal scrollable pages

          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children:  const [
              OnBoardingPage(
                image: SImages.onBoardingImage1,
                title: SText.onBoardingTitle1,
                subTitle: SText.onBoardingTitle1,
              ),
              OnBoardingPage(
                image: SImages.onBoardingImage2,
                title: SText.onBoardingTitle2,
                subTitle: SText.onBoardingTitle2,
              ),
              OnBoardingPage(
                image: SImages.onBoardingImage3,
                title: SText.onBoardingTitle3,
                subTitle: SText.onBoardingTitle3,
              ),
            ],
          ),

          ///Skip Button
          const OnBoardingSkip(),

          ///Dot Navigation Smooth Indicator
          const OnBoardingDotNavigation(),

          ///Circular Button
          const OnBoardingNextButton(),

        ],
      ),
    );
  }
}


