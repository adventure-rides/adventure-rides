import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../data/repositories/car/car_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/car_model.dart';

class AllCarsController extends GetxController {
  static AllCarsController get instance => Get.find();

  final repository = CarRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<CarModel> cars = <CarModel>[].obs;

  Future<List<CarModel>> fetchCarsByQuery(Query? query) async {
    try{
      if(query == null) return [];

      final cars = await repository.fetchCarsByQuery(query);
      return cars;

    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void sortCars (String sortOption){
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        cars.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Higher Price':
        cars.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Lower Price':
        cars.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Booking' :
        cars.sort((a, b) {
          if(b.bookingPrice > 0){
            return b.bookingPrice.compareTo(a.bookingPrice);
          }else if (a.bookingPrice > 0) {
            return -1;
          } else {
            return 1;
          }
        } );
        break;
        /*
      case 'Guide Rating':
        cars.sort((a, b) => b.guideRating.compareTo(a.guideRating));
        break;

         */
      default:
      // Default sorting option: Car Name
        cars.sort((a, b) => a.title.compareTo(b.title));
    }
  }
  void assignCars(List<CarModel> cars) {
    //Assign cars to the 'cars' list
    this.cars.assignAll(cars);
    sortCars('Name');
  }
}