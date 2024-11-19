import 'dart:convert';
import 'package:get/get.dart';
import '../../../../data/repositories/car/car_repository.dart';
import '../../../../data/repositories/tour_guide/guide_repository.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/car_model.dart';
import '../../models/tour_guide_model.dart'; // Import your TourGuideModel

class FavouritesController extends GetxController {
  static FavouritesController get instance => Get.find();

  /// Variables
  final favourites = <String, bool>{}.obs; // For tracking favourite cars and guides

  // Observable lists for favorite cars and guides
  final favoriteCarsList = <CarModel>[].obs;
  final favoriteGuidesList = <TourGuideModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initFavourites();
  }

  // Method to initialize favourites by reading from storage
  void initFavourites() {
    final json = SLocalStorage.instance().readData('favourites');
    if (json != null) {
      final storedFavourites = jsonDecode(json) as Map<String, dynamic>;
      favourites.assignAll(storedFavourites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }

  // Add products in the favourite
  void toggleFavouriteCar(String productId) {
    if (!favourites.containsKey(productId)) {
      favourites[productId] = true;
      saveFavoritesToStorage();
      SLoaders.customToast(message: 'Car has been added to the WishList.');
    } else {
      favourites.remove(productId);
      saveFavoritesToStorage();
      SLoaders.customToast(message: 'Car has been removed from the WishList.');
    }
  }

  // New method to toggle favorite for guides
  void toggleFavouriteGuide(String guideId) {
    if (!favourites.containsKey(guideId)) {
      favourites[guideId] = true;
      saveFavoritesToStorage();
      SLoaders.customToast(message: 'Guide has been added to the WishList.');
    } else {
      favourites.remove(guideId);
      saveFavoritesToStorage();
      SLoaders.customToast(message: 'Guide has been removed from the WishList.');
    }
  }

  void saveFavoritesToStorage() {
    final encodeFavourites = json.encode(favourites);
    SLocalStorage.instance().saveData('favourites', encodeFavourites); // Fix the key to 'favourites'
  }

  // To get the cars from Firebase
  Future<List<CarModel>> favoriteCars() async {
    return await CarRepository.instance.getFavouriteCars(favourites.keys.toList());
  }

  // New method to get favorite guides
  Future<List<TourGuideModel>> favoriteGuides() async {
    return await GuideRepository.instance.getFavouriteGuides(favourites.keys.toList());
  }
}
