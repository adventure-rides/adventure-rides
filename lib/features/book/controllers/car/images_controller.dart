
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constraints/sizes.dart';
import '../../models/car_model.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  ///variables
  RxString selectedCarImage = ''.obs; // the url of the selected image

  ///Get all images from car and variations
  List<String> getAllCarImages(CarModel car) {
    //Use Set to add unique images only
    Set<String> images = {};

    //Load thumbnail image
    images.add(car.thumbnail);

    //Assign thumbnail as selected image
    selectedCarImage.value = car.thumbnail;

    //Get all images from the car model if not null
    if(car.images != null) {
      images.addAll(car.images!);
    }
    //Get all images from the car variations if not null
    if(car.carVariations != null || car.carVariations!.isNotEmpty){
      images.addAll(car.carVariations!.map((variation) => variation.image));
    }
    return images.toList();

  }
  ///Show image popup
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
        () => Dialog.fullscreen(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: SSizes.defaultSpace * 2, horizontal: SSizes.defaultSpace),
                  child: CachedNetworkImage(imageUrl: image),
                ),
                const SizedBox(height: SSizes.spaceBtwSections /2),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 150,
                    child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}