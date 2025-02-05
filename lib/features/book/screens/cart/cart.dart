import 'package:adventure_rides/features/book/screens/cart/responsive_screens/desktop/cart_items_desktop.dart';
import 'package:adventure_rides/features/book/screens/cart/responsive_screens/mobile/cart_items_mobile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/loaders/animation_loader.dart';
import '../../../../data/repositories/authentication/general_auth_repository.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constraints/colors.dart';
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
    final user = authRepo.currentUser;

    // Check if the user is authenticated
    if (user == null || !user.emailVerified) {
      await Get.to(() => const LoginScreen());
    } else {
      //Execute checkout booking logic
      await checkoutBooking();
      Get.to(() => const CheckoutScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    //final isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final dark = SHelperFunctions().isDarkMode(context);

    return Scaffold(
      appBar: FixedScreenAppbar(title: "My Bookings"),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
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
                final isDesktop = SDevicesUtils.isDesktopScreen(context);
                final isTablet = SDevicesUtils.isTabletScreen(context);
                return (isDesktop || isTablet) ? _buildDesktopTabletLayout(dark)
                    : _buildMobileLayout(dark);
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
            padding: const EdgeInsets.all(SSizes.defaultSpace),
            child: ElevatedButton(
              onPressed: checkAuthenticationAndRedirect,
              child: Obx(() => Text('Checkout \$${controller.totalCartPrice.value}')),
                    ),
      ),
    );
  }

  Widget _buildDesktopTabletLayout(bool dark) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(SSizes.defaultSpace),
        decoration: BoxDecoration(
          color: dark ? SColors.black : Colors.white,

          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: CartItemsDesktop(),
      ),
    );
  }

  Widget _buildMobileLayout(bool isDarkMode) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpace),
        child: Column(
          children: [
            CartItemsMobile(), // Bookings items displayed on top
          ],
        ),
      ),
    );
  }

  checkoutBooking() {
    Future<void> checkoutBooking() async {
      try {
        // 1. Authenticate user
        final user = GeneralAuthRepository.instance.authUser;

        // Proceed with booking logic
        if (kDebugMode) {
          print('Booking confirmed for user: ${user.email}');
        }
      } catch (e) {
        throw 'Error during checkout: $e';
      }
    }
  }
}