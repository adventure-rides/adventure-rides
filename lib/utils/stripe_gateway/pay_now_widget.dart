/*
import 'dart:convert';

import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_amount_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_payment_section.dart';
import 'package:adventure_rides/features/book/screens/checkout/widgets/billing_schedule_section.dart';
import 'package:flutter/foundation.dart';
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
import '../../features/book/controllers/car/booking_controller.dart';
import '../../features/book/controllers/car/cart_controller.dart';
import '../../features/book/screens/cart/widgets/cart_items.dart';
import 'package:http/http.dart' as http;

class PayNowWidget extends StatelessWidget {
  const PayNowWidget({super.key});
  /*
  Future<void> _handleStripePayment(double amount) async {
    try {


      // Create Payment Intent
      final paymentIntent = await PaymentService.createPaymentIntent(
          amount.toString(),
          'USD'
      );

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

   */

  showPaymentSheet() async
  {
    try {

    }on StripeException catch(error)
    {
      if(kDebugMode)
        {
          print(error);
        }
      showDialog(context: context,
          builder: (e) => const AlertDialog(
            content: Text("Cancelled"),
          ));
    }
    catch(errorMsg){
      if(kDebugMode){
        print(errorMsg);
    }
      print(errorMsg.toString());
  }
  makeIntentForPayment(amountToBeCharge, currency) async {
    try{
      Map<String, dynamic>? paymentInfo ={
        "totalAmount": amountToBeCharge,
        "currency": currency,
        "payment_method_types[]": "card",
      };
      var responseFromStripeAPI = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers:
          {
            "Authorization": "Bearer $secretKey",
            'Content-Type': 'application/x-www-form-urlencoded'
          }
      );
      print("response from API = " + responseFromStripeAPI.body);
      return jsonDecode(responseFromStripeAPI.body);
    } catch (errorMsg, s){
      if(kDebugMode){
        print(s);
      }
      print(errorMsg.toString());
    }
  }

  paymentSheetInitialization(amountToBeCharge, currency) async {
    try{
      intentPaymentData = makeIntentForPayment(amountToBeCharge, currency);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            allowsDelayedPaymentMethods: true,
            paymentIntentClientSecret: intentPaymentData!["client_secret"],
            style: ThemeMode.dark,
            merchantDisplayName: "Safari Chat"
          )
      ).then((val)
      {
        print(val);
      });
      showPaymentSheet();
      }
      var responseFromStripeAPI = await http.post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: paymentInfo,
          headers:
          {
            "Authorization": "Bearer $secretKey",
            'Content-Type': 'application/x-www-form-urlencoded'
          }
      );
      print("response from API = " + responseFromStripeAPI.body);
      return jsonDecode(responseFromStripeAPI.body);
    } catch (errorMsg, s){
      if(kDebugMode){
        print(s);
      }
      print(errorMsg.toString());
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
                    /*
                    Padding(
                      padding: const EdgeInsets.all(SSizes.defaultSpace),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => _handleStripePayment(totalAmount),
                        child: Text('Pay \$$totalAmount'),
                      ),
                    ),

                     */

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
                              paymentSheetInitialization(
                                double.parse(totalAmount.toString()).round(),
                                "USD"
                              );
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
} */

