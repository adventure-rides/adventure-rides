import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../brands/brand_card.dart';
import '../../../../common/appbar/appbar.dart';
import '../../../../common/widgets/Text/section_heading.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../Effects/brands_shimmer.dart';
import '../../controllers/brand_controller.dart';
import 'brand_cars.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const SAppBar(title: Text('Brands'), showBackArrow: false),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(SSizes.spaceBtwItems),
          child: Column(
            children: [
              ///Heading
              const SSectionHeading(title: 'Brands'),
              const SizedBox(height: SSizes.spaceBtwItems),
              
              ///Brands
              Obx(() {
                    if (brandController.isLoading.value) return const SBrandsShimmer();
                    if(brandController.allBrands.isEmpty){
                      return Center(
                        child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)),
                      );
                    }
                    return SGridLayout(
                      itemCount: brandController.allBrands.length,
                      mainAxisExtent: 80,
                      itemBuilder: (_, index) {
                        final brand = brandController.allBrands[index];
                        return SBrandCard(showBorder: true, brand: brand,
                        onTap: () => Get.to(() => BrandCars(brand: brand)),
                        );
                      },
                    );
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
