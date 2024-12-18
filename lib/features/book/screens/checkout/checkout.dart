import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_address_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_amount_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_payment_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/cars/cart/coupon_widget.dart';
import '../../../../common/container/rounded_container.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import '../../controllers/car/booking_controller.dart';
import '../../controllers/car/cart_controller.dart';
import '../cart/widgets/cart_items.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final bookingController = Get.put(BookingController());
    final totalAmount = SPricingCalculator.calculateTotalPrice(subTotal, 'US');

    final dark = SHelperFunctions().isDarkMode(context);
    return Scaffold(
      appBar: FixedScreenAppbar(),
<<<<<<< HEAD
      body: Column(
        children: [
          // Title text below the navbar
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 16.0), // Add space around the title
            child: Text(
              ' Booking Review ', // Title passed from the constructor
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: dark
                        ? Colors.white
                        : Colors.black, // Adjust the color as needed
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(SSizes.defaultSpace),
                child: Column(
                  children: [
                    ///Items in cart
                    const SCartItems(showAddRemoveButtons: false),
                    const SizedBox(height: SSizes.spaceBtwSections),

                    ///Coupon textField
                    const SCouponCode(),
                    const SizedBox(height: SSizes.spaceBtwSections),

                    ///Billing Section
                    SRoundedContainer(
                      padding: const EdgeInsets.all(SSizes.md),
                      showBorder: true,
                      backgroundColor: dark ? SColors.black : SColors.white,
                      child: const Column(
                        children: [
                          ///Pricing
                          SBillingAmountSection(),
                          SizedBox(height: SSizes.spaceBtwItems),

                          ///Divider
                          Divider(),
                          SizedBox(height: SSizes.spaceBtwItems),

                          ///Payment Methods
                          SBillingPaymentSection(),
                          SizedBox(height: SSizes.spaceBtwItems),

                          ///Address
                          SBillingAddressSection(),
                        ],
                      ),
                    ),
                  ],
                ),
=======
              body: Column(
                children: [
                  // Title text below the navbar
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0), // Add space around the title
                    child: Text(
                      ' Booking Review ', // Title passed from the constructor
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: dark ? Colors.white : Colors.black, // Adjust the color as needed
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(SSizes.defaultSpace),
                        child: Column(
                          children: [
                            ///Items in cart
                            const SCartItems(showAddRemoveButtons: false),
                            const SizedBox(height: SSizes.spaceBtwSections),

                            ///Coupon textField
                            const SCouponCode(),
                            const SizedBox(height: SSizes.spaceBtwSections),

                            ///Billing Section
                            SRoundedContainer(
                              padding: const EdgeInsets.all(SSizes.md),
                              showBorder: true,
                              backgroundColor: dark ? SColors.black : SColors.white,
                              child: const Column(
                                children: [
                                  ///Pricing
                                  SBillingAmountSection(),
                                  SizedBox(height: SSizes.spaceBtwItems),
                                  ///Divider
                                  Divider(),
                                  SizedBox(height: SSizes.spaceBtwItems),
                                  ///Payment Methods
                                  SBillingPaymentSection(),
                                  SizedBox(height: SSizes.spaceBtwItems),
                                  ///Address
                                  SBillingAddressSection(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
>>>>>>> 4b76d60b99720174ae25fd9ddff4e7b6f0f5fffe
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on BookingController {
  processOrder(double subTotal) {}
}
