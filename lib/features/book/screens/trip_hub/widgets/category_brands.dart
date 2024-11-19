import 'package:flutter/material.dart';

import '../../../../../brands/brand_show_case.dart';
import '../../../../../utils/constraints/sizes.dart';
import '../../../../../utils/helpers/cloud_helper_functions.dart';
import '../../../../Effects/boxes_shimmer.dart';
import '../../../../Effects/list_tile_shimmer.dart';
import '../../../controllers/brand_controller.dart';
import '../../../models/category_model.dart';

 class CategoryBrands extends StatelessWidget {
   const CategoryBrands({super.key, required this.category});

   final CategoryModel category;

   @override
   Widget build(BuildContext context) {
     final controller = BrandController.instance;
     return FutureBuilder(
       future: controller.getBrandsForCategory(category.id),
       builder: (context, snapshot) {
         /// handle loader, no record, or error message
         const loader = Column(
           children: [
             SListTileShimmer(),
             SizedBox(height: SSizes.spaceBtwItems),
             SBoxesShimmer(),
             SizedBox(height: SSizes.spaceBtwItems),
           ],
         );
         final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
         if (widget != null) return widget;

         ///Record found
         final brands = snapshot.data!;

         return ListView.builder(
           shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
           itemCount: brands.length,
           itemBuilder: (_, index) {
             final brand = brands[index];
             return FutureBuilder(
               future: controller.getBrandCars(brandId: brand.id, limit: 3),
               builder: (context, snapshot) {
                 /// handle loader, no record, or error message
                 final widget = SCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                 if (widget != null) return widget;

                 ///Record found!
                 final products = snapshot.data!;
                 return SBrandShowcase(brand: brand, images: products.map((e) => e.thumbnail).toList());
               }
             );
           },
         );
       }
     );
   }
 }