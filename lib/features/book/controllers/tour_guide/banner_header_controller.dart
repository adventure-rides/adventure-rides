import 'dart:async';
import 'package:get/get.dart';
import '../../../../data/repositories/banners/banner_repository.dart';
import '../../../../utils/popups/loaders.dart';
import '../../models/banner_model.dart';

class BannerHeaderController extends GetxController {
  final isLoading = false.obs;
  final carousalCurrentIndex = 0.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;
  late Timer _timer;
  final titlesUpdated = false.obs;

  @override
  void onInit() {
    fetchBanners();
    startCarouselTimer();
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void startCarouselTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      carousalCurrentIndex.value =
          (carousalCurrentIndex.value + 1) % banners.length;
    });
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;
      final bannerRepo = Get.put(BannerRepository());
      final fetchedBanners = await bannerRepo.fetchBanners();

      banners.assignAll(fetchedBanners);

      if (!titlesUpdated.value) {
        _updateInitialBannerTexts();
        titlesUpdated.value = true;
      }
    } catch (e) {
      SLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _updateInitialBannerTexts() {
    updateBannerText(0, 'FIND THE PERFECT \nCAR FOR YOUR JOURNEY.',
        'EXPLORE VEHICLES', '/vehicles');
    updateBannerText(1, 'CHAUFFEUR-DRIVEN \nVEHICLES INSTANTLY.',
        'BOOK A VEHICLE', '/book-vehicle');
    updateBannerText(2, 'DISCOVER BEST SERVICES \nFOR YOUR JOURNEY.',
        'BOOK YOUR RIDE', '/book-ride');
    updateBannerText(3, 'LUXURY \nEXPERIENCE.',
        'VIEW OUR CARS', '/view-cars');
    updateBannerText(4, 'ADVENTURE AWAITS \nWITH OUR GUIDES.',
        'EXPLORE GUIDES', '/explore-guides');
    updateBannerText(5, 'RIDE IN ELEGANCE WITH \nOUR EXCLUSIVE \nCHAUFFEUR SERVICE.',
        'RESERVE NOW', '/reserve');
  }

  void updateBannerText(int index, String title, String buttonText,
      String buttonTargetScreen) {
    if (index >= 0 && index < banners.length) {
      final currentBanner = banners[index];
      banners[index] = BannerModel(
        imageUrl: currentBanner.imageUrl,
        title: title,
        buttonText: buttonText,
        buttonTargetScreen: buttonTargetScreen,
        active: true, targetScreen: '',
      );
      banners.refresh();
    }
  }
}