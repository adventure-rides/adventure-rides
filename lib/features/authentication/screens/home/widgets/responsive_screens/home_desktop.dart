import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:adventure_rides/common/cars/cars_cards/desktop/desktop_car_card_vertical.dart';
import 'package:adventure_rides/features/book/screens/all_guides/all_tour_guides.dart';
import 'package:adventure_rides/features/book/screens/guide_details/widgets/guide_list_view.dart';
import 'package:adventure_rides/common/custom_shapes/containers/primary_header1_container.dart';
import 'package:adventure_rides/common/widgets/Text/section_heading.dart';
import 'package:adventure_rides/common/widgets/layouts/grids/desktop_grid_layout.dart';
import 'package:adventure_rides/data/repositories/car/car_repository.dart';
import 'package:adventure_rides/data/repositories/tour_guide/guide_repository.dart';
import 'package:adventure_rides/utils/constraints/colors.dart';
import 'package:adventure_rides/utils/constraints/sizes.dart';
import 'package:adventure_rides/utils/device/device_utility.dart';
import 'package:adventure_rides/features/Effects/vertical_car_shimmer.dart';
import 'package:adventure_rides/features/Effects/vertical_guide_shimmer.dart';
import 'package:adventure_rides/features/book/controllers/car/car_controller.dart';
import 'package:adventure_rides/features/book/controllers/tour_guide/guide_controller.dart';
import 'package:adventure_rides/features/book/screens/all_cars/all_cars.dart';
import '../../../../../Files/privacy_policy.dart';
import '../home_appbar.dart';
import '../image_text_widgets/test_home.dart';

class HomeScreenDesktop extends StatelessWidget {
  HomeScreenDesktop({super.key});

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _carsSectionKey = GlobalKey();
  final GlobalKey _guidesSectionKey = GlobalKey();

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
        child: Stack(
          children: [
            /// Background Layer/ image
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4A90E2).withOpacity(0.1),
                      Color(0xFFE94F2E).withOpacity(0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.4, 1.0],
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/background/temp1.jpg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomCenter,
                    colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.1),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
            ),

            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  ///The image slide show, the SPrimaryHeader1Container
                  SPrimaryHeader1Container(
                    child: Column(
                      children: [
                        const SizedBox(height: SSizes.spaceBtwSections),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ElevatedButton(
                                onPressed: () => _scrollToSection(_carsSectionKey),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Theme.of(context).shadowColor,
                                  elevation: 5,
                                  side: BorderSide(color: Theme.of(context).dividerColor),
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                ),
                                child: Text(
                                  'Go to Cars Section',
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: SColors.bootColor,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ElevatedButton(
                                onPressed: () => _scrollToSection(_guidesSectionKey),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Theme.of(context).shadowColor,
                                  elevation: 5,
                                  side: BorderSide(color: Theme.of(context).dividerColor),
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                ),
                                child: Text(
                                  'Go to Guides Section',
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: SColors.bootColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: SSizes.spaceBtwItems),
                        Padding(
                          padding: const EdgeInsets.only(left: SSizes.defaultSpace),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SSectionHeading(
                                    title: 'Effortless car and guide bookings for unforgettable journeys!',
                                    showActionButton: false,
                                    textColor: Colors.white,
                                  ),
                                ],
                              ),
                              const SizedBox(height: SSizes.spaceBtwItems),
                            ],
                          ),
                        ),
                        const SizedBox(height: SSizes.spaceBtwSections),
                      ],
                    ),
                  ),

                  // Main Content
                  Padding(
                    padding: const EdgeInsets.all(SSizes.defaultSpace),
                    child: Column(
                      children: [
                        SSectionHeading(
                          title: 'Popular Tourist Cars',
                          key: _carsSectionKey,
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
                          key: _guidesSectionKey,
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
                              onTap: () => Get.toNamed('/terms'),
                              child: Column(
                                children: [
                                  Icon(FontAwesomeIcons.file, color: SColors.primary),
                                  const SizedBox(height: 4),
                                  Text('Terms & Conditions', style: Theme.of(context).textTheme.labelMedium),
                                ],
                              ),
                            ),
                            GestureDetector(
                              //onTap: () => Get.to(() => const PDFViewerPage(pdfAssetPath: "assets/files/Safari_policy.pdf")),
                              onTap: () => Get.toNamed('/privacy-policy'),
                              child: Column(
                                children: [
                                  Icon(Iconsax.lock, color: SColors.primary),
                                  const SizedBox(height: 4),
                                  Text('Privacy Policy', style: Theme.of(context).textTheme.labelMedium),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/cookie-preferences');
                                Get.to(() => TestHome());
                              },
                              child: Column(
                                children: [
                                  Icon(FontAwesomeIcons.cookie, color: SColors.primary),
                                  const SizedBox(height: 4),
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
          ],
        ),
      ),
    );
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final position = context.findRenderObject() as RenderBox?;
      if (position != null) {
        final offset = position.localToGlobal(Offset.zero);
        _scrollController.animateTo(
          offset.dy,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}