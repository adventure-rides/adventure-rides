import 'package:adventure_rides/features/Effects/vertical_car_shimmer.dart';
import 'package:adventure_rides/features/book/controllers/car/car_detail_controller.dart';
import 'package:adventure_rides/features/book/screens/car_details/responsive_screens/desktop/car_desktop_detail_image_slider.dart';
import 'package:adventure_rides/features/book/screens/car_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:adventure_rides/features/book/screens/car_details/widgets/car_meta_data.dart';
import 'package:adventure_rides/features/book/screens/car_details/widgets/cars_attributes.dart';
import 'package:adventure_rides/features/book/screens/car_details/widgets/rating_share_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import '../../../../../../common/cars/cars_cards/desktop/desktop_car_card_vertical.dart';
import '../../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../../common/widgets/layouts/grids/desktop_grid_layout.dart';
import '../../../../../../utils/constraints/enums.dart';
import '../../../../../../utils/constraints/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../../utils/popups/loaders.dart';
import '../../../../controllers/car/cart_controller.dart';
import '../../../../models/car_model.dart';
import '../../../car_reviews/car_reviews_screen.dart';
import '../../../cart/cart.dart';
import '../../widgets/availability_calendar_desktop.dart';
import '../../widgets/availability_calendar_dialog.dart';

class DesktopCarDetail extends StatelessWidget {

  DesktopCarDetail({super.key, required this.car}) {
    Get.put(CartController());
    final carController = Get.put(CarDetailController());

    // Fetch cars excluding the current car
    carController.fetchAvailableCarsExcludingCurrent(car.id);
  }

  final ValueNotifier<bool> isRoundTripNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isCalendarVisible = ValueNotifier<bool>(false); // Toggle for calendar visibility

  //final List<DateTime> unavailableDates;
  final CarModel car;

  // Convert bookedDates list to a map for event markers
  Map<DateTime, List> _getEventsFromBookedDates(List<String> bookedDates) {
    Map<DateTime, List> events = {};
    for (var date in bookedDates) {
      DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
      events[parsedDate] = ['Booked'];
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    final dark = SHelperFunctions().isDarkMode(context);
    final cartController = CartController.instance; // For the cart
    final carController = CarDetailController.instance; // For the car
    final Map<DateTime, List> events = _getEventsFromBookedDates(car.bookedDates.cast<String>());

    return Scaffold(
      bottomNavigationBar: SBottomAddToCart(car: car), // Bottom navigation bar
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Top section
            Padding(
              padding: const EdgeInsets.all(SSizes.defaultSpace),
              child: Row(
                children: [
                  // Image Section (Left Column)
                  Expanded(
                    flex: 1,
                    child: DesktopCarImageSlider(car: car), // Car image slider
                  ),

                  // Spacer between image and details section
                  SizedBox(width: SSizes.defaultSpace),

                  // Details Section (Right Column)
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rating & Share Button
                        const SRatingAndShare(),

                        // Car Meta Data (Price, Title, Stock, Brand)
                        SCarsMetaData(car: car),

                        // Car Attributes (if applicable)
                        if (car.carType == CarType.variables.toString()) SCarAttributes(car: car),

                        // Description Section
                        const Divider(),
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

                        /*
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TableCalendar(
                            focusedDay: DateTime.now(),
                            firstDay: DateTime.now(),
                            lastDay: DateTime(2100),
                            calendarFormat: CalendarFormat.month,
                            eventLoader: (day) => events[day] ?? [],
                            calendarStyle: CalendarStyle(
                              todayDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                              markerDecoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                            ),
                          ),
                        ),
                        */
                        //AvailabilityCalendarDesktop(bookedDates: car.bookedDates),
                        /// Toggle Calendar visibility button
                        AvailabilityCalendarDialog(car: car),

                        // Conditionally display the calendar
                        ValueListenableBuilder<bool>(
                          valueListenable: isCalendarVisible,
                          builder: (context, isVisible, child) {
                            return isVisible
                                ? AvailabilityCalendarDesktop(bookedDates: car.bookedDates, onDateSelected: (DateTime ) {  },)
                                : Container();
                          },
                        ),
                        /// Book Now Button
                        const SizedBox(height: SSizes.spaceBtwSections),
                        Align(
                          alignment: Alignment.centerRight, //align button to the center right
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              //backgroundColor: SColors.accent,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                              ),
                            ),

                            /*
                            //Dialog menu
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ScheduleTravelDialog(
                                  controller: scheduleController,
                                  onSchedule: (travelDetails) {
                                    // Handle the scheduled travel details here
                                    TravelRepository().saveTravelDetails(travelDetails);
                                  },
                                  isRoundTripNotifier: isRoundTripNotifier,
                                ),
                              );
                            },
                            child: Text("Schedule Travel"),
                            */
                            onPressed: () {
                              if (cartController.itemQuantityInCart.value > 0) {
                                cartController.addToCart(car); // Add car to cart
                                Get.to(() => CartScreen()); // Navigate to CartScreen
                              } else {
                                SLoaders.customToast(message: 'Select a quantity to proceed to bookings');
                              }
                            },
                            child: const Text('Book Now'),

                          ),
                        ),

                        // Reviews Section
                        const Divider(),
                        SizedBox(height: SSizes.spaceBtwItems / 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SSectionHeading(title: ' Review (199) ', showActionButton: false),
                            IconButton(
                              icon: const Icon(Iconsax.arrow_right3, size: 18),
                              onPressed: () => Get.to(() => const CarReviewsScreen()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SSizes.spaceBtwSections),
            const Divider(),
            const SizedBox(height: SSizes.spaceBtwSections),

            /// Available Cars Section
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: SSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SSectionHeading(
                      title: 'Other Cars You May Like',
                      showActionButton: false),
                  const SizedBox(height: SSizes.spaceBtwItems),

                  /// List of available cars
                  Obx(() {
                    if (carController.isLoading.value) {
                      return const Center(child: SVerticalCarShimmer());
                    }
                    if (carController.availableCars.isEmpty) {
                      return const Center(child: Text("No other cars available."));
                    }
                    return DesktopGridLayout(
                      itemCount: carController.availableCars.length,
                      itemBuilder: (context, index) {
                        final otherCar = carController.availableCars[index];
                        return DesktopCarCardVertical(car: otherCar);
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}