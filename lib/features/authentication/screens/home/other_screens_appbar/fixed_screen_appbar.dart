import 'package:adventure_rides/common/appbar/fixed_appbar.dart';
import 'package:adventure_rides/features/book/screens/booking/bookings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:adventure_rides/features/book/screens/all_cars/all_cars.dart';
import 'package:adventure_rides/features/book/screens/all_guides/all_tour_guides.dart';
import 'package:adventure_rides/navigation_menu.dart';
import 'package:adventure_rides/utils/device/device_utility.dart';
import '../../../../../common/cars/cart/cart_menu_icon.dart';
import '../../../../../data/repositories/car/car_repository.dart';
import '../../../../../data/repositories/tour_guide/guide_repository.dart';
import '../../../../../utils/constraints/colors.dart';
import '../../../../book/screens/cart/cart.dart';
import '../../../../personalization/controllers/user_controller.dart';
import '../../../../authentication/screens/Login/login.dart';

class FixedScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const FixedScreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final guideRepository = Get.put(GuideRepository());
    final carRepository = Get.put(CarRepository());

    // Check screen size to decide layout for actions
    final isLargeScreen = SDevicesUtils.isDesktopScreen(context) ||
        SDevicesUtils.isTabletScreen(context);
    final isMobile = SDevicesUtils.isCustomScreen(context);

    return FixedAppbar(
      title: null, // This will hide the title section on mobile screens
      actions: [
        if (isLargeScreen) ...[
          TextButton.icon(
            onPressed: () => Get.off(() => const NavigationMenu()),
            icon: const Icon(Icons.home, color: SColors.white),
            label: const Text("Home", style: TextStyle(color: SColors.white)),
          ),
          TextButton.icon(
            onPressed: () => Get.off(() => const BookingScreen()),
            icon: const Icon(Icons.book, color: SColors.white),
            label:
                const Text("Bookings", style: TextStyle(color: SColors.white)),
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
          TextButton.icon(
            onPressed: () {
              // Define what happens on 'Contact Us' click
            },
            icon: const Icon(Icons.contact_mail, color: SColors.white),
            label: const Text("Contact Us",
                style: TextStyle(color: SColors.white)),
          ),
          TextButton.icon(
            onPressed: () {
              // Define what happens on 'Contact Us' click
            },
            icon: const Icon(Icons.login, color: SColors.white),
            label: const Text("Login", style: TextStyle(color: SColors.white)),
          ),
          // Add the booking icon
          SCartCounterIcon(iconColor: SColors.white),
        ] else
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: SColors.white),
            onSelected: (value) {
              switch (value) {
                case 'home':
                  Get.to(() => const NavigationMenu());
                  break;
                case 'bookings':
                  Get.to(() => const BookingScreen());
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
                case 'contact':
                  // Define what happens on 'Contact Us' click
                  break;
                case 'login':
                  // Define what happens on 'Contact Us' click
                  Get.to(() => const LoginScreen());
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
                value: 'bookings',
                child: ListTile(
                  leading: Icon(Icons.book, color: SColors.grey),
                  title: const Text("Bookings"),
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
                value: 'contact',
                child: ListTile(
                  leading: Icon(Icons.contact_mail, color: SColors.grey),
                  title: const Text("Contact Us"),
                ),
              ),
              PopupMenuItem<String>(
                value: 'login',
                child: ListTile(
                  leading: Icon(Icons.login, color: SColors.grey),
                  title: const Text("Login"),
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

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
