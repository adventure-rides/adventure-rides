import 'package:get/get.dart';
import '../../../data/repositories/banners/banner_repository.dart';
import '../../../utils/popups/loaders.dart';
import '../models/banner_model.dart';

class BannerController extends GetxController {
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(int index) {
    carousalCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners(); // Fetch banners with title and buttonText
      this.banners.assignAll(banners);
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // New method to update the title and button text for a specific banner
  void updateBannerText(int index, String title, String buttonText, String buttonTargetScreen) {
    if (index >= 0 && index < banners.length) {
      // Create a new instance with updated title and button text
      final currentBanner = banners[index];
      banners[index] = BannerModel(
        imageUrl: currentBanner.imageUrl, // Preserve the existing image URL
        targetScreen: currentBanner.targetScreen, // Preserve the existing target screen
        title: title,
        buttonText: buttonText, // Update button text
        buttonTargetScreen: buttonTargetScreen,
        active: true,
      );
    }
  }
}