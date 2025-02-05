import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/cars/cars_cards/car_card_vertical.dart';
import '../../../../../common/widgets/Text/section_heading.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../Effects/vertical_car_shimmer.dart';
import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';
import '../../all_cars/all_cars.dart';
import 'category_brands.dart';

class SCategoryTab extends StatelessWidget {
  const SCategoryTab({super.key, required this.category});


  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView( //To allow free scrolling as much as user wants
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
              ///Brands
              CategoryBrands(category: category),
              const SizedBox(height: SSizes.spaceBtwItems),

              //local

              ///Cars
              FutureBuilder(
                future: controller.getCategoryCars(categoryId: category.id),
                builder: (context, snapshot) {

                  ///Helper function, handle loader, no record, or error message
                  final response = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: const SVerticalCarShimmer());
                  if (response != null) return response;

                  ///Record found
                  final cars = snapshot.data!;

                  return Column(
                    children: [
                      SSectionHeading(title: 'You might like',
                          onPressed: () => Get.to(AllCars(
                            title: category.name,
                            futureMethod: controller.getCategoryCars(categoryId: category.id, limit: -1),
                          ),
                          ),
                      ),
                      const SizedBox(height: SSizes.spaceBtwItems),
                      SGridLayout(itemCount: cars.length, itemBuilder: (_, index) => SCarCardVertical(car: cars[index])),
                    ],
                  );
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}