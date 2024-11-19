import 'package:adventure_rides/features/book/screens/trip_hub/widgets/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../brands/brand_card.dart';
import '../../../../common/appbar/appbar.dart';
import '../../../../common/appbar/tabbar.dart';
import '../../../../common/cars/cart/cart_menu_icon.dart';
import '../../../../common/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/Text/section_heading.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../utils/constraints/colors.dart';
import '../../../../utils/constraints/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../Effects/brands_shimmer.dart';
import '../../controllers/brand_controller.dart';
import '../../controllers/category_controller.dart';
import '../brand/all_brands.dart';
import '../brand/brand_cars.dart';

class TripHubScreen extends StatelessWidget {
  const TripHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    return DefaultTabController(
      length: categories.length, //the number depends on the number of tab bars
      child: Scaffold(
        appBar: SAppBar(
          title:
              Text('Store', style: Theme.of(context).textTheme.headlineMedium),
          actions: const [
            SCartCounterIcon(),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: SHelperFunctions().isDarkMode(context)
                    ? SColors.black
                    : SColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(SSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ///Search bar
                      const SizedBox(height: SSizes.spaceBtwItems),
                      const SSearchContainer(
                          text: 'Search in Store',
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero),
                      const SizedBox(height: SSizes.spaceBtwSections),

                      ///Featured e waste brands
                      SSectionHeading(
                          title: 'Featured e waste brands', onPressed: () => Get.to(() => const AllBrandsScreen())),
                          const SizedBox(height: SSizes.spaceBtwItems / 1.5),

                      ///Brand grid
                      Obx(
                        () {
                          if (brandController.isLoading.value) return const SBrandsShimmer();
                          if(brandController.featuredBrands.isEmpty){
                            return Center(
                              child: Text('No Data Found!', style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)),
                            );
                          }
                          return SGridLayout(
                              itemCount: brandController.featuredBrands.length,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                final brand = brandController.featuredBrands[index];
                                return SBrandCard(showBorder: true, brand: brand, onTap: () => Get.to(() => BrandCars(brand: brand)));
                              },
                          );
                        }
                      ),
                    ],
                  ),
                ),
                bottom: STabBar(tabs: categories.map((category) => Tab(child: Text(category.name))).toList()),
              ),
            ];

            ///Body
          },
          body: TabBarView(
            children: categories.map((category) => SCategoryTab(category: category)).toList(),
          ),
        ),
      ),
    );
  }
}


