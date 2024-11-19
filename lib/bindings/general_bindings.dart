import 'package:get/get.dart';
import '../common/Network/network_manager.dart';
import '../features/book/controllers/car/checkout_controller.dart';
import '../features/book/controllers/car/variation_controller.dart';
import '../features/personalization/controllers/address_controller.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(VariationController());
    Get.put(AddressController());
    Get.put(CheckOutController());

  }
}