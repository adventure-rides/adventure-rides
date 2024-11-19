import 'package:adventure_rides/features/authentication/screens/home/widgets/responsive_screens/home_desktop_tablet.dart';
import 'package:adventure_rides/features/authentication/screens/home/widgets/responsive_screens/home_mobile.dart';
import 'package:flutter/material.dart';
import '../../../../../common/widgets/layouts/templates/site_layout.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(useLayout: false, desktop: HomeScreenDesktop(), mobile: HomeScreenMobile());

  }
}
