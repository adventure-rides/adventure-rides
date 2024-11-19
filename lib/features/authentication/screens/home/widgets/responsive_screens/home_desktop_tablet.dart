import 'package:adventure_rides/features/book/screens/all_guides/all_tour_guides.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../common/cars/cars_cards/car_card_vertical.dart';
import '../../../../../../common/custom_shapes/containers/primary_header_container.dart';
import '../../../../../../common/custom_shapes/containers/search_container.dart';
import '../../../../../../common/tour_guide/guide_cards/guide_card_vertical.dart';
import '../../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../../data/repositories/car/car_repository.dart';
import '../../../../../../data/repositories/tour_guide/guide_repository.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../Effects/vertical_car_shimmer.dart';
import '../../../../../Effects/vertical_guide_shimmer.dart';
import '../../../../../book/controllers/car/car_controller.dart';
import '../../../../../book/controllers/tour_guide/guide_controller.dart';
import '../../../../../book/screens/all_cars/all_cars.dart';
import '../home_appbar.dart';
import '../home_categories.dart';
import '../image_text_widgets/promo_slider.dart';

class HomeScreenDesktop extends StatelessWidget {
  const HomeScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CarController());
    final carRepository = Get.put(CarRepository());
    final guideController = Get.put(GuideController());
    final guideRepository = Get.put(GuideRepository());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            SPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// Appbar
                  const SHomeAppBar(),
                  SizedBox(height: SSizes.spaceBtwSections),

                  /// Searchbar
                  SSearchContainer(text: 'Search in TripHub'),
                  const SizedBox(height: SSizes.spaceBtwSections),


                  /// Categories
                  const Padding(
                    padding: EdgeInsets.only(left: SSizes.defaultSpace),
                    child: Column(
                      children: [
                        SSectionHeading(
                          title: 'Popular Car Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: SSizes.spaceBtwItems),

                        /// Categories
                        SHomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: SSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace),

              /// Promotion slider
              child: Column(
                children: [
                  const SPromoSlider(),
                  const SizedBox(height: SSizes.spaceBtwSections),

                  /// Heading for popular tourist cars
                  SSectionHeading(
                    title: 'Popular Tourist Cars',
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
                      itemBuilder: (_, index) => SCarCardVertical(car: controller.featuredCars[index]),
                    );
                  }),

                  const SizedBox(height: SSizes.spaceBtwSections),

                  /// Tour Guides heading
                  SSectionHeading(
                    title: 'Popular Tour Guides',
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

                  const SizedBox(height: SSizes.spaceBtwSections),

                  /// Terms & Conditions, Privacy Policy, Cookie Preferences
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigate to Terms & Conditions
                          Get.toNamed('/terms'); // Example route
                        },
                        child: Column(
                          children: [
                            Icon(FontAwesomeIcons.file, color: SColors.primary),
                            SizedBox(height: 4),
                            Text('Terms & Conditions', style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Privacy Policy
                          Get.toNamed('/privacy-policy'); // Example route
                        },
                        child: Column(
                          children: [
                            Icon(Iconsax.lock, color: SColors.primary),
                            SizedBox(height: 4),
                            Text('Privacy Policy', style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to Cookie Preferences
                          Get.toNamed('/cookie-preferences'); // Example route
                        },
                        child: Column(
                          children: [
                            Icon(FontAwesomeIcons.cookie, color: SColors.primary),
                            SizedBox(height: 4),
                            Text('Cookie Preferences', style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
