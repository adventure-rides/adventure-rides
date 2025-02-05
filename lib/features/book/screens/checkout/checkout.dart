import 'package:adventure_rides/features/book/screens/checkout/responsive_screens/desktop/desktop_checkout.dart';
import 'package:adventure_rides/features/book/screens/checkout/responsive_screens/mobile/mobile_checkout.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/layouts/templates/site_layout.dart';
import '../../../authentication/screens/home/other_screens_appbar/fixed_screen_appbar.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: FixedScreenAppbar(title: 'Booking Review'),
        body: SSiteTemplate(useLayout: false, desktop: DesktopCheckout(), tablet:DesktopCheckout(), mobile: MobileCheckout()));
  }
}