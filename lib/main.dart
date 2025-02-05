import 'package:adventure_rides/utils/local_storage/storage_utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'app.dart';
import 'firebase_options.dart';

/// Entry point of flutter app
Future<void> main() async {
  // Widgets binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Preserve native splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize local storage
  await SLocalStorage.init('default');

  //Stripe configuration
  //Stripe.publishableKey = 'pk_test_51QcroNERybcrOMLTxyR7DqKQ7yfUpSaSc2dE7C57VhARIBf4pzLmQVCYpRzepRGEiGjHQyjuayqiuGtBzrBhO1hf00ZqXjfNxs';
  //await Stripe.instance.applySettings();

  //Load our .env file that contains our Stripe Secret key
  await dotenv.load(fileName: "secret/.env");

  //Assign publishable key to flutter_stripe
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  await Stripe.instance.applySettings();
  Stripe.urlScheme = 'flutterstripe';

  // Run the app
  runApp(const App());

  // Remove the splash screen
  FlutterNativeSplash.remove();
}