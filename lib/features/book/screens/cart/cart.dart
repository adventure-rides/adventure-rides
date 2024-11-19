import 'package:adventure_rides/features/book/screens/cart/widgets/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/appbar/appbar.dart';
import '../../../../common/loaders/animation_loader.dart';
import '../../../../data/repositories/authentication/general_auth_repository.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../authentication/screens/Login/login.dart';
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

    return Scaffold(
      appBar: SAppBar(
          showBackArrow: true,
          title:
              Text(' Bookings ', style: Theme.of(context).textTheme.headlineSmall)),
      body: Obx(() {
        ///Nothing found widget
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
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SSizes.defaultSpace),

              ///Items in bookings
              child: SCartItems(),
            ),
          );
        }
      }),

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
