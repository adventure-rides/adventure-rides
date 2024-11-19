import 'package:flutter/material.dart';
import '../../../../brands/brand_card.dart';
import '../../../../common/appbar/appbar.dart';
import '../../../../common/cars/sortable/sortable_cars.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../Effects/vertical_car_shimmer.dart';
import '../../controllers/brand_controller.dart';
import '../../models/brand_model.dart';

class BrandCars extends StatelessWidget {
  const BrandCars({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: SAppBar(title: Text(brand.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SSizes.defaultSpace),
          child: Column(
            children: [
              ///Brand Detail
              SBrandCard(showBorder: true, brand: brand),
              const SizedBox(height: SSizes.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandCars(brandId: brand.id),
                builder: (context, snapshot) {

                  ///Handle loader, no record, or error message
                  const loader = SVerticalCarShimmer();
                  final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if(widget != null) return widget;

                  ///Record found
                  final brandCars = snapshot.data!;

                  return SSortableCars(cars: brandCars);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

