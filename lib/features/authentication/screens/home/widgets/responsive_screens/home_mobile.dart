import 'package:adventure_rides/common/custom_shapes/containers/primary_header2_container.dart';
import 'package:adventure_rides/common/tour_guide/guide_cards/guide_card_vertical.dart';
import 'package:adventure_rides/features/authentication/screens/home/other_screens_appbar/mobile_home_appbar.dart';
import 'package:adventure_rides/features/book/controllers/car/mobile_car_controller.dart';
import 'package:adventure_rides/features/book/screens/all_guides/all_tour_guides.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../common/cars/cars_cards/mobile/mobile_car_card_vertical.dart';
import '../../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../../data/repositories/car/car_repository.dart';
import '../../../../../../data/repositories/tour_guide/guide_repository.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../Effects/vertical_car_shimmer.dart';
import '../../../../../Effects/vertical_guide_shimmer.dart';
import '../../../../../book/controllers/tour_guide/guide_controller.dart';
import '../../../../../book/screens/all_cars/all_cars.dart';

class HomeScreenMobile extends StatelessWidget {
  HomeScreenMobile({super.key});

  // ScrollController to control the scrolling
  final ScrollController _scrollController = ScrollController();

  // GlobalKeys to reference sections at the search bar
  final GlobalKey _carsSectionKey = GlobalKey();
  final GlobalKey _guidesSectionKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MobileTCarController());
    final carRepository = Get.put(CarRepository());
    final guideController = Get.put(GuideController());
    final guideRepository = Get.put(GuideRepository());

    return Scaffold(
      /// Appbar
    appBar: PreferredSize(
        preferredSize: Size.fromHeight(SDevicesUtils.getAppBarBarHeight()), // the height of the AppBar
        child: const MobileHomeAppbar(), // The fixed AppBar
      ),
      body: SingleChildScrollView(
        controller: _scrollController, // Assign the controller
        child: Column(
          children: [
            /// Header - The image slide show, the SPrimaryHeader2Container for mobile
            SPrimaryHeader2Container(
              child: Column(
                children: [
                  const SizedBox(height: SSizes.spaceBtwSections),
                  ///Buttons to scroll to car and tour guide section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the buttons horizontally
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace/2), // Add padding around the button
                        child: TextButton(
                          onPressed: () => _scrollToSection(_carsSectionKey), // Scroll to car section
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent, // Make the button background transparent
                            side: BorderSide(color: Theme.of(context).dividerColor), // Border to make it stand out
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding inside the button
                          ),
                          child: Text(
                            'Go to Cars',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: SColors.bootColor, // Button text color based on theme
                              //color: Theme.of(context).textTheme.bodyLarge?.color, // Button text color based on theme
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace/2), // Add padding around the button
                        child: TextButton(
                          onPressed: () => _scrollToSection(_guidesSectionKey), // Scroll to guides section
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent, // Make the button background transparent
                            side: BorderSide(color: Theme.of(context).dividerColor), // Border to make it stand out
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24), // Padding inside the button
                          ),
                          child: Text(
                            'Go to Guides',
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: SColors.bootColor, // Button text color based on theme
                              //color: Theme.of(context).textTheme.bodyLarge?.color, // Button text color based on theme
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: SSizes.spaceBtwSections),

                ],
              ),
            ),
            /// Body
            Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace / 2),

              /// Promotion slider
              child: Column(
                children: [
                  //const SPromoSlider(),
                  //const SizedBox(height: SSizes.spaceBtwSections),
                  /// Heading for popular tourist cars
                  SSectionHeading(
                    title: 'Popular Tourist Cars',
                    key: _carsSectionKey, // Attach key to the section
                    onPressed: () => Get.to(() => AllCars(
                      title: 'Popular Tourist Cars',
                      futureMethod: carRepository.getAllFeaturedCarS(),
                    )),
                  ),
                  const SizedBox(height: SSizes.spaceBtwItems),

                  /// Popular Tourist Cars
                  Obx(() {
                    if (controller.isLoading.value) return const SVerticalCarShimmer();

                    if (controller.featuredCars.isEmpty) {
                      return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return SGridLayout(
                      itemCount: controller.featuredCars.length,
                      itemBuilder: (_, index) => MobileCarCardVertical(car: controller.featuredCars[index]),
                    );
                  }),

                  const SizedBox(height: SSizes.spaceBtwSections),

                  /// Tour Guides heading
                  SSectionHeading(
                    title: 'Popular Tour Guides',
                    key: _guidesSectionKey, // Attach key to the section
                    onPressed: () => Get.to(() => AllTourGuides(
                      title: 'Popular Tour Guides',
                      futureMethod: guideRepository.getAllAvailableGuides(),
                    )),
                  ),
                  const SizedBox(height: SSizes.spaceBtwItems),

                  /// Popular Tour Guides
                  Obx(() {
                    if (guideController.isLoading.value) return const SVerticalGuideShimmer();

                    if (guideController.availableGuides.isEmpty) {
                      return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return SGridLayout(
                      itemCount: guideController.availableGuides.length,
                      itemBuilder: (_, index) => SGuideCardVertical(guide: guideController.availableGuides[index]),
                    );
                  }),

                  SizedBox(height: SSizes.spaceBtwSections),

                ],
              ),
            ),
            /// Floating Button for Chatbot
            /*
            Positioned(
              bottom: 16,
              left: 16,
              child: ChatWidget(),
            ),
            */
          ],
        ),
      ),

    );
  }

  // Method to scroll to a specific section
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final position = context.findRenderObject() as RenderBox?;
      if (position != null) {
        final offset = position.localToGlobal(Offset.zero);
        _scrollController.animateTo(
          offset.dy, // Scroll to the vertical position of the section
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}