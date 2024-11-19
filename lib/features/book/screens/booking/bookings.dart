import 'package:adventure_rides/features/book/screens/booking/widgets/bookings_list.dart';
import 'package:flutter/material.dart';
import '../../../../common/appbar/appbar.dart';
import '../../../../utils/constraints/sizes.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Appbar
      appBar: SAppBar(title: Text('My Bookings', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: const Padding(
          padding: EdgeInsets.all(SSizes.defaultSpace),

        ///Bookings
        child: SBookingListItems(),
      ),
    );
  }
}
