import 'package:adventure_rides/utils/local_storage/storage_utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app.dart';
import 'firebase_options.dart';

/// Entry point of flutter app
Future<void> main() async {
  /// Widgets binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  /// Getx local storage
  //await GetStorage.init();
  /// Await native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize Get Storage and firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //await GetStorage.init();
  await SLocalStorage.init('default');

  //.then((FirebaseApp value) => Get.put(AuthenticationRepository()),);
  // Initialize Authentication

  //Load all the material design / themes / localization
  runApp(const App());
  FlutterNativeSplash.remove();

}



