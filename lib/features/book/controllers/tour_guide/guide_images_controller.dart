import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constraints/sizes.dart';

class GuideImagesController extends GetxController {
  static GuideImagesController get instance => Get.find();

  /// Variables
  RxString selectedGuideImage = ''.obs; // The URL of the selected image

  /// Get all images from the tour guide
  List<String> getAllGuideImages(TourGuideModel guide) {
    // Use Set to add unique images only
    Set<String> images = {};

    // Load the guide's profile image as the thumbnail
    images.add(guide.image);
    selectedGuideImage.value = guide.image; // Assign profile image as selected image

    // Get all images associated with the guide (if any)
    // Assuming you might want to include additional images in the model
    // For example, if you add a `List<String> additionalImages` field in the TourGuideModel
    /*
    if (guide.additionalImages != null && guide.additionalImages!.isNotEmpty) {
      images.addAll(guide.additionalImages!);
    }

     */

    return images.toList();
  }

  /// Show enlarged image
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: SSizes.defaultSpace * 2,
                  horizontal: SSizes.defaultSpace),
              child: CachedNetworkImage(imageUrl: image),
            ),
            const SizedBox(height: SSizes.spaceBtwSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Close'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
