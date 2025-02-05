import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_amount_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_payment_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_schedule_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../common/cars/cart/coupon_widget.dart';
import '../../../../../../common/container/rounded_container.dart';
import '../../../../../../utils/constraints/colors.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/helpers/pricing_calculator.dart';
import '../../../../../../utils/popups/loaders.dart';
import '../../../../controllers/car/booking_controller.dart';
import '../../../../controllers/car/cart_controller.dart';
import '../../../cart/widgets/cart_items.dart';

class DesktopCheckout extends StatelessWidget {
  const DesktopCheckout({super.key});

  Future<void> processStripePayment(double amount) async {
    try {
      final returnUrl = "https://your-flutter-app.com/payment-status?status=success"; // ✅ Change to your Flutter page

      final response = await http.post(
        Uri.parse("https://your-backend-url.com/create-checkout-session"), // Backend URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"amount": (amount * 100).toInt(), "returnUrl": returnUrl}),
      );

      final jsonResponse = jsonDecode(response.body);
      if (!jsonResponse.containsKey("url")) {
        throw Exception("Failed to get checkout URL");
      }

      final checkoutUrl = jsonResponse["url"];

      // ✅ Open Stripe Checkout in the browser
      if (await canLaunch(checkoutUrl)) {
        await launch(checkoutUrl);
      } else {
        throw "Could not open Stripe Checkout";
      }

    } catch (e) {
      print("❌ Payment Error: $e");
      SLoaders.warningSnackBar(
        title: "Payment Failed",
        message: "Something went wrong. Please try again.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
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
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SCartItems(showAddRemoveButtons: false),
                    const SizedBox(height: SSizes.spaceBtwSections),
                    const SCouponCode(),
                    const SizedBox(height: SSizes.spaceBtwSections),
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
                          SBillingScheduleSection(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(SSizes.defaultSpace),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 800,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: subTotal > 0
                                ? () => processStripePayment(subTotal)
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