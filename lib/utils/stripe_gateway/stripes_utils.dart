/*

import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeUtils {
  static Future<PaymentIntent?> createStripePaymentIntent(double amount) async {
    try {
      // Replace with your actual Stripe publishable key
      Stripe.publishableKey = 'YOUR_PUBLISHABLE_KEY';

      final paymentIntent = await Stripe.instance.paymentIntents.create(
        PaymentIntentCreateParams(
          currency: 'usd', // Replace with the appropriate currency code
          amount: amount * 100, // Convert to cents for Stripe API
        ),
      );

      return paymentIntent;
    } catch (error) {
      if (kDebugMode) {
        print('Error creating payment intent: $error');
      }
      return null;
    }
  }
}

 */