import 'package:adventure_rides/features/book/models/tour_guide_model.dart';
import 'package:adventure_rides/features/book/screens/guide_details/responsive_screens/desktop/desktop_guide_detail.dart';
import 'package:adventure_rides/features/book/screens/guide_details/responsive_screens/mobile/mobile_guide_detail.dart';
import 'package:adventure_rides/features/book/screens/guide_details/responsive_screens/tablet/tablet_guide_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../../authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';
import '../../controllers/car/cart_controller.dart';

class GuideDetailScreen extends StatelessWidget {
  GuideDetailScreen({super.key, required this.guide}) {
    Get.put(CartController());
  }

  final TourGuideModel guide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: FixedScreenAppbar(),
    body:SSiteTemplate(useLayout: false, desktop: DesktopGuideDetail(guide: guide), tablet: TabletGuideDetail(guide: guide), mobile: MobileGuideDetail(guide: guide)));
  }
}
