import 'package:adventure_rides/features/book/controllers/all_tour_guides_controller.dart';
import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../widgets/layouts/grid_layout.dart';
import '../../../guide_cards/Mobile/mobile_guide_card_vertical.dart';


class SortableGuidesMobile extends StatelessWidget {
  const SortableGuidesMobile({
    super.key, required this.guides,
  });
  final List<TourGuideModel> guides;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllTourGuidesController());
    controller.assignGuides(guides);
    return Column(
      children: [
        ///Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          value: controller.selectedSortOption.value,
          onChanged: (value){
            //Sort tour guides based on the selected option
            controller.sortGuides(value!);
          },
          items: ['Name', 'Higher Fee', 'Lower Fee', 'Experience', 'Guide Rating']
              .map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),

        ),
        SizedBox(height: SSizes.spaceBtwSections),
        ///Guides
        Obx(() => SGridLayout(itemCount: controller.tourGuides.length, itemBuilder: (_, index) => MobileGuideCardVertical(guide: controller.tourGuides[index]))),
      ],
    );
  }
}
