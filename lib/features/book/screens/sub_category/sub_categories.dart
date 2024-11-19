import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/appbar/appbar.dart';
import '../../../../common/cars/cars_cards/car_card_horizontal.dart';
import '../../../../common/widgets/Text/section_heading.dart';
import '../../../../common/widgets/images/s_rounded_image.dart';
import '../../../../utils/constraints/image_strings.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../Effects/horizontal_car_shimmer.dart';
import '../../controllers/category_controller.dart';
import '../../models/category_model.dart';
import '../all_cars/all_cars.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: SAppBar(title: Text(category.name, style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
              ///Banner
              const SRoundedImage(width: double.infinity, imageUrl: SImages.banner2, applyImageRadius: true),
              const SizedBox(height: SSizes.spaceBtwSections),

              ///Sub-Categories
              FutureBuilder(
                future: controller.getSubCategories(category.id),
                builder: (context, snapshot) {

                  ///Handle loader, no record, or error message
                  const loader = SHorizontalCarShimmer();
                  final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if(widget != null) return widget;

                  ///Record found
                  final subCategories = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: subCategories.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index){

                      final subCategory = subCategories[index];

                      return FutureBuilder(
                        future: controller.getCategoryCars(categoryId: subCategory.id),
                        builder: (context, snapshot) {

                          ///Handle loader, no record, or error message
                          final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                          if(widget != null) return widget;

                          ///Congratulations Record found
                          final cars = snapshot.data!;


                          return Column(
                            children: [
                              ///Heading
                              SSectionHeading(
                                  title: subCategory.name,
                                  onPressed: () => Get.to(
                                      () => AllCars(title: subCategory.name,
                                        futureMethod: controller.getCategoryCars(categoryId: subCategory.id, limit: -1),
                                      ),
                                  ),
                              ),
                              const SizedBox(height: SSizes.spaceBtwItems / 2),

                              SizedBox(
                                height: 120,
                                child: ListView.separated(
                                  itemCount: cars.length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) => const SizedBox(width: SSizes.spaceBtwItems),
                                  itemBuilder: (context, index) => SCarCardHorizontal(car: cars[index]),
                                ),
                              ),
                              const SizedBox(height: SSizes.spaceBtwSections),
                            ],
                          );
                        }
                      );
                    },
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}