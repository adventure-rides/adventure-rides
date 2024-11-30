import 'package:flutter/material.dart';
import 'package:adventure_rides/common/widgets/layouts/templates/site_layout.dart';
import 'package:adventure_rides/features/book/screens/booking/desktop/booking_desktop.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SSiteTemplate(useLayout: false, desktop: BookingScreenDesktop());
  }
}
