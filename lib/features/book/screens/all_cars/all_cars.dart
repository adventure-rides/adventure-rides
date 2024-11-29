import 'package:adventure_rides/common/widgets/layouts/templates/site_layout.dart';
import 'package:adventure_rides/features/book/screens/all_cars/desktop/all_cars_desktop.dart';
import 'package:adventure_rides/features/book/screens/all_cars/mobile/all_cars_mobile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/car_model.dart';

class AllCars extends StatelessWidget {
  const AllCars({super.key, required this.title, this.query, this.futureMethod});
  final String title;
  final Query? query;
  final Future<List<CarModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    return SSiteTemplate(useLayout: false, desktop: AllCarsDesktop(title: title, query: query, futureMethod: futureMethod), mobile: AllCarsMobile(title: title, query: query, futureMethod: futureMethod));
  }
}
