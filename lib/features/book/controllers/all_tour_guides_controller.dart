import 'package:adventure_rides/data/repositories/tour_guide/guide_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../utils/popups/loaders.dart';
import '../models/tour_guide_model.dart';

class AllTourGuidesController extends GetxController {
  static AllTourGuidesController get instance => Get.find();

  final repository = GuideRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<TourGuideModel> tourGuides = <TourGuideModel>[].obs;

  Future<List<TourGuideModel>> fetchGuidesByQuery(Query? query) async {
    try{
      if(query == null) return [];

      final guides = await repository.fetchGuidesByQuery(query);
      return guides;

    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  void sortGuides (String sortOption){
    selectedSortOption.value = sortOption;

    switch (sortOption) {
      case 'Name':
        tourGuides.sort((a, b) => a.tName.compareTo(b.tName));
        break;
      case 'Higher Fee':
        tourGuides.sort((a, b) => b.guideFee.compareTo(a.guideFee));
        break;
      case 'Lower Fee':
        tourGuides.sort((a, b) => a.guideFee.compareTo(b.guideFee));
        break;
      case 'Experience':
        tourGuides.sort((a, b) {
          if (b.experience > 0) {
            return b.experience.compareTo(a.experience);
          } else if (a.experience > 0) {
            return -1;
          } else {
            return 1;
          }
        });
        break;
      case 'Guide Rating':
        tourGuides.sort((a, b) => b.guideRating.compareTo(a.guideRating));
        break;
      default:
       // Default sorting option: Tour Guide Name
        tourGuides.sort((a, b) => a.tName.compareTo(b.tName));
    }
  }
  void assignGuides(List<TourGuideModel> guides) {
    //Assign tour guides to the 'guides' list
    tourGuides.assignAll(guides);
    sortGuides('Name');
  }
}