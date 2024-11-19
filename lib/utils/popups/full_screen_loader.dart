import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/loaders/animation_loader.dart';
import '../constraints/colors.dart';
import '../helpers/helper_functions.dart';

/// A utility class for managing a full-screen loading dialog
class SFullScreenLoader {
  /// Opens a full screen loading dialog with a given text and animations
  /// This method doesn't return anything
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible: false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop: false, //Disable popping with the back button
       // backgroundColor: Colors.transparent, // Transparent background to fit the entire screen
        child: Container(
              color: SHelperFunctions().isDarkMode(Get.context!)
                  ? SColors.dark
                  : SColors.white,
            width: double.infinity,
            height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 200), //Adjust the spacing as needed
              Flexible(child: SAnimationLoaderWidget(text: text, animation: animation)),
            ],
          ),
        ),
      ),
    );
  }

  /// Stops the currently open loading dialog
  /// This method doesn't return anything
  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop(); // Close the dialog using the navigator
  }
}
