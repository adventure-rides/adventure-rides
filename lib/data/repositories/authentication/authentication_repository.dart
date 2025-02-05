import 'package:adventure_rides/data/repositories/authentication/user/user_repository.dart';
import 'package:adventure_rides/features/book/screens/checkout/checkout.dart';
import 'package:adventure_rides/utils/exceptions/firebase_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../features/authentication/screens/Login/login.dart';
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../utils/exceptions/firebase_auth_exception.dart';
import '../../../utils/exceptions/platform_exception.dart';
import '../../../utils/local_storage/storage_utility.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  ///Get authentication user data
  User get authUser => _auth.currentUser!;

  ///Create from main.dart on app launch

  @override
  void onReady() {
    //Remove the native splash screen
    FlutterNativeSplash.remove();
    //Redirect to the appropriate screen
    screenRedirect();
  }

  /// Function to show relevant screen and redirect accordingly
  screenRedirect() async {
    final user = _auth.currentUser;
    if (kDebugMode) {
      print("Current user: $user"); // Check if user is null or authenticated
    }
    if (user != null){
      //If the user is logged in
      if(user.emailVerified){
        //Initialize user specific storage
        await SLocalStorage.init(user.uid);

        if (kDebugMode) {
          print("Navigating to CheckoutScreen");
        }
        //If the user's email is verified, navigate to the Checkout screen
        Get.offAll(() => const CheckoutScreen());
      }else {
        //If the user's email is not verified, navigate to the Verify Email Screen
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    }else {
      //Local storage
      deviceStorage.writeIfNull('IsFirstTime', true);
      Get.offAll(() => const LoginScreen()); // Redirect directly to Login screen
    }

  }
/* ------------------------------Email & Password Sign-in------------------------------*/

  ///Email Authentication  - Login in
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    }on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///Email Authentication - Register
  Future<UserCredential> registeredWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
  } on FirebaseException catch (e) {
  throw SFirebaseException(e.code).message;
  } on FormatException catch (_) {
  throw const FormatException();
  }on PlatformException catch (e) {
  throw SPlatformException(e.code).message;
  } catch (e) {
      throw 'Something went wrong. Please try again';
  }
  }
  ///Re authenticate user
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async{
    try {
      //Create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      //ReAuthenticate
      await _auth.currentUser?.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) { //Catch exceptions related to firebase authentication
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    }on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///Mail Verification
  Future<void> sendEmailVerification() async{
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) { //Catch exceptions related to firebase authentication
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    }on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///Forget Password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    }on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

/* ------------------------------Federated identity & Social Sign-in------------------------------*/

  ///Google Authentication - Google
  Future<UserCredential> signInWithGoogle() async{
    try {
      //Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      //Create a new credential
      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch (e) { //Catch exceptions related to firebase authentication
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    }on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong: $e';
    }
  }
  ///Facebook authentication - Facebook user
/* ------------------------------end Federated identity & Social Sign-in------------------------------*/

  ///Logout user - Valid for any authentication
  Future<void> logout() async{
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) { //Catch exceptions related to firebase authentication
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    }on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
  ///Delete user - Remove user auth and firebase account
  Future<void> deleteAccount() async{
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) { //Catch exceptions related to firebase authentication
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const FormatException();
    }on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}