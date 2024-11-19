import 'package:get/get.dart';
import '../../../../data/repositories/car/car_repository.dart';
import '../../../../utils/constraints/enums.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/car_model.dart';

class CarController extends GetxController {
  static CarController get instance => Get.find();

  final isLoading = false.obs;
  final carRepository = Get.put(CarRepository());
  RxList<CarModel> featuredCars = <CarModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedCars();
    super.onInit();
  }
  void fetchFeaturedCars() async {
    try {
      //Show loader while fetching cars
      isLoading.value = true;
      //Fetch Cars
      final cars = await carRepository.getFeaturedCars();

      //Assign Cars
      featuredCars.assignAll(cars);

    }catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  Future<List<CarModel>> getAllFeaturedCars() async {
    try {
      //Fetch Cars
      final cars = await carRepository.getFeaturedCars();
      return cars;
    }catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
  ///Get the car price  or price range for variations
  String getCarPrice(CarModel car) {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    //If no variation exist, return the simple price or sale
    if(car.carType == CarType.single.toString()){
      return (car.bookingPrice > 0 ? car.bookingPrice : car.price).toString();
    } else {
      //Calculate the smallest and largest prices among variations
      for (var variation in car.carVariations!) {
        //Determine the price to consider (sale price if available, otherwise regular price
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        //update smallest and largest prices
        if(priceToConsider < smallestPrice){
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }
      //if smallest and the largest prices are the same, return a single price
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toString();
      }else {
        //Otherwise, return a price range
        return '$smallestPrice - \$$largestPrice';
      }
    }
  }
  ///Calculate discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice){
    if (salePrice == null || salePrice<= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice -salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }
  ///Check Car stock status
  String getCarNoAvailableStatus(int stock){
    return stock > 0 ? 'Available' : 'Not available';
  }
}