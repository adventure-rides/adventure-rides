import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:get/get.dart';
import '../../../../data/repositories/tour_guide/guide_repository.dart';
import '../../../../utils/popups/loaders.dart';

class GuideController extends GetxController {
  static GuideController get instance => Get.find();

  final isLoading = false.obs;
  final guideRepository = Get.put(GuideRepository());
  RxList<TourGuideModel> availableGuides = <TourGuideModel>[].obs;

  @override
  void onInit() {
    fetchAvailableGuides();
    super.onInit();
  }
  void fetchAvailableGuides() async {
    try {
      // Show loader while fetching guides
      isLoading.value = true;

      // Fetch guides from the repository
      final guides = await guideRepository.getAvailableGuides();

      // Assign fetched guides to the observable list
      availableGuides.assignAll(guides);

    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<TourGuideModel>> getAllAvailableGuides() async {
    try {
      // Fetch all available guides
      final guides = await guideRepository.getAvailableGuides();
      return guides;

    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Get the guide's fee
  String getGuideFee(TourGuideModel guide) {
    return guide.guideFee.toString();
  }

  /// Calculate discount percentage if sale price is present
  String? calculateSalePercentage(double originalFee, double? saleFee) {
    if (saleFee == null || saleFee <= 0.0) return null;
    if (originalFee <= 0) return null;

    double percentage = ((originalFee - saleFee) / originalFee) * 100;
    return percentage.toStringAsFixed(0);
  }

  /// Check guide's availability status
  String getGuideAvailabilityStatus(bool isAvailable) {
    return isAvailable ? 'Available' : 'Not available';
  }
}
