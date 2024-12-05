import 'package:get/get.dart';
import '../../../data/repositories/advert/advert_repository.dart';
import '../../book/models/advert_model.dart';

class AdvertController extends GetxController {
  final AdvertRepository repository = AdvertRepository();
  final double clickValue = 0.05; // Revenue per click
  final double impressionValue = 0.001; // Revenue per impression
  RxList<AdvertModel> adverts = <AdvertModel>[].obs;

  // Fetch adverts from the repository
  Future<void> fetchAdverts() async {
    adverts.value = await repository.fetchAdverts();
  }

  // Log a click
  Future<void> logClick(String advertId) async {
    await repository.logClick(advertId, clickValue);
  }

  // Log an impression
  Future<void> logImpression(String advertId) async {
    await repository.logImpression(advertId, impressionValue);
  }
}
