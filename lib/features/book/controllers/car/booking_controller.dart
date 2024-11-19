import 'package:adventure_rides/utils/constraints/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../data/repositories/booking/booking_repository.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../personalization/controllers/address_controller.dart';
import '../../models/booking_model.dart';
import 'cart_controller.dart';
import 'checkout_controller.dart';

class BookingController extends GetxController {
  static BookingController get instance => Get.find();

  ///Variables
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckOutController.instance;
  final bookingRepository = Get.put(BookingRepository());

  ///Fetch user's booking history
  void processOrder(double totalAmount) async {
    try {
      //Start loader
      SFullScreenLoader.openLoadingDialog('Processing your booking...', SImages.pencilAnimation);

      //Get user authentication id
      final userId = AuthenticationRepository.instance.authUser.uid;
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
          pickupLocation: addressController.selectedAddress.value,
          //Get date as needed
          confirmDate: DateTime.now(),
          items: cartController.cartItems.toList(),
      );
      //Save the booking to firestore
      await bookingRepository.bookingOrder(booking, userId);

      //Execute the cart status
      cartController.clearCart();

      //Show success screen
      Get.off(() => SuccessScreen(
        image: SImages.orderCompletedAnimation,
        title: 'Payment Success!',
        subTitle: 'Your booking is complete!',
        onPressed: () => Get.offAll(() => const NavigationMenu()),
      ));
    } catch (e){
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

}