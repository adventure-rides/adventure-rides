import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../features/book/controllers/all_cars_controller.dart';
import '../../../../../features/book/models/car_model.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../widgets/layouts/grid_layout.dart';
import '../../../cars_cards/car_card_vertical.dart';


class SortableCarsMobile extends StatelessWidget {
  const SortableCarsMobile({
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
        Obx(() => SGridLayout(itemCount: controller.cars.length, itemBuilder: (_, index) => SCarCardVertical(car: controller.cars[index]))),
      ],
    );
  }
}
