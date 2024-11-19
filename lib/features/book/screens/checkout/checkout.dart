import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_address_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_amount_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_payment_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/appbar/appbar.dart';
import '../../../../common/cars/cart/coupon_widget.dart';
import '../../../../common/container/rounded_container.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/pricing_calculator.dart';
import '../../../../utils/popups/loaders.dart';
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
      appBar: SAppBar(
          showBackArrow: true,
          title: Text(' Booking Review ',
              style: Theme.of(context).textTheme.headlineSmall)),
              body: SingleChildScrollView(
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

      ///Checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: subTotal > 0
                ? () => bookingController.processOrder(subTotal)
                : () => SLoaders.warningSnackBar(title: 'Empty Cart', message: 'Add items in the cart in order to proceed.'),
          child: Text('Checkout \$$totalAmount')),
      ),
    );
  }
}
