import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/constraints/sizes.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';

class SuccessMainScreen extends StatelessWidget {
  const SuccessMainScreen({super.key, required String title, required String subTitle, required Function() onPressed, required String image});

  @override
  Widget build(BuildContext context) {
    final status = Get.parameters['status']; // Get status from URL
    final isSuccess = status == "success";

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Success or Failure Animation at the top
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: SSizes.defaultSpace/4), // More space below app bar
              child: Lottie.asset(
                isSuccess ? "assets/animations/success_yellow.json" : "assets/animations/failure_1.json",
                width: SHelperFunctions.screenWidth() * 0.4,
                height: SHelperFunctions.screenHeight() * 0.7,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections),

            /// Title & Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SSizes.defaultSpace * 2),
              child: Column(
                children: [
                  Text(
                    isSuccess ? "Payment Successful!" : "Payment Failed",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: SSizes.spaceBtwItems),
                  Text(
                    isSuccess
                        ? "Your payment was processed successfully."
                        : "Something went wrong. Please try again.",
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: SSizes.spaceBtwSections / 2),
                ],
              ),
            ),

            /// Buttons
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed("/home"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: isSuccess ? Colors.green : Colors.red,
                ),
                child: Text(SText.sContinue),
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}