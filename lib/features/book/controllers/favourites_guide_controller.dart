import 'dart:convert';
import 'package:adventure_rides/data/repositories/tour_guide/guide_repository.dart';
import 'package:get/get.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';

class GuidesFavouritesController extends GetxController {
  static GuidesFavouritesController get instance => Get.find();

  ///variables
  final favourites = <String, bool>{}.obs;
  final guideRepository = Get.put(GuideRepository);

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  //Method to initialize favourites by reading from storage
  void initFavourites() {
    final json = SLocalStorage.instance().readData('favourites');
    if(json != null){
      final storeFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(storeFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }
  bool isFavourite(String productId){
    return favourites[productId] ?? false;
  }
  //Add products in the favourite
  void toggleFavouriteProduct(String productId){
    if(!favourites.containsKey(productId)){
      favourites[productId] = true;
      saveFavoritesToStorage();
      SLoaders.customToast(message: 'Tour Guide has been added to the WishList.');
    } else {
      SLocalStorage.instance().removeData(productId);
      favourites.remove(productId);
      saveFavoritesToStorage();
      favourites.refresh();
      SLoaders.customToast(message: 'Tour Guide has been removed from the WishList.');
    }
  }
  void saveFavoritesToStorage(){
    final encodeFavourites = json.encode(favourites);
    SLocalStorage.instance().saveData('favorites', encodeFavourites);
  }
  /*
  //To get the guides from firebase
  Future<List<TourGuideModel>> availableGuides() async{
    return await guideRepository.getExperiencedGuides(favourites.keys.toList());
  }

   */
}