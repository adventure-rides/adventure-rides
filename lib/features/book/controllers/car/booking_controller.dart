import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:adventure_rides/data/repositories/authentication/general_auth_repository.dart';
import 'package:adventure_rides/features/personalization/controllers/schedule_controller.dart';
import 'package:adventure_rides/utils/constraints/enums.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/repositories/booking/booking_repository.dart';
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
      //Get.offAll(() => const PaymentHome());
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
      // Show a loading dialog with CircularProgressIndicator
      showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text("Processing Payment..."),
              ],
            ),
          );
        },
      );

      // Get user authentication ID
      final userId = GeneralAuthRepository.instance.authUser.uid;
      if (userId.isEmpty) {
        Get.back(); // Close loading dialog
        return;
      }

      // Step 1: Add booking details
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

      // Step 2: Save the booking to Firestore
      await bookingRepository.bookingOrder(booking, userId);

      // Step 3: Process Stripe Payment
      await processStripePayment(totalAmount);

      // Step 4: Wait for Payment Confirmation
      bool paymentConfirmed = await waitForPaymentConfirmation();

      if (!paymentConfirmed) {
        Get.back(); // Close loading dialog
        SLoaders.warningSnackBar(
          title: 'Payment Failed',
          message: 'Your payment was not completed. Please try again.',
        );
        return;
      }

      // Step 5: Clear the cart
      //cartController.clearCart();

      // Step 6: Show success message
      SLoaders.successSnackBar(
        title: 'Success',
        message: 'Your booking has been successfully processed!',
      );

    } catch (e) {
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      cartController.clearCart();
      Get.back(); // Ensure the loading dialog is closed
    }
  }

  ///Add methods for booking processing
  Future<List<BookingModel>> fetchUserBookings() async {
    try {
      final userBookings = await bookingRepository.fetchUserBookings();
      return userBookings;
    } catch (e){
      SLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  ///Method to handle stripe payment, takes the user to the stripe checkout screen
  Future<void> processStripePayment(double amount) async {
    try {
      final returnUrl = "http://localhost:22973/#/success-screen"; // Change to your Flutter page

      final response = await http.post(
        Uri.parse("https://adventure-rides.onrender.com/create-checkout-session"), // Backend URL
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"amount": (amount * 100).toInt(), "returnUrl": returnUrl}),
      );

      final jsonResponse = jsonDecode(response.body);
      if (!jsonResponse.containsKey("url")) {
        throw Exception("Failed to get checkout URL");
      }

      final checkoutUrl = jsonResponse["url"];

      // Open Stripe Checkout in the browser
      if (await canLaunch(checkoutUrl)) {
        await launch(checkoutUrl);
      } else {
        throw "Could not open Stripe Checkout";
      }
      // Generate PDF receipt after successful payment
      //generateReceiptPDF("TXN123456", amount);

    } catch (e) {
      print("❌ Payment Error: $e");
      SLoaders.warningSnackBar(
        title: "Payment Failed",
        message: "Something went wrong. Please try again.",
      );
    }
  }

  Future<bool> waitForPaymentConfirmation() async {
    try {
      // Check the Stripe payment status from your backend
      await Future.delayed(Duration(seconds: 5)); // Wait a bit before polling
      for (int i = 0; i < 10; i++) { // Poll for a maximum of 10 attempts (50 seconds)
        final response = await http.get(Uri.parse("http://localhost:22973/#/check-payment-status"));
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse["status"] == "success") {
          return true; // Payment was confirmed
        }

        await Future.delayed(Duration(seconds: 5)); // Wait 5 seconds before retrying
      }
    } catch (e) {
      print("❌ Payment Confirmation Error: $e");
    }
    return false; // If payment is not confirmed within the time frame
  }

  /*
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

   */
}