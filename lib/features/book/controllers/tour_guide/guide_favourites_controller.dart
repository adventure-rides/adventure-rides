import 'dart:convert';
import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/tour_guide/guide_repository.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';

class GuideFavouritesController extends GetxController {
  static GuideFavouritesController get instance => Get.find();

  ///variables
  final favourites = <String, bool>{}.obs;

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
  bool isFavourite(String guideId){
    return favourites[guideId] ?? false;
  }
  //Add products in the favourite
  void toggleFavouriteGuide(String guideId){
    if(!favourites.containsKey(guideId)){
      favourites[guideId] = true;
      saveFavoritesToStorage();
      SLoaders.customToast(message: 'Tour Guide has been added to the WishList.');
    } else {
      SLocalStorage.instance().removeData(guideId);
      favourites.remove(guideId);
      saveFavoritesToStorage();
      favourites.refresh();
      SLoaders.customToast(message: 'Tour Guide has been removed from the WishList.');
    }
  }
  void saveFavoritesToStorage(){
    final encodeFavourites = json.encode(favourites);
    SLocalStorage.instance().saveData('favorites', encodeFavourites);
  }
  //To get the cars from firebase
  Future<List<TourGuideModel>> favoriteGuides() async{
    return await GuideRepository.instance.getFavouriteGuides(favourites.keys.toList());
  }
}