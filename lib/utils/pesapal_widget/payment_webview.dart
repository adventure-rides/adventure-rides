import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatelessWidget {
  final String paymentUrl;

  const PaymentWebView({super.key, required this.paymentUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: WebView(
        initialUrl: paymentUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (url) {
          if (url.contains('success')) {
            // Handle successful payment
            Get.back(); // Go back or show success message
          } else if (url.contains('failure')) {
            // Handle payment failure
            Get.back(); // Go back or show failure message
          }
        },
      ),
    );
  }
}