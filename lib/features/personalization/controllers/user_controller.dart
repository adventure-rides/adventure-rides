import 'package:adventure_rides/data/repositories/authentication/general_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common/Network/network_manager.dart';
import '../../../data/repositories/authentication/user/user_repository.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/sizes.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../authentication/models/User/user_model.dart';
import '../../authentication/screens/Login/login.dart';
import '../../authentication/screens/profile/widgets/re_authenticate_user_login_form.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  } // User repository instance to store the data

  ///Fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    }finally{
      profileLoading.value = false;
    }
  }

  ///Save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //First update Rx and then check if user data is already stored. If not store new data
      await fetchUserRecord();
      //If no record already stored
      if (user.value.id.isEmpty){
        if (userCredentials != null) {
          //Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(userCredentials.user! ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          //Map Data to user model
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );
          // Save user data
          await userRepository.saveUserRecord(user);
        }
      }

    } catch (e) {
      SLoaders.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your information. You can re-save your data in your profile',
      );
    }
  }
  ///Delete account warning
  void deleteAccountWarningPopup(){
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(SSizes.md),
      title: 'Delete Account',
      middleText:
        'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
        child: const Padding(padding: EdgeInsets.symmetric(horizontal: SSizes.lg), child: Text('Delete')),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
      ),
    );
  }
  ///Delete user account
  void deleteUserAccount() async {
    try {
      SFullScreenLoader.openLoadingDialog(
          'Processing', SImages.processAnimation);

      ///First re-authenticate user
      //final auth = AuthenticationRepository.instance;
      final auth = GeneralAuthRepository.instance;
      final provider = auth.authUser
          .providerData
          .map((e) => e.providerId)
          .first;
      if (provider.isEmpty) {
        //Re verify auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          SFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          SFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
    ///Re-authenticate before deleting
    Future<void> reAuthenticateEmailAndPasswordUser() async {
      try {
        SFullScreenLoader.openLoadingDialog('Processing', SImages.processAnimation);

        //Check internet connectivity
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected){
          //Remove Loader
          SFullScreenLoader.stopLoading();
          return;
        }
        //form validation
        if (!reAuthFormKey.currentState!.validate()) {
          //Remove Loader
          SFullScreenLoader.stopLoading();
          return;
        }
        //await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
        //await AuthenticationRepository.instance.deleteAccount();
        await GeneralAuthRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
        await GeneralAuthRepository.instance.deleteAccount();
        Get.offAll(() => const LoginScreen());
      } catch (e) {
        SFullScreenLoader.stopLoading();
        SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      }
  }

  ///Upload profile image
  uploadUserProfilePicture() async {
    try {
      //Open the gallery, use await since the uploading the image may take sometime
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if(image != null){
        imageUploading.value = true;
        //Upload image
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile', image);

        //Update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        //To refresh the image to show the updated image
        user.refresh();

        SLoaders.successSnackBar(title: 'Congratulations', message: 'Your Profile Image has been updated!');
      }
    } catch (e){
      SLoaders.errorSnackBar(title: 'Oh Snap', message: 'Something went wrong: $e');
    } finally {
      imageUploading.value = false;
    }
  }
}