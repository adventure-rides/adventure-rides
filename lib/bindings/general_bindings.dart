import 'package:adventure_rides/data/repositories/authentication/general_auth_repository.dart';
import 'package:adventure_rides/features/book/controllers/car/cart_controller.dart';
import 'package:adventure_rides/features/book/controllers/tour_guide/banner_header_controller.dart';
import 'package:adventure_rides/features/personalization/controllers/user_controller.dart';
import 'package:get/get.dart';
import '../common/Network/network_manager.dart';
import '../features/book/controllers/car/checkout_controller.dart';
import '../features/book/controllers/car/variation_controller.dart';
import '../features/personalization/controllers/address_controller.dart';
import '../features/personalization/controllers/schedule_controller.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(ScheduleController());
    Get.put(CheckOutController());
    Get.put(UserController());
    Get.put(GeneralAuthRepository());
    Get.put(CartController());
    Get.put(BannerHeaderController());

  }
}