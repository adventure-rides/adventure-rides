import 'package:get/get.dart';

import '../../../data/repositories/brands/brand_repository.dart';
import '../../../data/repositories/car/car_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/brand_model.dart';
import '../models/car_model.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  RxBool isLoading = true.obs;
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  ///Load brands
  Future<void> getFeaturedBrands() async {
    try{
      // Show loader while loading brands
      isLoading.value = true;
      final brands = await brandRepository.getAllBrands();
      
      allBrands.assignAll(brands);
      featuredBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));

    } catch (e){
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Stop loader
      isLoading.value =false;
    }
  }

  /// Get brands for category
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;

    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }

  }
  /// Get brand specific cars from the data source
  Future<List<CarModel>> getBrandCars({required String brandId, int limit = -1}) async {
    try {
      final cars = await CarRepository.instance.getCarsForBrand(brandId: brandId, limit: limit);
      return cars;
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }

  }

}