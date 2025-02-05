import 'package:adventure_rides/common/container/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../features/book/controllers/car/car_controller.dart';
import '../../../../features/book/models/car_model.dart';
import '../../../../features/book/screens/car_details/car_detail.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/enums.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadows.dart';
import '../../../widgets/Text/car_price_text.dart';
import '../../../widgets/Text/car_title_text.dart';
import '../../../widgets/Text/s_brand_title_text_with_verified_icon.dart';
import '../../../widgets/images/s_rounded_image.dart';
import '../../favourite_icon/favourite_icon.dart';

class MobileCarCardVertical extends StatelessWidget {
  const MobileCarCardVertical({super.key, required this.car});

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CarController());
    final dark = SHelperFunctions().isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => CarDetailScreen(car: car), preventDuplicates: false),
      child: Container(
        width: double.infinity, // Fixed width
        //width: 180,
        decoration: BoxDecoration(
          boxShadow: [SShadowStyle.verticalCarShadow],
          borderRadius: BorderRadius.circular(SSizes.carImageRadius),
          color: dark ? SColors.darkerGrey : SColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Make column fit its contents
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thumbnail and Wishlist Button
            Flexible(
              child: SRoundedContainer(
                width: double.infinity,
                height: 180,
                backgroundColor: dark ? SColors.dark : SColors.light,
                child: Stack(
                  children: [
                    SRoundedImage(
                      imageUrl: car.thumbnail,
                      applyImageRadius: true,
                      isNetworkImage: true,
                      fit: BoxFit.cover,
                      height: 180, // Ensure the height matches the container
                      width: double.infinity, // Stretch image to fill the container
                      //height: 100, // Fixed height for the image
                    ),
                    Positioned(
                      top: 3,
                      right: 3,
                      child: SFavouriteIcon(carId: car.id),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections / 4),
            /// Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SCarTitleText(title: car.title, smallSize: true),
                  SBrandTitleWithVerifiedIcon(
                    title: car.brand!.name,
                    brandTextSize: TextSizes.small,
                  ),
                ],
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections / 2),
            /// Price Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (car.carType == CarType.single.toString() &&
                            car.bookingPrice > 3)
                          Text(
                            car.price.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                        SCarPriceText(price: controller.getCarPrice(car)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}