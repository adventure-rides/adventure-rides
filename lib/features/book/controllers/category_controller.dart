import 'package:get/get.dart';

import '../../../data/repositories/car/car_repository.dart';
import '../../../data/repositories/categories/category_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/category_model.dart';
import '../models/car_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  ///Load Category data
  Future<void> fetchCategories() async {
    try {
      //show loader while loading categories
      isLoading.value = true;
      //Fetch categories from data source (Firestore, API, etc
      final categories = await _categoryRepository.getAllCategories();
      //Update the categories lists
      allCategories.assignAll(categories);

      //Filter featured categories
      featuredCategories().assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());

    }catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }
  ///Load selected category data
  Future<List<CategoryModel>> getSubCategories(String categoryId) async{
    try {
      //Fetch limited (4) cars against each subCategory
      final subCategories = await _categoryRepository.getSubCategories(categoryId);
      return subCategories;
    } catch (e){
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  ///Get category or sub-category cars
  Future<List<CarModel>> getCategoryCars({required String categoryId, int limit = -1}) async {
    try {
      //Fetch limited (4) cars against each subCategory
      final cars = await CarRepository.instance.getCarsForCategory(categoryId: categoryId, limit: limit);
      return cars;
    } catch (e){
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }
}