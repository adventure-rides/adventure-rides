import 'package:adventure_rides/features/authentication/screens/Login/login.dart';
import 'package:adventure_rides/features/authentication/screens/emergency_details/emergency_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_rides/features/book/screens/all_cars/all_cars.dart';
import 'package:adventure_rides/features/book/screens/all_guides/all_tour_guides.dart';
import 'package:adventure_rides/navigation_menu.dart';
import 'package:adventure_rides/utils/constraints/image_strings.dart';
import 'package:adventure_rides/utils/device/device_utility.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../common/appbar/appbar.dart';
import '../../../../../common/cars/cart/cart_menu_icon.dart';
import '../../../../../data/repositories/car/car_repository.dart';
import '../../../../../data/repositories/tour_guide/guide_repository.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../../../../book/reservation/reservations.dart';
import '../../../../book/screens/cart/cart.dart';

class MobileHomeAppbar extends StatelessWidget {
  const MobileHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final guideRepository = Get.put(GuideRepository());
    final carRepository = Get.put(CarRepository());

    // Check screen size to decide layout for actions
    final isLargeScreen = SDevicesUtils.isDesktopScreen(context) ||
        SDevicesUtils.isTabletScreen(context);
    final isMobile = !SDevicesUtils.isMobileScreen(context);

    return SAppBar(
      title: !isMobile
          ? Row(
              children: [
                Image.asset(
                  SImages.appLogo,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SText.homeAppbarTitle,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(color: SColors.grey),
                    ),
                    Text(
                      SText.homeAppbarSubTitle,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .apply(color: SColors.white)
                          .copyWith(fontWeight: FontWeight.bold),

                    ),
                  ],
                ),
              ],
            )
          : null, // This will hide the title section on mobile screens
      actions: [
        if (isLargeScreen) ...[
          TextButton.icon(
            onPressed: () => Get.off(() => const NavigationMenu()),
            icon: const Icon(Icons.home, color: SColors.white),
            label: const Text("Home", style: TextStyle(color: SColors.white)),
          ),
          TextButton.icon(
            onPressed: () => Get.to(() => AllCars(
                  title: 'Popular Tourist Cars',
                  futureMethod: carRepository.getAllFeaturedCarS(),
                )),
            icon: const Icon(Icons.directions_car, color: SColors.white),
            label: const Text("Cars", style: TextStyle(color: SColors.white)),
          ),
          TextButton.icon(
            onPressed: () => Get.to(() => AllTourGuides(
                  title: 'Popular Tour Guides',
                  futureMethod: guideRepository.getAllAvailableGuides(),
                )),
            icon: const Icon(Icons.person_pin, color: SColors.white),
            label: const Text("Tour Guides",
                style: TextStyle(color: SColors.white)),
          ),
          ///Reservations menu
          TextButton.icon(
            onPressed: () => Get.to(() => const ReservationsScreen()),
            icon: Icon(Iconsax.reserve, color: SColors.white),
            label: const Text("Reservations",
                style: TextStyle(color: SColors.white)),
          ),
          ///Login menu
          TextButton.icon(
            onPressed: () => Get.to(() => const LoginScreen()),
            icon: Icon(Iconsax.login, color: SColors.white),
            label: const Text("Sign in",
                style: TextStyle(color: SColors.white)),
          ),

          TextButton.icon(
            onPressed: () => Get.to(() =>  EmergencyScreen()),
            icon: const Icon(Icons.emergency, color: SColors.white),
            label: const Text("Emergency",
                style: TextStyle(color: SColors.white)),
          ),

          SCartCounterIcon(iconColor: SColors.white),
        ] else
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: SColors.white),
            onSelected: (value) {
              switch (value) {
                case 'home':
                  Get.to(() => const NavigationMenu());
                  break;
                case 'cars':
                  Get.to(() => AllCars(
                        title: 'Popular Tourist Cars',
                        futureMethod: carRepository.getAllFeaturedCarS(),
                      ));
                  break;
                case 'guides':
                  Get.to(() => AllTourGuides(
                        title: 'Popular Tour Guides',
                        futureMethod: guideRepository.getAllAvailableGuides(),
                      ));
                  break;
                case 'reservations':
                  Get.to(() => const ReservationsScreen());
                  break;
                case 'sign-in':
                  Get.to(() => const LoginScreen());
                  break;
                case 'contact':
                  Get.to(() =>  EmergencyScreen());
                  break;
                case 'bookings':
                // Navigate to the bookings/cart screen
                  Get.to(() => const CartScreen());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'home',
                child: ListTile(
                  leading: Icon(Icons.home, color: SColors.grey),
                  title: const Text("Home"),
                ),
              ),
              PopupMenuItem<String>(
                value: 'cars',
                child: ListTile(
                  leading: Icon(Icons.directions_car, color: SColors.grey),
                  title: const Text("Cars"),
                ),
              ),
              PopupMenuItem<String>(
                value: 'guides',
                child: ListTile(
                  leading: Icon(Icons.person_pin, color: SColors.grey),
                  title: const Text("Tour Guides"),
                ),
              ),
              PopupMenuItem<String>(
                value: 'reservations',
                child: ListTile(
                  leading: Icon(Iconsax.reserve, color: SColors.grey),
                  title: const Text("Reservations"),
                ),
              ),
              PopupMenuItem<String>(
                value: 'sign-in',
                child: ListTile(
                  leading: Icon(Iconsax.login, color: SColors.grey),
                  title: const Text("Sign in"),
                ),
              ),
              PopupMenuItem<String>(
                value: 'emergency',
                child: ListTile(
                  leading: Icon(Icons.emergency, color: SColors.grey),
                  title: const Text("Emergency"),
                ),
              ),
              PopupMenuItem<String>(
                value: 'bookings',
                child: ListTile(
                  leading: Icon(Icons.book_online, color: SColors.grey),
                  title: const Text("Bookings"),
                ),
              ),
            ],
          ),
      ],
    );
  }
}