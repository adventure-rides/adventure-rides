import 'dart:async';
import 'package:adventure_rides/data/repositories/authentication/general_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/constraints/text_strings.dart';
import '../../../../utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  ///Send Email Whenever Verify Screen appears & Set timer for auto redirect
  @override
  void onInit() {
    setTimerForAutoRedirect();
    sendEmailVerification();
    checkEmailVerificationStatus();
    super.onInit();
  }
  ///Send Email Verification Link
  sendEmailVerification() async {
    try {
      await GeneralAuthRepository.instance.sendEmailVerification();
      SLoaders.successSnackBar(title: 'Email Sent', message: 'Please check your inbox and verify your email');

    }catch(e){
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
  ///Timer to automatically redirect on email verification
  setTimerForAutoRedirect(){
    Timer.periodic(const Duration(seconds: 1), (timer) async{
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: SImages.successImage,
            title: SText.yourAccountCreated,
            subTitle: SText.yourAccountCreatedSubTitle,
            onPressed: () => GeneralAuthRepository.instance.screenRedirect(),
        ),
        );
      }
    });
  }
  ///Manually check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
        image: SImages.staticSuccessIllustration,
        title: SText.yourAccountCreated,
        subTitle: SText.yourAccountCreatedSubTitle,
        onPressed: () => GeneralAuthRepository.instance.screenRedirect(),
      ),
      );
    }
  }

}