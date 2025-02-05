import 'package:adventure_rides/features/book/screens/car_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:adventure_rides/features/book/screens/car_details/widgets/car_meta_data.dart';
import 'package:adventure_rides/features/book/screens/car_details/widgets/cars_attributes.dart';
import 'package:adventure_rides/features/book/screens/car_details/widgets/rating_share_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import '../../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../../utils/constraints/enums.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../controllers/car/cart_controller.dart';
import '../../../../models/car_model.dart';
import '../../../car_reviews/car_reviews_screen.dart';
import '../../detail_buttons/mobile_book_detail_button.dart';
import '../../widgets/availability_calendar.dart';
import '../../widgets/car_detail_image_slider.dart';

class MobileCarDetail extends StatelessWidget {
  MobileCarDetail({super.key, required this.car}) {
    Get.put(CartController());
  }

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    final cartController = CartController.instance;
    return Scaffold(
      bottomNavigationBar: SBottomAddToCart(car: car), //to insert the bottom navigation bar
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Car image slider
            SCarImageSlider(car: car),

            /// Car details
            Padding(
                padding: const EdgeInsets.only(right: SSizes.defaultSpace, left: SSizes.defaultSpace, bottom: SSizes.defaultSpace),
              child: Column(
                children: [
                  ///Rating & share Button
                  const SRatingAndShare(),
                  ///Price, Title,  Stock & Brand
                  SCarsMetaData(car: car),
                  ///Attributes
                  if (car.carType == CarType.variables.toString()) SCarAttributes(car: car),
                  if (car.carType == CarType.variables.toString()) const SizedBox(height: SSizes.spaceBtwSections),
                  ///Checkout button
                  MobileBookDetailButton(cartController: cartController, car: car),

                  const SizedBox(height: SSizes.spaceBtwSections),

                  ///Description
                  const SSectionHeading(title: 'Description', showActionButton: false),
                  const SizedBox(height: SSizes.spaceBtwItems),

                  ReadMoreText(
                    car.description ?? '',
                    trimLines: 2,
                    trimCollapsedText: ' Show more ',
                    trimMode: TrimMode.Line,
                    trimExpandedText: ' Less ',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),

                  ),
                  AvailabilityCalendar(bookedDates: car.bookedDates),
                  ///Reviews
                  const Divider(),
                  const SizedBox(height: SSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SSectionHeading(title: ' Review (199) ', showActionButton: false),
                      IconButton(icon: const Icon(Iconsax.arrow_right3, size: 18), onPressed: () => Get.to(() => const CarReviewsScreen())),
                    ],
                  ),
                  SizedBox(height: SSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}