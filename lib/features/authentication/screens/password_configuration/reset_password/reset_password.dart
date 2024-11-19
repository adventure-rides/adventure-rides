import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../../../../utils/constraints/image_strings.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/constraints/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers_backend/forget_password/forget_password_controller.dart';
import '../../Login/login.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Image with 60% of screen width
              Image(image: const AssetImage(SImages.deliveredEmailIllustration), width: SHelperFunctions.screenWidth() * 0.6,),
              const SizedBox(height: SSizes.spaceBtwSections),

              ///Title & Subtitle
              Text(email, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: SSizes.spaceBtwItems),
              Text(SText.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: SSizes.spaceBtwItems),
              Text(SText.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
              const SizedBox(height: SSizes.spaceBtwSections),

              ///Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => Get.offAll(() => const LoginScreen()), child: const Text(SText.done))),
              const SizedBox(height: SSizes.spaceBtwItems),
              //Buttons
              SizedBox(
                  width: double.infinity,
                  child: TextButton(onPressed: () => ForgetPasswordController.instance.resendPasswordResetEmail(email), child: const Text(SText.resendEmail))),

            ],

          ),
        ),
      ),
    );
  }
}
