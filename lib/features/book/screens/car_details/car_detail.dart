import 'package:adventure_rides/features/book/screens/car_details/responsive_screens/desktop/desktop_car_detail.dart';
import 'package:adventure_rides/features/book/screens/car_details/responsive_screens/mobile/mobile_car_detail.dart';
import 'package:adventure_rides/features/book/screens/car_details/responsive_screens/tablet/tablet_car_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';
<<<<<<< HEAD
import '../../../authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
=======
>>>>>>> 2c731c7f3ead869ad22f2a9414fa861a00704a39
import '../../controllers/car/cart_controller.dart';
import '../../models/car_model.dart';

class CarDetailScreen extends StatelessWidget {
  CarDetailScreen({super.key, required this.car}) {
    Get.put(CartController());
  }

  final CarModel car;

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(appBar: FixedScreenAppbar(),
        body: SSiteTemplate(useLayout: false, desktop: DesktopCarDetail(car: car), tablet: TabletCarDetail(car: car), mobile: MobileCarDetail(car: car)));
=======
    return SSiteTemplate(useLayout: false, desktop: DesktopCarDetail(car: car), tablet: TabletCarDetail(car: car), mobile: MobileCarDetail(car: car));
>>>>>>> 2c731c7f3ead869ad22f2a9414fa861a00704a39
  }
}
