import 'package:adventure_rides/common/cars/cars_cards/desktop/desktop_car_card_vertical.dart';
import 'package:adventure_rides/common/chatbot/chat_widget.dart';
import 'package:adventure_rides/features/book/screens/all_guides/all_tour_guides.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/guide_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../common/custom_shapes/containers/primary_header_container.dart';
import '../../../../../../common/custom_shapes/containers/search_container.dart';
import '../../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../../common/widgets/layouts/grids/desktop_grid_layout.dart';
import '../../../../../../data/repositories/car/car_repository.dart';
import '../../../../../../data/repositories/tour_guide/guide_repository.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../Effects/vertical_car_shimmer.dart';
import '../../../../../Effects/vertical_guide_shimmer.dart';
import '../../../../../book/controllers/car/car_controller.dart';
import '../../../../../book/controllers/tour_guide/guide_controller.dart';
import '../../../../../book/screens/all_cars/all_cars.dart';
import '../../../adverts/advert_display_screen.dart';
import '../home_appbar.dart';
import '../home_categories.dart';
import '../image_text_widgets/promo_slider_desktop.dart';

class HomeScreenDesktop extends StatelessWidget {
  const HomeScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CarController());
    final carRepository = Get.put(CarRepository());
    final guideController = Get.put(GuideController());
    final guideRepository = Get.put(GuideRepository());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SDevicesUtils.getAppBarBarHeight()),
        child: SHomeAppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Stack( // Use Stack to overlay ChatWidget
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SPrimaryHeaderContainer(
                    child: Column(
                      children: [
                        SizedBox(height: SSizes.spaceBtwSections),
                        SSearchContainer(text: 'Search ...'),
                        const SizedBox(height: SSizes.spaceBtwItems),
                        Padding(
                          padding: const EdgeInsets.only(left: SSizes.defaultSpace),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SSectionHeading(
                                    title: 'Popular Car Categories',
                                    showActionButton: false,
                                    textColor: Colors.white,
                                  ),
                                ],
                              ),
                              const SizedBox(height: SSizes.spaceBtwItems),
                              const SHomeCategories(),
                            ],
                          ),
                        ),
                        const SizedBox(height: SSizes.spaceBtwSections),
                      ],
                    ),
                  ),
                  //AdvertDisplayScreen(),
                  Padding(
                    padding: const EdgeInsets.all(SSizes.defaultSpace),
                    child: Column(
                      children: [
                        const PromoSliderDesktop(),
                        const SizedBox(height: SSizes.spaceBtwSections),
                        SSectionHeading(
                          title: 'Popular Tourist Cars',
                          onPressed: () => Get.to(() => AllCars(
                            title: 'Popular Tourist Cars',
                            futureMethod: carRepository.getAllFeaturedCarS(),
                          )),
                        ),
                        const SizedBox(height: SSizes.spaceBtwItems),
                        Obx(() {
                          if (controller.isLoading.value) return const SVerticalCarShimmer();
                          if (controller.featuredCars.isEmpty) {
                            return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                          }
                          return DesktopGridLayout(
                            itemCount: controller.featuredCars.length,
                            itemBuilder: (_, index) => DesktopCarCardVertical(car: controller.featuredCars[index]),
                          );
                        }),
                        const SizedBox(height: SSizes.spaceBtwSections),
                        SSectionHeading(
                          title: 'Popular Tour Guides',
                          onPressed: () => Get.to(() => AllTourGuides(
                            title: 'Popular Tour Guides',
                            futureMethod: guideRepository.getAllAvailableGuides(),
                          )),
                        ),
                        const SizedBox(height: SSizes.spaceBtwItems),
                        Obx(() {
                          if (guideController.isLoading.value) return const SVerticalGuideShimmer();
                          if (guideController.availableGuides.isEmpty) {
                            return Center(child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium));
                          }
                          return GuideListView(guideController: guideController);
                        }),
                        const SizedBox(height: SSizes.spaceBtwSections),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/terms');
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
                                Get.toNamed('/privacy-policy');
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
                                Get.toNamed('/cookie-preferences');
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
            // Add the ChatWidget here
            //ChatWidget(), // This will overlay the chat button
          ],
        ),
      ),
    );
  }
}