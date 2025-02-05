import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final status = Get.parameters['status']; // Get status from URL

    return Scaffold(
      appBar: AppBar(title: Text("Payment Status")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (status == "success")
              Text("🎉 Payment Successful!", style: TextStyle(fontSize: 20, color: Colors.green))
            else
              Text("❌ Payment Failed", style: TextStyle(fontSize: 20, color: Colors.red)),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed("/home"); // Navigate back to home screen
              },
              child: Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}