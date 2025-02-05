import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentService {
  static Future<Map<String, dynamic>?> createPaymentIntent(
      String amount,
      String currency
      ) async {
    try {
      final response = await http.post(
          Uri.parse('YOUR_BACKEND_URL/create-payment-intent'),
          body: {
            'amount': amount,
            'currency': currency.toLowerCase(),
          }
      );
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }
}