import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../popups/loaders.dart';

class PaymentService {
  static final String? _stripeSecret = dotenv.env['STRIPE_SECRET_KEY'];

  static Future<Map<String, dynamic>?> createPaymentIntent(
      String amount,
      String currency
      ) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $_stripeSecret',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'amount': calculateAmount(amount),
          'currency': currency,
        },
      );
      return json.decode(response.body);
    } catch (err) {
      Get.back();
      SLoaders.errorSnackBar(title: 'Error', message: err.toString());
      return null;
    }
  }

  static String calculateAmount(String amount) {
    return (double.parse(amount) * 100).toStringAsFixed(0);
  }
}