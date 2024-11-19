import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../common/Network/network_manager.dart';
import '../../../../data/repositories/authentication/general_auth_repository.dart';
import '../../../../data/repositories/authentication/user/user_repository.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/User/user_model.dart';
import '../../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs; //Observable for hiding/showing password
  final privacyPolicy = true.obs; //Observable for privacy policy acceptance
  final email = TextEditingController(); //Controller for email input
  final lastName = TextEditingController(); //Controller for last name input
  final username = TextEditingController(); //Controller username input
  final password = TextEditingController(); //Controller for password input
  final firstName = TextEditingController(); //Controller for first name input
  final phoneNumber =
      TextEditingController(); //Controller for phone number input
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); //Form key for form validation

  //Signup
  void signup() async {
    try {
      //start loading
      SFullScreenLoader.openLoadingDialog(
          'We are processing your information...', SImages.processAnimation);

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        //Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if (!signupFormKey.currentState!.validate()) {
        //Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }

      //Privacy policy check
      if (!privacyPolicy.value) {
        SLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.',
        );
        return;
      }

      //Register user in the firebase authentication & save user data in the Firebase
      final userCredential = await GeneralAuthRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());
      //Save authenticated user data in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //Remove Loader
      SFullScreenLoader.stopLoading();

      //Show success message
      SLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created! Verify email to continue.');

      //Move to verify image screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
      //Remove loader
      SFullScreenLoader.stopLoading();
      //Show some generic error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
