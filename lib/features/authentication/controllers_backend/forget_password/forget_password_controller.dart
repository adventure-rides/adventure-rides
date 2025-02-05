import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/Network/network_manager.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../screens/password_configuration/reset_password/reset_password.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  /// Text editing controller for email field
  final email = TextEditingController();

  /// Form key for forget password form
  final forgetPasswordFormKey = GlobalKey<FormState>();
  //GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  ///Send Reset password email
  sendPasswordResetEmail() async {
    try {
      //start loading
      SFullScreenLoader.openLoadingDialog('Processing your request...', SImages.processAnimation);

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        //Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        //Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }
      //Send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      //Remove loader
      SFullScreenLoader.stopLoading();

      //Show success Screen
      SLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);

      //Redirect
      Get.to(() => ResetPassword(email: email.text.trim()));


    } catch (e){
      //Remove loader
      SFullScreenLoader.stopLoading();
      //Show some generic error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
  ///Resend Reset password email
  resendPasswordResetEmail(String email) async {
    try {
      //start loading
      SFullScreenLoader.openLoadingDialog('Processing your request...', SImages.processAnimation);

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        //Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }

      //Send email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      //Remove loader
      SFullScreenLoader.stopLoading();

      //Show success Screen
      SLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);

    } catch (e){
      //Remove loader
      SFullScreenLoader.stopLoading();
      //Show some generic error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}