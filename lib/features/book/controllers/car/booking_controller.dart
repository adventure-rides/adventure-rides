import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:adventure_rides/data/repositories/authentication/general_auth_repository.dart';
import 'package:adventure_rides/features/personalization/controllers/schedule_controller.dart';
import 'package:adventure_rides/utils/constraints/enums.dart';
import 'package:adventure_rides/utils/stripe_gateway/payment_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/booking/booking_repository.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/pesapal_widget/payment_webview.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/booking_model.dart';
import 'cart_controller.dart';
import 'checkout_controller.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  ///Variables
  final cartController = CartController.instance;
  final scheduleController = ScheduleController.instance;
  final checkoutController = CheckOutController.instance;
  final bookingRepository = Get.put(BookingRepository());

  ///Fetch user's booking history
  /*
  void processOrder(double totalAmount) async {
    try {
      //Start loader
      SFullScreenLoader.openLoadingDialog('Processing your booking...', SImages.pencilAnimation);

      //Get user authentication id
      final userId = GeneralAuthRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

      //Add details
      final booking = BookingModel(
        //generate a unique id for the booking
          id: UniqueKey().toString(),
          userId: userId,
          status: BookingStatus.pending,
          totalAmount: totalAmount,
          bookingDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          pickupLocation: scheduleController.selectedSchedule.value,
          //Get date as needed
          confirmDate: DateTime.now(),
          items: cartController.cartItems.toList(),
      );
      //Save the booking to fire store
      await bookingRepository.bookingOrder(booking, userId);

      //Execute the cart status
      cartController.clearCart();

      //Show success screen
      Get.offAll(() => const PaymentHome());
      /*
      Get.off(() => SuccessScreen(
        image: SImages.orderCompletedAnimation,
        title: 'Payment Success!',
        subTitle: 'Your booking is complete!',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
        //onPressed: () => Get.offAll(() => const PaymentScreen()),

      ));
      */
    } catch (e){
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
  */
  void processOrder(double totalAmount) async {
    try {
      // Start loader
      SFullScreenLoader.openLoadingDialog('Processing your booking...', SImages.pencilAnimation);

      // Get user authentication id
      final userId = GeneralAuthRepository.instance.authUser.uid;
      if (userId.isEmpty) return;

      // Add booking details
      final booking = BookingModel(
        id: UniqueKey().toString(),
        userId: userId,
        status: BookingStatus.pending,
        totalAmount: totalAmount,
        bookingDate: DateTime.now(),
        paymentMethod: checkoutController.selectedPaymentMethod.value.name,
        pickupLocation: scheduleController.selectedSchedule.value,
        confirmDate: DateTime.now(),
        items: cartController.cartItems.toList(),
      );

      // Save the booking to Firestore
      await bookingRepository.bookingOrder(booking, userId);

      // Initiate payment
      final paymentUrl = await initiatePesapalPayment(totalAmount, userId);

      if (paymentUrl != null) {
        // Navigate to payment web view
        Get.to(() => PaymentWebView(paymentUrl: paymentUrl));
      } else {
        // Handle payment initiation failure
        SLoaders.warningSnackBar(title: 'Payment Failed', message: 'Unable to initiate payment.');
      }

      // Clear the cart
      cartController.clearCart();

    } catch (e) {
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
  ///Add methods for booking processing
  Future<List<BookingModel>> fetchUserOrders() async {
    try {
      final userBookings = await bookingRepository.fetchUserBookings();
      return userBookings;
    } catch (e){
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
  Future<String?> initiatePesapalPayment(double amount, String userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/api/payment'), // Your payment endpoint
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'amount': amount,
          'currency': 'USD', // or your desired currency
          'userId': userId,
          // Add other parameters as needed
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['paymentUrl']; // URL to redirect for payment
      } else {
        // Handle error response
        return null;
      }
    } catch (e) {
      // Handle exceptions
      return null;
    }
  }
}