import 'package:adventure_rides/features/book/screens/cart/responsive_screens/desktop/cart_items_desktop.dart';
import 'package:adventure_rides/features/book/screens/cart/responsive_screens/mobile/cart_items_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/loaders/animation_loader.dart';
import '../../../../data/repositories/authentication/general_auth_repository.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../authentication/screens/Login/login.dart';
import '../../../authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import '../../controllers/car/cart_controller.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> checkAuthenticationAndRedirect() async {
    if (!Get.isRegistered<GeneralAuthRepository>()) {
      Get.put(GeneralAuthRepository());
    }

    final authRepo = GeneralAuthRepository.instance;
    //final user = authRepo._auth.currentUser;

    final user = authRepo.currentUser;

    // Check if the user is authenticated
    if (user == null || !user.emailVerified) {
      // If not authenticated, prompt login or registration
      await Get.to(() => const LoginScreen());
    } else {
      // Proceed to the checkout if authenticated
      Get.to(() => const CheckoutScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final dark = SHelperFunctions().isDarkMode(context);
    return Scaffold(
      appBar: FixedScreenAppbar(),
      body: Column(
        children: [
          // Title text below the navbar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0), // Add space around the title
            child: Text(
              'Your Bookings', // Title passed from the constructor
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black, // Adjust the color as needed
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Obx(() {
              /// Nothing found widget
              final emptyWidget = SAnimationLoaderWidget(
                text: 'Whoops! Bookings is Empty.',
                animation: SImages.shopAnimation,
                showAction: true,
                actionText: 'Let\'s fill it',
                onActionPressed: () => Get.off(() => const NavigationMenu()),
              );

              if (controller.cartItems.isEmpty) {
                return emptyWidget;
              } else {
                /// Check if the screen is desktop or mobile
                final isDesktop = SDevicesUtils.isDesktopScreen(context);

                if (isDesktop) {
                  // Display desktop-specific layout
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(SSizes.defaultSpace),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: CartItemsDesktop(), // Bookings items displayed on the left
                          ),
                          const SizedBox(width: SSizes.defaultSpace),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                // Add additional content for desktop layout, such as a summary or recommendations
                                Container(
                                  padding: const EdgeInsets.all(SSizes.defaultSpace),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Display mobile-specific layout
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(SSizes.defaultSpace),

                      /// Items in bookings for mobile
                      child: CartItemsMobile(),
                    ),
                  );
                }
              }
            }),
          ),
        ],
      ),

      ///Checkout button
      bottomNavigationBar: controller.cartItems.isEmpty ? const SizedBox() : Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: checkAuthenticationAndRedirect,
            child: Obx(() => Text('Checkout \$${controller.totalCartPrice.value}'))),
      ),
    );
  }
}
