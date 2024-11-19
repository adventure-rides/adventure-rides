import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/constraints/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers_backend/signup/verify_email_controller.dart';

 class VerifyEmailScreen extends StatelessWidget {
   const VerifyEmailScreen({super.key, this.email});

   final String? email;

   @override
   Widget build(BuildContext context) {
     final controller = Get.put(VerifyEmailController());

     ///The close icon in the app bar is used to log out the user and redirect them to the login screen.
     ///This approach is taken to handle scenarios where the user enters the registration process,
     ///and the data is stored. Upon reopening the app, it checks if the email is verified.
     ///If not verified, the app always navigates to the verification screen.
     return Scaffold(
       appBar: AppBar(
         automaticallyImplyLeading: false,
         actions: [IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon: const Icon(CupertinoIcons.clear)),
         ],
       ),
       body: SingleChildScrollView( //to enable the scrolling of the screen
         //Padding to give default equal space on all sides in all screens
         child: Padding(
             padding: const EdgeInsets.all(SSizes.defaultSpace),
           child: Column(
             children: [
               ///Image
               Image(image: AssetImage(SImages.processAnimation), width: SHelperFunctions.screenWidth() * 0.6,),
               const SizedBox(height: SSizes.spaceBtwSections),

               ///Title & Subtitle
               Text(SText.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
               const SizedBox(height: SSizes.spaceBtwItems),
               Text(email ?? '', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center),
               const SizedBox(height: SSizes.spaceBtwItems),
               Text(SText.confirmEmailSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center),
               const SizedBox(height: SSizes.spaceBtwSections), 
               ///Buttons
               SizedBox(
                   width: double.infinity,
                   child: ElevatedButton(
                       onPressed: () => controller.checkEmailVerificationStatus(),
                       child: const Text(SText.sContinue)),

               ),
               const SizedBox(height: SSizes.spaceBtwItems),
               SizedBox(width: double.infinity, child: TextButton(onPressed: () => controller.sendEmailVerification(), child: const Text(SText.resendEmail))),
             ],
           ),
         ),
       ),
     );
   }
 }
