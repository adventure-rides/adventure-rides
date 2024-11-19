import 'package:adventure_rides/data/repositories/authentication/general_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../common/Network/network_manager.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/user_controller.dart';

class LoginController extends GetxController{
  ///Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs; //observe all variables with .obs
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  @override
  void onInit() {
    //To read the email stored in the local storage if remember me is selected & ?? '' Provide a default value if the key doesn't exist or if it's null
    email.text = localStorage.read('REMEMBER_ME_EMAIL')  ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD')  ?? ''; //To read the password stored in the local storage if remember me is selected
    super.onInit();
  }

  ///Email and password sign in
  Future<void> emailAndPasswordSignIn() async {
    try {
      //Start Loading
      SFullScreenLoader.openLoadingDialog(
          'Logging you in...', SImages.processAnimation);

      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        //Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }
      //form validation
      if (!loginFormKey.currentState!.validate()) {
        //Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }
      //Save data if remember me is selected
      if(rememberMe.value){
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
      //Login user using email & password authentication
      final userCredential = await GeneralAuthRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      //Remove Loader
      SFullScreenLoader.stopLoading();

      //Redirect
      GeneralAuthRepository.instance.screenRedirect();
    }catch (e) {
      //Remove loader
      SFullScreenLoader.stopLoading();
      //Show some generic error to the user
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  ///Google signIn authentication
  Future<void> googleSignIn() async {
    try{
      //start loading
      SFullScreenLoader.openLoadingDialog('Logging you in...', SImages.processAnimation);
      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        //Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }
      //Google authentication
      final userCredentials = await GeneralAuthRepository.instance.signInWithGoogle();
      //Save user record
      await userController.saveUserRecord(userCredentials);

      //Remove loader
      SFullScreenLoader.stopLoading();

      //Redirect
      GeneralAuthRepository.instance.screenRedirect();

    }catch(e){
      //Remove loader
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}