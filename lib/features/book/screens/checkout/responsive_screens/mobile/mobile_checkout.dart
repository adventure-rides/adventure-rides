import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_address_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_amount_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_payment_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
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

class MobileCheckout extends StatelessWidget {
  const MobileCheckout({super.key});

  Future<void> _handleStripePayment(double amount) async {
    try {
      // Check if the platform is web
      if (kIsWeb) {
        // Show error if web platform
        Get.back();
        SLoaders.errorSnackBar(
            title: 'Payment Not Supported',
            message: 'Stripe payment is not supported on web. Please use a mobile device.'
        );
        return;
      }

      // Create Payment Intent
      final paymentIntent = await PaymentService.createPaymentIntent(amount.toString(), 'USD');

      if (paymentIntent != null) {
        // Initialize Payment Sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent['client_secret'],
            merchantDisplayName: 'Adventure Rides',
            style: ThemeMode.light,
          ),
        );

        // Display Payment Sheet
        await Stripe.instance.presentPaymentSheet();

        // Clear cart on success
        CartController.instance.clearCart();

        Get.back();
        SLoaders.successSnackBar(
            title: 'Success!',
            message: 'Payment completed successfully'
        );
      }
    } catch (e) {
      Get.back();
      SLoaders.errorSnackBar(
          title: 'Payment Failed',
          message: e.toString()
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final bookingController = Get.put(BookingController());
    final totalAmount = SPricingCalculator.calculateTotalPrice(subTotal, 'US');

    final dark = SHelperFunctions().isDarkMode(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(SSizes.defaultSpace),
                child: Column(
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
                          SBillingAmountSection(),
                          SizedBox(height: SSizes.spaceBtwItems),
                          Divider(),
                          SizedBox(height: SSizes.spaceBtwItems),
                          SBillingPaymentSection(),
                          SizedBox(height: SSizes.spaceBtwItems),
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
      ),
      /// Checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => _handleStripePayment(totalAmount) // Trigger Stripe payment
              : () => SLoaders.warningSnackBar(
            title: 'Empty Cart',
            message: 'Add items in the cart in order to proceed.',
          ),
          child: Text('Checkout \$$totalAmount'),
        ),
      ),
    );
  }
}