import 'package:adventure_rides/common/cars/cars_cards/desktop/desktop_car_card_vertical.dart';
import 'package:adventure_rides/common/widgets/layouts/grids/desktop_grid_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../features/book/controllers/all_cars_controller.dart';
import '../../../../../features/book/models/car_model.dart';
import '../../../../../utils/constraints/sizes.dart';


class SortableCarsDesktop extends StatelessWidget {
  const SortableCarsDesktop({
    super.key, required this.cars,
  });
  final List<CarModel> cars;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllCarsController());
    controller.assignCars(cars);
    return Column(
      children: [
        ///Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value){
            //Sort cars based on the selected option
            controller.sortCars(value!);
          },
          items: ['Name', 'Higher Price', 'Lower Price', 'Booking',]
              .map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),

        ),
        SizedBox(height: SSizes.spaceBtwSections),
        ///Cars
        Obx(() => DesktopGridLayout(itemCount: controller.cars.length, itemBuilder: (_, index) => DesktopCarCardVertical(car: controller.cars[index]))),
      ],
    );
  }
}