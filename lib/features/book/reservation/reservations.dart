import 'package:adventure_rides/features/book/reservation/desktop/reservation_desktop.dart';
import 'package:adventure_rides/features/book/reservation/mobile/reservation_mobile.dart';
import 'package:flutter/material.dart';
import 'package:adventure_rides/common/widgets/layouts/templates/site_layout.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SSiteTemplate(
      useLayout: false,
      desktop: ReservationDesktop(),
      mobile: ReservationMobile(),
    );
  }
}