import 'package:adventure_rides/features/book/screens/car_details/responsive_screens/desktop/desktop_car_detail.dart';
import 'package:adventure_rides/features/book/screens/car_details/responsive_screens/mobile/mobile_car_detail.dart';
import 'package:adventure_rides/features/book/screens/car_details/responsive_screens/tablet/tablet_car_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../controllers/car/cart_controller.dart';
import '../../models/car_model.dart';

class CarDetailScreen extends StatelessWidget {
  CarDetailScreen({super.key, required this.car}) {
    Get.put(CartController());
  }

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return SSiteTemplate(
        useLayout: false,
        desktop: DesktopCarDetail(car: car),
        tablet: TabletCarDetail(car: car),
        mobile: MobileCarDetail(car: car));
  }
}
