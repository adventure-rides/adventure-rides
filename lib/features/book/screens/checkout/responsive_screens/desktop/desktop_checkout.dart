import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_amount_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_payment_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_schedule_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import '../../../../../../common/cars/cart/coupon_widget.dart';
import '../../../../../../common/container/rounded_container.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/helpers/pricing_calculator.dart';
import '../../../../../../utils/popups/loaders.dart';
import '../../../../../../utils/stripe_gateway/stripe_service.dart';
import '../../../../controllers/car/booking_controller.dart';
import '../../../../controllers/car/cart_controller.dart';
import '../../../cart/widgets/cart_items.dart';

class DesktopCheckout extends StatelessWidget {
  const DesktopCheckout({super.key});


  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final bookingController = Get.put(BookingController());
    final totalAmount = SPricingCalculator.calculateTotalPrice(subTotal, 'US');

    final dark = SHelperFunctions().isDarkMode(context);
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: dark ? SColors.black : SColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                blurRadius: 10, // Softening the shadow
                spreadRadius: 2, // Expanding the shadow
                offset: Offset(0, 5), // Shifting shadow vertically
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800), // Center the content
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Items in bookings
                    const SCartItems(showAddRemoveButtons: false),
                    const SizedBox(height: SSizes.spaceBtwSections),

                    /// Coupon textField
                    const SCouponCode(),
                    const SizedBox(height: SSizes.spaceBtwSections),

                    /// Billing Section
                    SRoundedContainer(
                      padding: const EdgeInsets.all(SSizes.md),
                      showBorder: true,
                      backgroundColor: dark ? SColors.black : SColors.white,
                      child: const Column(
                        children: [
                          /// Pricing
                          SBillingAmountSection(),
                          SizedBox(height: SSizes.spaceBtwItems),
                          /// Divider
                          Divider(),
                          SizedBox(height: SSizes.spaceBtwItems),
                          /// Payment Methods
                          SBillingPaymentSection(),
                          SizedBox(height: SSizes.spaceBtwItems),
                          /// Address
                          SBillingScheduleSection(),

                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(SSizes.defaultSpace),
                      child: Align(
                        alignment: Alignment.bottomCenter, // Center the button horizontally
                        child: SizedBox(
                          width: 800, // Limit button width
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: subTotal > 0
                                ? () => bookingController.processOrder(subTotal)
                                : () => SLoaders.warningSnackBar(
                              title: 'Empty Cart',
                              message: 'Add items in the cart in order to proceed.',
                            ),
                            child: Text('Checkout \$$totalAmount'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}