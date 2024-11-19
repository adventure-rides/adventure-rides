import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/Network/network_manager.dart';
import '../../../../data/repositories/authentication/user/user_repository.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/user_controller.dart';
import '../../screens/profile/profile.dart';

///Controller to manage user related functionality
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  ///init user data when home screen appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  ///Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
    try {
      //Start loading
      SFullScreenLoader.openLoadingDialog('We are updating your information...', SImages.processAnimation);
      //Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected){
        //Remove Loader
        SFullScreenLoader.stopLoading();
        return;
      }
      //Form validation
      if(!updateUserNameFormKey.currentState!.validate()){
        SFullScreenLoader.stopLoading();
        return;
      }
      //Update user's first & last name in the firebase firestore
      Map<String, dynamic> name = {'FirstName': firstName.text.trim(), 'LastName': lastName.text.trim()};
      await userRepository.updateSingleField(name);

      //update the RX user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = firstName.text.trim();
      //Remove loader
      SFullScreenLoader.stopLoading();
      //Show success screen
      SLoaders.successSnackBar(title: 'Congratulations', message: 'Your name has been updated.');

      //Move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

}