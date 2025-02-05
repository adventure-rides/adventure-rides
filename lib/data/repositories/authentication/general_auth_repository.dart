import 'package:adventure_rides/data/repositories/authentication/user/user_repository.dart';
import 'package:adventure_rides/utils/exceptions/firebase_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../features/authentication/screens/Login/login.dart';
import '../../../features/authentication/screens/signup/verify_email.dart';
import '../../../features/book/screens/checkout/checkout.dart';
import '../../../utils/exceptions/firebase_auth_exception.dart';
import '../../../utils/exceptions/platform_exception.dart';
import '../../../utils/local_storage/storage_utility.dart';

class GeneralAuthRepository extends GetxController {
  static GeneralAuthRepository get instance => Get.find<GeneralAuthRepository>();

  /// Firebase Auth instance
  final  _auth = FirebaseAuth.instance;

  ///Get authentication user data
  User get authUser => _auth.currentUser!;

  /// Lazy initialization for `User` retrieval
  User? get currentUser => _auth.currentUser;


  /// Check if the user is authenticated and has verified their email
  bool get isAuthenticated => currentUser != null && currentUser!.emailVerified;

  /// Initializes the repository if it's not already initialized
  static Future<void> initialize() async {
    if (!Get.isRegistered<GeneralAuthRepository>()) {
      Get.put(() => GeneralAuthRepository());
    }
  }

  /// Function to show relevant screen and redirect accordingly

  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      // If the user is logged in
      if (user.emailVerified) {
        // Initialize user-specific storage
        await SLocalStorage.init(user.uid);

        // If the user's email is verified, navigate to the main navigation menu
        Get.offAll(() => const CheckoutScreen());
      } else {
        // If the user's email is not verified, navigate to the Verify Email Screen
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    } else {
      // If the user is not authenticated, show a message and navigate to the Login screen
      Get.snackbar(
        'Authentication Required', // Title
        'You are not logged in. Please log in to continue.', // Message
        snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
        backgroundColor: Colors.red, // Background color for visibility
        colorText: Colors.white, // Text color for contrast
      );
      // Delay before navigating to the Login screen to give the user time to read the message
      await Future.delayed(const Duration(seconds: 2));
      Get.offAll(() => const LoginScreen());
    }
  }

  /// Method to check authentication and redirect accordingly
  Future<void> checkAuthenticationAndRedirect() async {
    if (currentUser == null) {
      // Redirect to login screen if not authenticated
      await Get.to(() => const LoginScreen());
    } else if (!currentUser!.emailVerified) {
      // Redirect to email verification screen if the email is not verified
      await Get.to(() => VerifyEmailScreen(email: currentUser!.email));
    }
  }

  /* ------------------------------Email & Password Sign-in------------------------------ */
  /// Email Login
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      await checkAuthenticationAndRedirect();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again.';
    }
  }

  /// Email Registration
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again.';
    }
  }

  /* ------------------------------Google Sign-in------------------------------ */
  /// Google Sign-In
  Future<UserCredential> signInWithGoogle() async {
    try {
      //Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      //Create a new credential
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      //Once signed in return the user credential
      return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again.';
    }
  }

  /* ------------------------------Logout------------------------------ */
  /// Logout
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Failed to logout. Please try again.';
    }
  }

  /* ------------------------------Email Verification------------------------------ */
  /// Send Email Verification
  Future<void> sendEmailVerification() async {
    try {
      if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'An error occurred. Please try again.';
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
  /* ------------------------------Password Reset------------------------------ */
  /// Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Failed to send reset email. Please try again.';
    }
  }
  ///Facebook authentication - Facebook user
/* ------------------------------end Federated identity & Social Sign-in------------------------------*/
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